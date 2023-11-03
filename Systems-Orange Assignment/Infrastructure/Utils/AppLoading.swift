//
//  AppLoading.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import UIKit

class AppLoading {
        
    static func setup() {
        ProgressHudBridge.setup()
    }
    
    static func show() {
        ProgressHudBridge.loading()
    }
    
    static func hide() {
        ProgressHudBridge.hiding()
    }
    
}
