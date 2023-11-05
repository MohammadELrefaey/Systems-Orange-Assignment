//
//  MoviesListInterfaces.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

protocol MoviesListViewProtocol: BaseViewProtocol { //View Controller
    
}

protocol MoviesListPresenterProtocol { // Bussiness Logic
    var isSearchMode: Bool {get} // detect if search started or not
    var moviesCategories: [MoviesCategory] {get}

    func fetchMovies(query: String?)
    func goToDetails(index: IndexPath)
}

protocol MoviesListInteractorInputProtocol { // func do it from presenter
     
    func fetchMovies(query: String?)
}

protocol MoviesListInteractorOutputProtocol: AnyObject { // called when interactor finished
    func fetchedSuccessfuly(data: [MovieModel]?)
    func fetchingFailed(withError error: RError)
    
}

protocol MoviesListRouterProtocol { // Navigation
    func goToDetails(from view: MoviesListViewProtocol?, movie: MovieModel?)

}
