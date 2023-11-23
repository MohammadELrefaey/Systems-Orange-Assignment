//
//  Data+Converter.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

extension Data {
    
    public func convertToJson() -> [String : Any]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
        return json
    }
    
    public func convertToJsonArray() -> [[String : Any]]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [[String : Any]]
        return json
    }
    
    public func convertTo<T: Decodable>(to: T.Type) -> T?{
        let decoder = JSONDecoder()
        return  try? decoder.decode(to.self, from: self)
    }
    
}
