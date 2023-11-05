//
//  MoviesListRouter.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import UIKit
 
class MoviesListRouter: MoviesListRouterProtocol {
    
    private static var storyboard : UIStoryboard {
         return UIStoryboard(name: "Main", bundle: nil)
     }
    
    static func createModule() -> MoviesListViewController {
        let view = storyboard.instantiateViewController(withIdentifier: "\(MoviesListViewController.self)") as! MoviesListViewController
        let interactor = MoviesListInteractor(localDataManager: MoviesLocalDataManager())
        let router = MoviesListRouter()
        let presenter = MoviesListPresenter(view: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    
    func goToDetails(from view: MoviesListViewProtocol?, movie: MovieModel?) {
        let detailsView = MovieDetailsRouter.createModule(movie: movie)
        detailsView.modalTransitionStyle = .coverVertical
        detailsView.modalPresentationStyle = .fullScreen
        if let view = view as? UIViewController {
            view.present(detailsView, animated: true)
        }
    }

}
