//
//  MoviesPhotosResponse.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//

import Foundation

struct MoviesPhotosResponse : Codable {
    let photos : MoviesPhotosListModel?

    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent(MoviesPhotosListModel.self, forKey: .photos)

    }

}



struct MoviesPhotosListModel : Codable {
    let photos : [MoviePhotoModel]?

    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent([MoviePhotoModel].self, forKey: .photos)

    }

}



struct MoviePhotoModel : Codable {
	let id : String?
	let owner : String?
	let secret : String?
	let server : String?
	let farm : Int?
	let title : String?
	let ispublic : Int?
	let isfriend : Int?
	let isfamily : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case owner = "owner"
		case secret = "secret"
		case server = "server"
		case farm = "farm"
		case title = "title"
		case ispublic = "ispublic"
		case isfriend = "isfriend"
		case isfamily = "isfamily"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		owner = try values.decodeIfPresent(String.self, forKey: .owner)
		secret = try values.decodeIfPresent(String.self, forKey: .secret)
		server = try values.decodeIfPresent(String.self, forKey: .server)
		farm = try values.decodeIfPresent(Int.self, forKey: .farm)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		ispublic = try values.decodeIfPresent(Int.self, forKey: .ispublic)
		isfriend = try values.decodeIfPresent(Int.self, forKey: .isfriend)
		isfamily = try values.decodeIfPresent(Int.self, forKey: .isfamily)
	}

}
