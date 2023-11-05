//
//  MovieDetailsInterfaces.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

protocol MovieDetailsViewProtocol: BaseViewProtocol { //View Controller
    
}

protocol MovieDetailsPresenterProtocol { // Bussiness Logic
    var movie: MovieModel? {get}
    var photos: [MoviePhotoModel] {get}

    func fetchPhotos()
    func fetchNextPage()
    func getPhotoPath(index: Int) -> String?
    func getMovieViewModel() -> MovieViewModel
}

protocol MovieDetailsInteractorInputProtocol { // func do it from presenter
     
    func fetchPhotos(page: Int, query: String?, limit: Int)
}

protocol MovieDetailsInteractorOutputProtocol: AnyObject { // called when interactor finished
    func fetchedSuccessfuly(data: [MoviePhotoModel]?)
    func fetchingFailed(withError error: RError)
    
}

protocol MovieDetailsRouterProtocol { // Navigation
     
}
