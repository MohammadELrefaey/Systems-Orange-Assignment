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
        
        getObjectsFromFile(filePath: "movies") { (objects: MoviesListModel?, error: Error?) in
            if let parsedObject = objects  {
                if let query = request?.query?.lowercased(), query != "" {
                    responseModel.list = parsedObject.movies?.filter({$0.title?.lowercased().contains(query) ?? false})
                } else {
                    responseModel.list = parsedObject.movies
                }
            } else if let err = error as? NetworkError {
                responseModel.error = RError.init()
                responseModel.error?.desc = err.errorDescription
                responseModel.error?.fullError = err

            }
            response?(responseModel)

        }

    }

    
    private func getObjectsFromFile<T: Decodable>(filePath: String, completion: @escaping (T?, Error?) -> ()) {
        do {
            // creating a path from the main bundle and getting data object from the path
            if let bundlePath = Bundle.main.url(forResource: filePath, withExtension: "json") {
                
                let jsonData = try Data(contentsOf: bundlePath)
                // Decoding the Product type from JSON data using JSONDecoder() class.
                let objects = try JSONDecoder().decode(T.self, from: jsonData)
                completion(objects, nil)
            }
            
        } catch { error
            print(error.localizedDescription)
            completion(nil, error)
        }
    }

}
