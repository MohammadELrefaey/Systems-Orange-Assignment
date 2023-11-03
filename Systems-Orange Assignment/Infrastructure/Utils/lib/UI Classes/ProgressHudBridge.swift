//
//  ZVProgressHubBridge.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import ProgressHUD
import UIKit

class ProgressHudBridge {
    
    static func setup() {
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorAnimation = .systemGray
    }
    
    static func loading(vc: UIViewController? = nil) {
        setup()
        ProgressHUD.show()
    }
    
    static func hiding() {
        ProgressHUD.dismiss()
    }
}
