//
//  GetPhotoRequest.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//

import Foundation

struct GetPhotoRequest: Codable {
    var api_key: String?
    var method: String?
    var format: String?
    var nojsoncallback: String?
    var text: String?
    var page: String?
    var per_page: String?
}
