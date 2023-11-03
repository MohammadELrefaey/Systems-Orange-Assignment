//
//  UsersNetworking.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

enum MoviesRouter {
    case getUsers
    case getTodos
}

extension MoviesRouter: TargetType {
    
    var baseURL: String {
        switch self {
            
        default: return Constants.BASE_URL
            
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return Constants.END_POINT_GET_USERS
        case .getTodos:
            return Constants.END_POINT_GET_TODOS
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .getTodos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getTodos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUsers:
            return [:]
        case .getTodos:
            return [:]
        }
    }
    
}
