//
//  NetworkMiddleware.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import Alamofire


class NetworkAdministration {
    
    lazy private var defaultSession: Session = {
        let configuration = Alamofire.URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.URLSessionConfiguration.default.httpAdditionalHeaders
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Alamofire.Session.init(configuration:configuration)
    }()
    
    func request<T>(request: AlmofireRequest<T>) -> AlmofireResponse? {
        let FutureResult = AlmofireResponse()
        
        defaultSession.request(request.asURLRequest()).validate().response { response in
            self.verifyResponseData(FutureResult: FutureResult, response: response)
        }
        return FutureResult
        
    }
    
    private func verifyResponseData(FutureResult: AlmofireResponse, response: AFDataResponse<Data?>) {
        
        if let data = response.data {
            print(data.convertToJson() as Any)
            FutureResult.result = .success(response.data!)

        } else {
            if let error = response.error {
                FutureResult.result = .failure(error)
                print(error.localizedDescription)
            }else {
                FutureResult.result = .failure(NetworkError.unknownError("Unknown"))
                print(NetworkError.unknownError("Unknown").localizedDescription)
            }
        }
        
        
        if let error = self.verifyError(response: response) {
            FutureResult.result = .failure(error)
            print(error.localizedDescription)
            return
        }
        
    }
    
    private func verifyError(response: AFDataResponse<Data?>) -> NetworkError? {
        
        // these for this app only remove it if required
        
        if let _ = response.error, (response.error as NSError?)?.code == -999 {
            return .cancelled
        }
        
        if let _ = response.error, (response.error as NSError?)?.code == -1009 {
            return .noInternetConnection
        }
        
        guard let _ = response.data else {
            return .invalidData
        }
        
        if let response = response.response, case 500...511 = response.statusCode {
            return .internalServerError
        }
        
        if let response = response.response, response.statusCode == 401 {
            return .unauthorized
        }

        if let _ = response.error, response.response?.statusCode == 404 {
            return .unknownError("Error Occur")
        }
        
        return nil
    }
    
}
