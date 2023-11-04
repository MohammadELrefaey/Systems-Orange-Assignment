//
//  MoviesInOut.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

struct MoviesInOut {
    
    struct GetMovies {
        struct Request {
            var page: Int?
            var limitPerPage: Int?
            var query: String?
        }
        
        struct Response {
            var list: [MovieModel]?
            var error: RError?
        }
    }
}
