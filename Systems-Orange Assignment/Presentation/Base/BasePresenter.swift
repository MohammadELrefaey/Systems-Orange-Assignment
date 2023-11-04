//
//  BasePresenter.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class BasePresenter {
    
    // abstract class to handle error in fetching data
    
    func checkError(error: RError,networkError: ((String)->())? = nil, serverError: ((String)->())? = nil, normalError: ((String)->())? = nil) {

        let err = error.fullError as? NetworkError
            print(err?.localizedDescription)
            if err?.errorDescription == NetworkError.noInternetConnection.errorDescription {
                networkError?(AppGlobalStrings.internetErrorDesc)
            }else if err?.errorDescription == NetworkError.internalServerError.errorDescription {
                serverError?(AppGlobalStrings.serverErrorDesc)
            }else if err?.errorDescription == NetworkError.unauthorized.errorDescription {
                //handle unauthorized user
                normalError?(err?.errorDescription ?? "")
                
            }else {
                if (error.desc ?? "") != "" {
                    normalError?(error.desc!)
                }else {
                    normalError?(AppGlobalStrings.errorDesc)
                }
            }

    }
    
    
}
