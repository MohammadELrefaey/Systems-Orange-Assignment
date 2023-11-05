//
//  MoviesLocalRepo.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

protocol MoviesLocalRepo {
    
    func fetchMovies(request: MoviesInOut.GetMovies.Request?, response: ((MoviesInOut.GetMovies.Response?)->())?)
}
