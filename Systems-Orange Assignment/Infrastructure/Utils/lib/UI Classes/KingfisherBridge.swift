//
//  KingfisherBridge.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import UIKit
import Kingfisher

class KingfisherBridge {
        
    static func setImage(img: UIImageView ,val: String?) {
        if let url = URL.init(string: val ?? "") {
            img.kf.setImage(with: url)
        }
    }
    
}
