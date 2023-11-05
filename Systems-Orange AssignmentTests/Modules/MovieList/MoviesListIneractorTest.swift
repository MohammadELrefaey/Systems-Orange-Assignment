//
//  MoviesListIneractorTest.swift
//  Systems-Orange AssignmentTests
//
//  Created by Refaey on 05/11/2023.
//

import XCTest
@testable import Systems_Orange_Assignment

class MoviesListInteractorTests: XCTestCase {
    
    var interactor: MoviesListInteractor!
    var localDataManagerMock: MockMoviesLocalRepo!
    var presenterMock: MockMoviesListInteractorOutputProtocol!
    
    override func setUp() {
        super.setUp()
        localDataManagerMock = MockMoviesLocalRepo()
        presenterMock = MockMoviesListInteractorOutputProtocol()
        interactor = MoviesListInteractor(localDataManager: localDataManagerMock)
        interactor.presenter = presenterMock
    }
    
    override func tearDown() {
        interactor = nil
        localDataManagerMock = nil
        presenterMock = nil
        super.tearDown()
    }
    
    func testFetchMovies_WithQuery_SuccessfulResponse() {
        
        // Given
        let query = "Action"
        let movies = [MovieModel]()
        let response = MoviesInOut.GetMovies.Response(list: movies, error: nil)
        localDataManagerMock.fetchMoviesCompletionHandler = { _, completionHandler in
            completionHandler!(response)
        }
        
        // When
        interactor.fetchMovies(query: query)
        
        // Then
        XCTAssertEqual(localDataManagerMock.fetchMoviesRequest?.query, query)
        XCTAssertTrue(presenterMock.fetchedSuccessfullyCalled)
        XCTAssertFalse(presenterMock.fetchingFailedCalled)
        XCTAssertNil(presenterMock.fetchingFailedError)
    }
    
    func testFetchMovies_WithQuery_FailedResponse() {
        // Arrange
        let query = "Comedy"
        let response = MoviesInOut.GetMovies.Response(list: nil, error: RError())
        localDataManagerMock.fetchMoviesCompletionHandler = { _, completionHandler in
            completionHandler!(response)
        }
        
        // Act
        interactor.fetchMovies(query: query)
        
        // Assert
        XCTAssertEqual(localDataManagerMock.fetchMoviesRequest?.query, query)
        XCTAssertTrue(presenterMock.fetchingFailedCalled)
        XCTAssertFalse(presenterMock.fetchedSuccessfullyCalled)
        XCTAssertNil(presenterMock.fetchedSuccessfullyData)
    }
}

//MARK: - Mock classes for testing
class MockMoviesLocalRepo: MoviesLocalRepo {

    
    var fetchMoviesRequest: MoviesInOut.GetMovies.Request?
    var fetchMoviesCompletionHandler:  ((MoviesInOut.GetMovies.Request?, ((MoviesInOut.GetMovies.Response?) -> Void)?) -> Void)?
    
    func fetchMovies(request: MoviesInOut.GetMovies.Request?, response: ((MoviesInOut.GetMovies.Response?) -> ())?) {
        fetchMoviesRequest = request
        fetchMoviesCompletionHandler?(request, response)
    }
}

class MockMoviesListInteractorOutputProtocol: MoviesListInteractorOutputProtocol {
    
    var fetchedSuccessfullyCalled = false
    var fetchedSuccessfullyData: [MovieModel]?
    var fetchingFailedCalled = false
    var fetchingFailedError: RError?
    
    func fetchedSuccessfuly(data: [MovieModel]?) {
        fetchedSuccessfullyCalled = true
        fetchedSuccessfullyData = data
    }
    
    func fetchingFailed(withError error: RError) {
        fetchingFailedCalled = true
        fetchingFailedError = error
    }
}
