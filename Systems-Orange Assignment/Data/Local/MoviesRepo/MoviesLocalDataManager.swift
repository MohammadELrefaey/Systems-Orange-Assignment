//
//  MoviesLocalDataManager.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class MoviesLocalDataManager: MoviesLocalRepo {
   
    
    func fetchMovies(request: MoviesInOut.GetMovies.Request?, response: ((MoviesInOut.GetMovies.Response?)->())?) {
        var responseModel = MoviesInOut.GetMovies.Response()
        
        JsonMapper.getObjectsFromFile(filePath: "movies") { (objects: MoviesListModel?, error: MappingError?) in
            if let parsedObject = objects  {
                if let query = request?.query?.lowercased(), query != "" {
                    responseModel.list = parsedObject.movies?.filter({$0.title?.lowercased().contains(query) ?? false})
                } else {
                    responseModel.list = parsedObject.movies
                }
            } else if let err = error {
                responseModel.error = RError.init()
                responseModel.error?.desc = err.errorDescription
            }
            response?(responseModel)

        }

    }

    

}


