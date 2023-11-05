//
//  MovieDetailsPresenter.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class MovieDetailsPresenter:BasePresenter, MovieDetailsPresenterProtocol, MovieDetailsInteractorOutputProtocol {
    
    //MARK: - Properties
    weak private var view: MovieDetailsViewProtocol?
    private let interactor: MovieDetailsInteractorInputProtocol
    private var router: MovieDetailsRouterProtocol
    
    var page: Int = 1
    var isLastPage: Bool = false
    var movie: MovieModel?
    var photos: [MoviePhotoModel] = [MoviePhotoModel]()

    //MARK: - Initializers
    init(view: MovieDetailsViewProtocol, interactor: MovieDetailsInteractorInputProtocol, router: MovieDetailsRouterProtocol, movie: MovieModel?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
    
    //MARK: - Interactor Output Protocol
    func fetchedSuccessfuly(data: [MoviePhotoModel]?) {
        if let data = data {
            self.view?.finishLoading()
            self.photos.append(contentsOf: data)
            self.view?.success()

            //handle pagination
            self.isLastPage = data.count < 20

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
    func fetchPhotos() {
        view?.startLoading()
        interactor.fetchPhotos(page: page, query: movie?.title, limit: 20)
    }
    
    func fetchNextPage() {
        if !isLastPage {
            view?.startLoading()
            interactor.fetchPhotos(page: page + 1, query: movie?.title, limit: 20)
        } else {
            view?.finishLoading()
        }
    }
    
    func getPhotoPath(index: Int) -> String? {
        let photo = photos[index]
        return ImageUrlConstructor.construct(farm: photo.farm, server: photo.server, id: photo.id, secret: photo.secret)
    }

    func getMovieViewModel() -> MovieViewModel {
        return MovieViewModel(movie: self.movie)
    }
    
}
