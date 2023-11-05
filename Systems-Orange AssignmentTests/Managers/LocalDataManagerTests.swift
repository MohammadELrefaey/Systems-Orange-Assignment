//
//  LocalDataManagerTests.swift
//  Systems-Orange AssignmentTests
//
//  Created by Refaey on 02/11/2023.
//

import XCTest
@testable import Systems_Orange_Assignment

import XCTest

class LocalDataManagerTests: XCTestCase {
    var sut: MoviesLocalRepo!
    
    override func setUp() {
        super.setUp()
        sut = MoviesLocalDataManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    // testing getMovies
    func test_getMovies() {
        // Given
        let promise = XCTestExpectation(description: "Fetch Movies")
        var responseError: RError?
        var responseMoviesList: [MovieModel]?
        
        // When
        let request = MoviesInOut.GetMovies.Request(query: "")

        sut.fetchMovies(request: request) { response in
            if let movies = response?.list {
                responseMoviesList = movies
                promise.fulfill()
            } else {
                responseError = response?.error
                promise.fulfill()

            }
        }

        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseMoviesList)
    }
}
