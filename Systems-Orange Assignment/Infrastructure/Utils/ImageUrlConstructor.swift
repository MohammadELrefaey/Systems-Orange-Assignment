//
//  ImageUrlConstructor.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import Foundation

class ImageUrlConstructor {
    
    static func construct(farm: Int?, server: String?, id: String?, secret: String?) -> String {
       return "https://farm\(farm ?? 0).static.flickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "").jpg"
    }
}
