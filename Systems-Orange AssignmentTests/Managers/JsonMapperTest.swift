//
//  JsonMapperTest.swift
//  Systems-Orange AssignmentTests
//
//  Created by Refaey on 05/11/2023.
//

import XCTest
@testable import Systems_Orange_Assignment

import XCTest

class JsonMapperTest: XCTestCase {
    
    
    func test_successfully_decodes() {
        JsonMapper.getObjectsFromFile(filePath: "movies", completion: { (objects: MoviesListModel?, error: MappingError?) in
            // Assert that the objects are not nil
            XCTAssertNotNil(objects, "Objects should not be nil")
            // Assert that the error is nil
            XCTAssertNil(error, "Error should be nil")

        })

    }
    
    func test_missing_files() {
        JsonMapper.getObjectsFromFile(filePath: "movies", completion: { (objects: MoviesListModel?, error: MappingError?) in

            XCTAssertNotEqual(error, .failedToFindDataFile)
        })

    }

    

}
