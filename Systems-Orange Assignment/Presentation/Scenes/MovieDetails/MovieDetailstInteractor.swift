//
//  MovieDetailsInteractor.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class MovieDetailstInteractor: MovieDetailsInteractorInputProtocol {
    
    //MARK: - Properties
    var remoteDataManager: MoviesRemoteRepo
    weak var presenter: MovieDetailsInteractorOutputProtocol?
    
    //MARK: - Initializers
    init(remoteDataManager: MoviesRemoteRepo) {
        self.remoteDataManager = remoteDataManager
    }
    
    //MARK: - Interactor Input Protocol Methods
    func fetchPhotos(page: Int, query: String?, limit: Int) {
        let request = MoviesInOut.GetPhotos.Request(query: query, page: page, perPage: limit)
        remoteDataManager.fetchPhotos(request: request) { response in
            if let error = response?.error {
                self.presenter?.fetchingFailed(withError: error)
            } else {
                self.presenter?.fetchedSuccessfuly(data: response?.list)
            }

        }
    }
    
    
}
