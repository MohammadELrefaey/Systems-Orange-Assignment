//
//  UIView+Borders.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//

import UIKit

extension UIView {
    
    func applyDefaultBor() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height:3 )
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
    }
    

    
}
