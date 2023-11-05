//
//  MovieDetailsInteractorTests.swift
//  Systems-Orange AssignmentTests
//
//  Created by Refaey on 05/11/2023.
//

import XCTest
@testable import Systems_Orange_Assignment

class MovieDetailsInteractorTests: XCTestCase {
    
    
    func testFetchPhotos() {
        let mockRemoteDataManager = MockMoviesRemoteRepo()
        
        let interactor = MovieDetailstInteractor(remoteDataManager: mockRemoteDataManager)

        let mockPresenter = MockDetailsPresenter()
        interactor.presenter = mockPresenter

        interactor.fetchPhotos(page: 1, query: "Movie", limit: 10)

        // Check if the fetchPhotos method called the remote data manager
        XCTAssertTrue(mockRemoteDataManager.fetchPhotosCalled)
        
        // Check if the request parameters are correct
        XCTAssertNotNil(mockRemoteDataManager.fetchPhotosRequest?.query)
        XCTAssertNotNil(mockRemoteDataManager.fetchPhotosRequest?.page)
        XCTAssertNotNil(mockRemoteDataManager.fetchPhotosRequest?.perPage)

        // Check if the presenter methods were called with the correct data
        XCTAssertTrue(mockPresenter.fetchedSuccessfullyCalled)
        XCTAssertFalse(mockPresenter.fetchingFailedCalled)
        XCTAssertNil(mockPresenter.fetchedError)
    }
}


//MARK: - Mocks
class MockDetailsPresenter: MovieDetailsInteractorOutputProtocol {
    func fetchedSuccessfuly(data: [Systems_Orange_Assignment.MoviePhotoModel]?) {
        fetchedSuccessfullyCalled = true
        fetchedData = data
    }
    
    func fetchingFailed(withError error: Systems_Orange_Assignment.RError) {
        fetchingFailedCalled = true
        fetchedError = error

    }
    
    var fetchingFailedCalled = false
    var fetchedSuccessfullyCalled = false
    var fetchedData: [MoviePhotoModel]?
    var fetchedError: RError?

}

class MockMoviesRemoteRepo: MoviesRemoteRepo {
    
    var fetchPhotosCalled = false
    var fetchPhotosRequest: MoviesInOut.GetPhotos.Request?
    var fetchPhotosResponse: ((MoviesInOut.GetPhotos.Response?) -> ())?

    func fetchPhotos(request: Systems_Orange_Assignment.MoviesInOut.GetPhotos.Request?, response: ((Systems_Orange_Assignment.MoviesInOut.GetPhotos.Response?) -> ())?) {
        fetchPhotosCalled = true
        fetchPhotosRequest = request
        fetchPhotosResponse = response

        let photos = [MoviePhotoModel]()
        let responseModel = MoviesInOut.GetPhotos.Response(list: photos, error: nil)

        response?(responseModel)

    }

}
