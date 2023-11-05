//
//  MoviesRemoteRepo.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

protocol MoviesRemoteRepo {
    func fetchPhotos(request: MoviesInOut.GetPhotos.Request?, response: ((MoviesInOut.GetPhotos.Response?)->())?)
}
