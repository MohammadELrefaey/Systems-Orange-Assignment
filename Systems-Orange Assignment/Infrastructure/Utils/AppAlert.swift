//
//  AppAlert.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import UIKit

class AppAlert {
        
    static func showSuccessMessage(title: String = "", message: String = "", ok: (()->())? = nil) {
        //you may implement tap gesture
        AlertClass2.showMessageSuccess22(vc: nil, title: title, message: message, infoTap: nil)
        
    }
    
    static func showError(title: String = "", message: String = "", ok: (()->())? = nil) {
        //you may implement tap gesture
        AlertClass2.showMessageError22(vc: nil, title: title, message: message, infoTap: nil)
    }
    
    static func showInternetError(message: String = "") {
        //you may implement tap gesture
        AlertClass2.ShowErrorStatusBar2(vc: nil, message: message)
    }
    
    static func showWarning(title: String = "", message: String = "", ok: (()->())? = nil) {
        //you may implement tap gesture
        AlertClass2.ShowWarningMessage(vc: nil,title: title, message: message, interact: false, type: .cardView)
    }
    
    static func showInfo(title: String = "", message: String = "", ok: (()->())? = nil) {
        //you may implement tap gesture
        AlertClass2.showMessageInfo(vc: nil, title: title, message: message, infoTap:  nil)
    }
    
}
