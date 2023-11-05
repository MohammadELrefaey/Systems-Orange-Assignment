//
//  JsonMapper.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import Foundation

class JsonMapper {
    
    static func getObjectsFromFile<T: Decodable>(filePath: String, completion: @escaping (T?, MappingError?) -> ()) {
       do {
           // creating a path for folder
           if let bundlePath = Bundle.main.url(forResource: filePath, withExtension: "json") {
               
               let jsonData = try Data(contentsOf: bundlePath)
               let objects = try JSONDecoder().decode(T.self, from: jsonData)
               completion(objects, nil)
           }
           else {
               completion(nil, .failedToFindDataFile)
           }
           
       } catch { error
           if let err = error as? DecodingError {
               print(err.localizedDescription)
               completion(nil, .failedToGetContent)
           }
       }
   }
    
}
