//
//  MoviesRemoteDataManager.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class MoviesRemoteDataManager: MoviesRemoteRepo {
    var network: NetworkAdministration = NetworkAdministration()

    func fetchPhotos(request: MoviesInOut.GetPhotos.Request?, response: ((MoviesInOut.GetPhotos.Response?) -> ())?) {
        var requestModel = GetPhotoRequest()
        requestModel.text = request?.query?.description
        requestModel.page = request?.page?.description
        requestModel.per_page = request?.perPage?.description
        requestModel.format = "json"
        requestModel.nojsoncallback = 1.description
        requestModel.method = "flickr.photos.search"
        requestModel.api_key = ApiConstants.apiKey
        
        let urlRequest = AlmofireRequest<GetPhotoRequest>(value: requestModel)
        urlRequest.path = URLs.photos
        urlRequest.method = .get
        
        var responseModel = MoviesInOut.GetPhotos.Response()
        self.network.request(request: urlRequest)?.report({ result in
            switch result {
               case .success(let data) :
                let parsedJson = data.convertTo(to: MoviesPhotosResponse.self)
                responseModel.list = parsedJson?.photos?.photos

                break
               case .failure(let error):
                let err = error as? NetworkError
                responseModel.error = RError.init()
                responseModel.error?.desc = err?.errorDescription
                responseModel.error?.fullError = err
                   break
               case .none:
                   break

               }
            response?(responseModel)
           })
    }

    
}
