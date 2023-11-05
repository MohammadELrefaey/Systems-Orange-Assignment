//
//  ResponseModel.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//


import Foundation

class AlmofireResponse {
    
    private var callback : ((_ result: Result<Data,Error>?) -> Void)?

    
    var result: Result<Data,Error>? {
        didSet {
            self.callback?(result)
        }
    }
    
    
    func report(_ callback: @escaping (Result<Data,Error>?) -> Void) {
        self.callback = callback
    }

}
