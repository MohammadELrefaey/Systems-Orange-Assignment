//
//  IQKeyboardBridge.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import IQKeyboardManager

class IQKeyboardMBridge {
    
    static func isEnable(val: Bool) {
        IQKeyboardManager.shared().isEnabled = val
        IQKeyboardManager.shared().isEnableAutoToolbar = val
    }
    
}
