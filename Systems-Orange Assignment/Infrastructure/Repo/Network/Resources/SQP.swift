//
//  SQP.swift
//  Majdona
//
//  Created by Mahmoud on 4/30/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
//SimpleRequestParamter
struct SQP {
    var parameters: [String: String?]?
    var httpMethod: String?
    var header: [String: String]?
    var url: String?
    var bodyData: Data?
}
