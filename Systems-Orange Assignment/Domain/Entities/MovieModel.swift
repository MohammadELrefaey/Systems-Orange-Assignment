//
//  MovieModel.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation


struct MoviesListModel : Codable {
    let movies : [MovieModel]?

    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([MovieModel].self, forKey: .movies)

    }

}

struct MovieModel : Codable {
	let title : String?
	let year : Int?
	let cast : [String]?
	let genres : [String]?
	let rating : Int?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case year = "year"
		case cast = "cast"
		case genres = "genres"
		case rating = "rating"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
		cast = try values.decodeIfPresent([String].self, forKey: .cast)
		genres = try values.decodeIfPresent([String].self, forKey: .genres)
		rating = try values.decodeIfPresent(Int.self, forKey: .rating)
	}

}
