//
//  MoviesInOut.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

struct MoviesInOut {
    //this is absrtacion struct to declare the requests and response will used by useCases/interactors
    
    
    //MARK: - Get Movies
    struct GetMovies {
        struct Request {
            var query: String?
        }
        
        struct Response {
            var list: [MovieModel]?
            var error: RError?
        }
    }
    
    //MARK: - Get Photos
    struct GetPhotos {
        struct Request {
            var query: String?
            var page: Int?
            var perPage: Int?
        }
        
        struct Response {
            var list: [MoviePhotoModel]?
            var error: RError?
        }
    }

}
