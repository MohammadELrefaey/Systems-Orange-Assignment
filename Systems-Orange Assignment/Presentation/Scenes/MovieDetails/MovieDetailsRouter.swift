//
//  MovieDetailsRouter.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import UIKit
 
class MovieDetailsRouter: MovieDetailsRouterProtocol {
    
    
    private static var storyboard : UIStoryboard {
         return UIStoryboard(name: "Main", bundle: nil)
     }
    
    static func createModule(movie: MovieModel?) -> MovieDetailsViewController {
        let view = storyboard.instantiateViewController(withIdentifier: "\(MovieDetailsViewController.self)") as! MovieDetailsViewController
        let interactor = MovieDetailstInteractor(remoteDataManager: MoviesRemoteDataManager())
        let router = MovieDetailsRouter()
        let presenter = MovieDetailsPresenter(view: view, interactor: interactor, router: router, movie: movie)
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }

}
