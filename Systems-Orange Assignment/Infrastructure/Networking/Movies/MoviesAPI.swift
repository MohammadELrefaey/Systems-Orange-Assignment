//
//  UsersAPI.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

protocol MoviesAPIProtocol {
    func getMovies(completion: @escaping(Result<[MovieModel]?, NSError>) -> Void)
}

class MoviesAPI: BaseAPI<MoviesRouter>, MoviesAPIProtocol {
    
    // MARK: Requests
    
    func getMovies(completion: @escaping(Result<[MovieModel]?, NSError>) -> Void){
        self.fetchData(target: .getUsers, responseClass: [MovieModel].self) { (result) in
            completion(result)
        }
    }
    
}



