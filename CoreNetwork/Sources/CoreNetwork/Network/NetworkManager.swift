//
//  NetworkManager.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import Alamofire


public class NetworkManager {
    
    //MARK: - Properties
    lazy private var defaultSession: Session = {
        let configuration = AF.sessionConfiguration
        configuration.httpAdditionalHeaders = AF.sessionConfiguration.httpAdditionalHeaders
        configuration.timeoutIntervalForResource = 30
        configuration.timeoutIntervalForRequest = 30
        return Alamofire.Session.init(configuration:configuration)
    }()

    //MARK: - Initializer
    public init() {}
    
    //MARK: - Public Methods
    public func request<T>(request: NetworkRequest<T>, completion: @escaping (Result<Data,Error>?) -> Void) {
        
        let urlRequest = request.asURLRequest()
        defaultSession.request(urlRequest).response { response in
            let handeledResponse = self.handleResponse(response: response)
            completion(handeledResponse)
        }
        
    }
    
    
    //MARK: - Private Methods
    
    private func handleResponse(response: AFDataResponse<Data?>) -> Result<Data,Error>? {
        
        if let data = response.data {
            print("RESPONSE IS \(data.convertToJson() as Any)")
            return .success(response.data!)

        } else {
            if let error = self.handleError(response: response) {
                print(error.localizedDescription)
                return .failure(error)
                                
            } else {
                print(NetworkError.unknownError("Unknown").localizedDescription)
                return .failure(NetworkError.unknownError("Unknown"))
            }
        }
        
    }
    
    private func handleError(response: AFDataResponse<Data?>) -> NetworkError? {

        if checkNetworkConnectivity() {
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

        } else {
            return .noInternetConnection
        }
    }
    
    private func checkNetworkConnectivity() -> Bool {
        
        var isConnected = false
        NetworkReachabilityManager()?.startListening(onQueue: .main, onUpdatePerforming: { networkStatus in
            
            isConnected = networkStatus == .reachable(.cellular) || networkStatus == .reachable(.ethernetOrWiFi)
        })
        

        return isConnected
    }
    
}
