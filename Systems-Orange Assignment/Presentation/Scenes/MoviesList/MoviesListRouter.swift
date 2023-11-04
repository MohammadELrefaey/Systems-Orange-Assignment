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
        let interactor = MoviesListInteractor(localDataManager: MoviesLocalDataManager(), remoteDataManager: MoviesRemoteDataManager())
        let router = MoviesListRouter()
        let presenter = MoviesListPresenter(view: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }

}
