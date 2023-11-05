//
//  MovieViewModel.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import Foundation

struct MovieViewModel {
    let title : String?
    let year : String?
    let cast : String?
    let genres : String?
    let rating : String?

    init(movie: MovieModel?) {
        self.title = movie?.title
        self.year = movie?.year?.description
        self.cast = movie?.cast?.joined(separator: ", ")
        self.genres = movie?.genres?.joined(separator: ", ")
        self.rating = movie?.rating?.description
    }
}
