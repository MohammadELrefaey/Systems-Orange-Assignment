//
//  MappingError.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import Foundation
enum MappingError: Error, LocalizedError {
    
    case failedToGetContent, failedToFindDataFile

    var errorDescription: String? {
        switch self {
        case .failedToGetContent:
            return "Failed To Get Content"
        case .failedToFindDataFile:
            return "Failed To Find Data File"

        }
    }
}
