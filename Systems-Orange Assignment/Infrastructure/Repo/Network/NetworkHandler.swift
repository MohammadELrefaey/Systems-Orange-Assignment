//
//  NetworkHandler.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkHandlerProtocol {
    
    func request(request: URLRequest)
    
}

protocol NetworkHandlerDelegate : AnyObject {
    func didAddRequest(request: Request)
}


class NetworkHandler {
    
    private var manager: Session?
    private weak var delegate: NetworkHandlerDelegate?
    init(manager: Session? = nil, delegate: NetworkHandlerDelegate?) {
        self.manager = manager ?? Alamofire.Session.default
        self.delegate = delegate
        
    }
    
    //request with reference
    func request(_ request: URLRequest, debug: Bool = false, my_request: inout Request?) -> AlmofireResponse {
        let FutureResult = AlmofireResponse()
        
        let request = manager?.request(request).validate().response(completionHandler: { response in
            self.verifyResponseData(FutureResult: FutureResult, debug: debug, response: response)

        })
        my_request = request
        if request != nil { delegate?.didAddRequest(request: request!) }
        return FutureResult
    }
    
    
    func request(_ request: URLRequest, debug: Bool = false) -> AlmofireResponse {
        let FutureResult = AlmofireResponse()
        
        let request = manager?.request(request).validate().response { response in
            self.verifyResponseData(FutureResult: FutureResult, debug: debug, response: response)
            
        }
        if request != nil { delegate?.didAddRequest(request: request!) }
        return FutureResult
    }
    
    
    
    func upload(files: [File]?, to request: URLRequest, debug: Bool = false) -> AlmofireResponse {
        
        let FutureResult = AlmofireResponse()
        let request = manager?.upload(multipartFormData: { (formData) in
            if let files = files {
                files.forEach { file in
                    formData.append(file.data, withName: file.key, fileName: file.name, mimeType: file.mimeType.rawValue)
                }
            }
        }, with: request).downloadProgress(closure: { progress in
            FutureResult.loading = progress.fractionCompleted
        }).response(completionHandler: { response in
            if let encodingError = response.error {
                FutureResult.result = .failure(encodingError)
            }else {
                self.verifyResponseData(FutureResult: FutureResult, debug: debug, response: response)
            }
            
        })
        if request != nil { delegate?.didAddRequest(request: request!) }
        return FutureResult
    }
    
    
    
    func download(file: File, url: URLRequest, debug: Bool) -> AlmofireResponse {
        
        let FutureResult = AlmofireResponse()
        
        let destination: DownloadRequest.Destination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let extensionFile = file.mimeType.getFileExtension()
            documentsURL.appendPathComponent(file.name + "." + extensionFile)
            return (documentsURL, [.removePreviousFile])
        }
        
        
        let request = manager?.download( url.url!.path,
                                         method: .get,
                                         encoding: JSONEncoding.default,
                                         headers: nil,
                                         to: destination).downloadProgress(closure: { (progress) in
                                            
                                            FutureResult.loading = progress.fractionCompleted
                                            
                                         }).response(completionHandler: { response in
                                            
                                            if debug { if response.resumeData != nil { print(response.resumeData!.convertToJson() as Any) } }
                                            
                                            if response.error != nil {
                                                if let error = response.error {
                                                    FutureResult.result = .failure(error)
                                                    if debug { print(error.localizedDescription) }
                                                }else {
                                                    FutureResult.result = .failure(NetworkError.unknownError("Unknown"))
                                                    if debug { print(NetworkError.unknownError("Unknown").localizedDescription) }
                                                }                                            }else {
                                                FutureResult.result = .success(response.resumeData!)
                                            }
                                         })
        
        if request != nil { delegate?.didAddRequest(request: request!) }
        return FutureResult
    }
    
    
    
    
    
}

extension NetworkHandler {
    
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
        
        
        if let Error  = customError(data: response.data) {
            return Error
        }
        
        if let _ = response.error, response.response?.statusCode == 404 {
            return .unknownError("Error Occur")
        }


        
        //Handle the errors generally from the API according to their defined structure
//        if response.response?.statusCode == 200 {
//            guard let jsonObject = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: AnyObject] else { return .internalServerError }
//            if let success = jsonObject["IsSuccesed"] as? Bool, success != true {
//                if let message = jsonObject["RerurnMessage"] as? String, message != nil {
//                    return .unknownError(message)
//                } else {
//                    return .internalServerError
//                }
//            }
//        }
        
        return nil
    }
    
    
    private func extractPaginationData(from response: AFDataResponse<Data?>) -> NetworkError? {
        guard let _ = response.response?.allHeaderFields as? [String: String] else {
            return .internalServerError
        }
        
        return nil
    }
    
    private func customError(data: Data?) -> NetworkError? {
        
        if let result = data {
            let dictResult = result.convertToJson() //convert to dict
            if dictResult == nil {
                if let str = data?.html2String {
                    return nil
                }
            }
            var status = dictResult?["success"] as? Bool
            if status == nil {
                status = dictResult?["status"] as? Bool
            }
            if status == nil {
                status = Bool(dictResult?["status"] as? String ?? "false") ?? false
            }
            if let status = status {
                if status != true {
                    if let code =  dictResult?["code"] as? Int , code == 401 {
                        return .unauthorized
                    }
                    var err = ""
                    if let messages = dictResult?["validationMessage"] as? [String:Any] {
                        var errors = ""
                        for (_, value) in messages {
                            let arr = value as? Array<Any>
                            for err in arr ?? [] {
                                errors = errors + ((err as? String) ?? "") + "\n"
                            }
                        }
                        err = errors
                    }else {
                        if let message = dictResult?["message"] as? String {
                            err = message
                        }
                        if let message = dictResult?["Message"] as? String {
                            err = message
                        }
                    }
                    
                    return .unknownError(err)
                }else {
                }
            }else {
                
            }
        }
        
        return nil
    }
    
    private func verifyResponseData(FutureResult: AlmofireResponse, debug: Bool, response: AFDataResponse<Data?>) {
        
        if debug { if response.data != nil { print(response.data!.convertToJson() as Any) } }
        FutureResult.resultAnyWay = response.data
        
        if let error = self.verifyError(response: response) {
            FutureResult.result = .failure(error)
            if debug { print(error.localizedDescription) }
            return
        }
        
        if let error = self.extractPaginationData(from: response) {
            FutureResult.result = .failure(error)
            if debug { print(error.localizedDescription) }
            return
        }
        if response.data != nil {
            FutureResult.result = .success(response.data!)
        }else {
            if let error = response.error {
                FutureResult.result = .failure(error)
                if debug { print(error.localizedDescription) }
            }else {
                FutureResult.result = .failure(NetworkError.unknownError("Unknown"))
                if debug { print(NetworkError.unknownError("Unknown").localizedDescription) }
            }
        }
    }
    
    
    
}
