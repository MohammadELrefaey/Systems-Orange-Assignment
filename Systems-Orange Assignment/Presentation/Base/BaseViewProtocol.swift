//
//  BaseProtocol.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import UIKit

protocol BaseViewProtocol: AnyObject, UIViewController {
    
    func startLoading()
    func finishLoading()
    func success()
    func error()
    func networkError(message: String?)
    func serverError(message: String?)
    func emptyDataFound()
    func showSuccess(message: String?)
    func showInfo(message: String?)//popup message
    func showError(message: String?)//popup message
    func showNetworkError(message: String?)//popup message
    func showServerError(message: String?)//popup message

}

extension  BaseViewProtocol { //optional functions
    func startLoading() {}
    func finishLoading() {}
    func success() {}
    func error() {}
    func networkError(message: String?) {}
    func serverError(message: String?) {}
    func emptyDataFound() {}
    func showSuccess(message: String?) {}
    func showInfo(message: String?) {}
    func showError(message: String?) {}
    func showNetworkError(message: String?) {}
    func showServerError(message: String?) {}
}
