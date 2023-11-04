//
//  CategoryModel.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//

import Foundation

class MoviesCategory {
    var year: Int?
    var movies: [MovieModel]?
    
    init(year: Int? = nil, movies: [MovieModel]? = nil) {
        self.year = year
        self.movies = movies
    }

}
