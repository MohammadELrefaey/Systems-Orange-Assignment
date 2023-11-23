//
//  NetworkRequest.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import Alamofire


public class NetworkRequest<T: Encodable> {
   
    //MARK: - Properties
    private var parameters: T
    public var method: HttpMethod!
    public var path: String!
    public var sendInBody: Bool?
    public var headers: [String: Any]?

    //MARK: - Initializer
    public init(method: HttpMethod = .get, path: String = "", header: [String: Any]? = nil, parameters: T, sendInBody: Bool? = false) {
        self.method = method
        self.path = path
        self.headers = header
        self.parameters = parameters
        self.sendInBody = sendInBody
    }
    
    //MARK: - Methods
    func asURLRequest() -> URLRequest {
        //- Adding Path
        let urlpatharabic = path.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url : URL = URL.init(string: urlpatharabic!) ?? URL(fileURLWithPath: "")
        
        //- Creating URL Request with Path
        var urlRequest = URLRequest(url: url)
        
        //- Adding Headers
        urlRequest = appendHeader(headers: headers, to: urlRequest)
        
        //- Adding HTTP Method (without relying on Alamofire's HTTPMethod)
        urlRequest.httpMethod = getHttpMehod(value: method)
        
        //- Adding Parameters
        if sendInBody == true {
            urlRequest.httpBody = getBody(from: parameters)
        } else {
            urlRequest.url = getEncodedUrl(from: parameters)
        }
        
        print("URL IS \(String(describing: urlRequest.url))")
        print("URL REQUEST METHOD IS \(String(describing: urlRequest.httpMethod))")
        print("URL REQUEST HEADERS IS \(String(describing: headers))")

        return urlRequest
    }
    
    
}

//MARK: - Private Methods
extension NetworkRequest {
    
    private func appendHeader(headers: [String: Any]?, to: URLRequest) -> URLRequest {
        var urlRequest = to
        if let headers = headers {
            for key in headers.keys{
                urlRequest.addValue(headers[key] as! String, forHTTPHeaderField: key)
            }
        }
        return urlRequest
    }
    
    private func getHttpMehod(value: HttpMethod) -> HTTPMethod.RawValue {
        switch value {
        case .get:
            return HTTPMethod.get.rawValue
        case .post:
            return HTTPMethod.post.rawValue
        case .delete:
            return HTTPMethod.delete.rawValue
        case .patch:
            return HTTPMethod.patch.rawValue
        case .put:
            return HTTPMethod.put.rawValue
            
        }
    }
    
    private func getBody(from parameters: T) -> Data { //- encode parameters to json data
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(parameters)
        if let jsonData = jsonData {
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            print("URL REQUEST BODY IS \(String(describing: parameters as AnyObject))")

            return  json?.data(using: .utf8) ?? Data()
        }
        return Data()
    }
    
    
    private func getEncodedUrl(from: T) -> URL {
        var url = URL(string: path)!
        let mirror = Mirror(reflecting: from)
        for child in mirror.children  {
            let name = child.label!
            let value = child.value as? [String]
            if value != nil {
                for item in value!{
                    let value = item.replacedArabicDigitsWithEnglish
                    if value != "" {
                        url = url.appending(name + "[]", value: value)
                    }
                }
            }else {
                let val = child.value as? String
                let value = val?.replacedArabicDigitsWithEnglish
                if (value ?? "") != "" {
                    url = url.appending(name, value: value)
                }
            }
        }
        return url
    }
    
}

