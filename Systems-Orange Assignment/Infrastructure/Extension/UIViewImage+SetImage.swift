//
//  UIViewImage+SetImage.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import UIKit

extension UIImageView {
    
     func setImage(val: String?) {
         let url = val?.replacingOccurrences(of: " ", with: "%20")
         KingfisherBridge.setImage(img: self, val: url)
     }

    
}
