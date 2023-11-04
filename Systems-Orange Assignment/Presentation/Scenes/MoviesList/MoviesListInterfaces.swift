//
//  MoviesListInterfaces.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

protocol MoviesListViewProtocol: BaseViewProtocol { //View Controller
    
}

protocol MoviesListPresenterProtocol { // Bussiness Logic
    var page: Int {get set}
    var getLimit: Bool {get set}
    var moviesCategories: [MoviesCategory] {get}

    func fetchMovies(query: String?)
//    func getMoviesByYear(_ index: Int) -> [MovieModel]?
}

protocol MoviesListInteractorInputProtocol { // func do it from presenter
     
    func fetchMovies(page: Int, query: String?, limit: Int)
}

protocol MoviesListInteractorOutputProtocol: AnyObject { // called when interactor finished
    func fetchedSuccessfuly(data: [MovieModel]?)
    func fetchingFailed(withError error: RError)
    
}

protocol MoviesListRouterProtocol { // Navigation
     
}
