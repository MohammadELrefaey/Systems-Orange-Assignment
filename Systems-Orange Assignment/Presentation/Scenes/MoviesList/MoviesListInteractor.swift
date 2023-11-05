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
    weak var presenter: MoviesListInteractorOutputProtocol?
    
    //MARK: - Initializers
    init(localDataManager: MoviesLocalRepo) {
        self.localDataManager = localDataManager
    }
    
    //MARK: - Interactor Input Protocol Methods
    
    func fetchMovies(query: String?) {
        let request = MoviesInOut.GetMovies.Request(query: query)
        localDataManager.fetchMovies(request: request) { response in
            if let error = response?.error {
                self.presenter?.fetchingFailed(withError: error)
            } else {
                self.presenter?.fetchedSuccessfuly(data: response?.list)
            }

        }
    }
    
    
}
