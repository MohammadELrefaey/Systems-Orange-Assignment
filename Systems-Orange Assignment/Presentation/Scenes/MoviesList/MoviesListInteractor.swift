//
//  MoviesListInteractor.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class MoviesListInteractor: MoviesListInteractorInputProtocol {
    
    //MARK: - Properties
    var localDataManager: MoviesLocalRepo
    var remoteDataManager: MoviesRemoteRepo
    weak var presenter: MoviesListInteractorOutputProtocol?
    
    //MARK: - Initializers
    init(localDataManager: MoviesLocalRepo, remoteDataManager: MoviesRemoteRepo) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    
    //MARK: - Interactor Input Protocol Methods
    func fetchMovies(page: Int, query: String?, limit: Int) {
        let request = MoviesInOut.GetMovies.Request(page: page, limitPerPage: limit, query: query)
        localDataManager.fetchMovies(request: request) { response in
            if let error = response?.error {
                self.presenter?.fetchingFailed(withError: error)
            } else {
                self.presenter?.fetchedSuccessfuly(data: response?.list)
            }

        }
    }
    
    
}
