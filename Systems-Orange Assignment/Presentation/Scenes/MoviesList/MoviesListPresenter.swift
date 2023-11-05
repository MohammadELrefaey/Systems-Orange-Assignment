//
//  MoviesListPresenter.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class MoviesListPresenter:BasePresenter, MoviesListPresenterProtocol, MoviesListInteractorOutputProtocol {
    
    //MARK: - Properties
    weak private var view: MoviesListViewProtocol?
    private let interactor: MoviesListInteractorInputProtocol
    private var router: MoviesListRouterProtocol
    
    var isSearchMode: Bool = false
    var moviesCategories: [MoviesCategory] = [MoviesCategory]()

    //MARK: - Initializers
    init(view: MoviesListViewProtocol, interactor: MoviesListInteractorInputProtocol, router: MoviesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Interactor Output Protocol
    func fetchedSuccessfuly(data: [MovieModel]?) {

        if let data = data {
            if isSearchMode {
                categorizeMovies(movies: data, completion: { [weak self] categories in
                    guard let self = self else {return}
                    self.moviesCategories = categories
                    self.prepareCategoriesForView()
                    self.view?.finishLoading()
                    self.view?.success()
                })
            } else {
                let category = MoviesCategory(movies: data)
                self.moviesCategories = [category]
                self.view?.finishLoading()
                self.view?.success()
            }
        } else {
            view?.finishLoading()
            view?.emptyDataFound()
        }
    }
    
    func fetchingFailed(withError error: RError) {
        view?.finishLoading()
        self.checkError(error: error) { [weak self] message in
            guard let self = self else {return}
            self.view?.showNetworkError(message: message)
        } serverError: { [weak self] message in
            guard let self = self else {return}
            self.view?.showServerError(message: message)
        } normalError: { [weak self] message in
            guard let self = self else {return}
            self.view?.showError(message: message)
        }

    }

    
    //MARK: - Presenter Protocol
    func fetchMovies(query: String?) {
        isSearchMode = (query != nil && query != "")

        view?.startLoading()
        interactor.fetchMovies(query: query)
    }
    
    func goToDetails(index: IndexPath) {
        let movie = moviesCategories[index.section].movies?[index.row]
        router.goToDetails(from: view, movie: movie)
    }

    //MARK: - Private Methods
    private func categorizeMovies(movies: [MovieModel], completion: @escaping ([MoviesCategory]) -> Void ) {
        
        var movieCategories: [MoviesCategory] = []
        
        for movie in movies {
            // Check if the year already exists in the category
            if let existingCategoryIndex = movieCategories.firstIndex(where: { $0.year == movie.year }) {
                // Append the movie to the existing category
                movieCategories[existingCategoryIndex].movies?.append(movie)
            } else {
                // Create a new movie category for the year and add the movie
                let newCategory = MoviesCategory(year: movie.year, movies: [movie])
                movieCategories.append(newCategory)
            }
            
        }
        completion(movieCategories)
    }
    
    private func prepareCategoriesForView() {
        for category in moviesCategories {

            if let sortedMovies = category.movies?.sorted( by: {($0.rating ?? 0) > ($1.rating ?? 0) }) { // sort the movies of year by rate
                category.movies = Array(sortedMovies.prefix(5)) // get high-rated movies
            } else {

            }
        }

    }
}
