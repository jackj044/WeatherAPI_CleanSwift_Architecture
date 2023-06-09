//
//  HomeScreenAPIUnitTest.swift
//  WeatherAPITests
//
//  Created by Jatin Patel on 6/8/23.
//

import XCTest
@testable import WeatherAPI

final class SearchScreenAPIUnitTest: XCTestCase {
    
    func testSearchLocationScreenGetWeatherDataFromLocationSuceess() {
        
        let networkManager = NetworkManager()
        let searchParam = SearchRequest(keyword: "London")
        let searchExpectation = self.expectation(description: "GetWeatherDataFromLocation")
        
        networkManager.getSearchData(param: searchParam) { result in
            switch result {
            case .success(let locations):
                XCTAssertNotNil(locations)
                XCTAssertEqual(locations[0].name, searchParam.keyword)
                searchExpectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error.localizedDescription)
                searchExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testSearchLocationGetWeatherDataFromLocationFailuer(){
        
        let networkManager = NetworkManager()
        let searchParam = SearchRequest(keyword: "")
        let searchExpectation = self.expectation(description: "GetWeatherDataFromLocation")
        
        networkManager.getSearchData(param: searchParam) { result in
            switch result {
            case .success(let locations):
                XCTAssertNil(locations)
                searchExpectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error.localizedDescription)
                searchExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
}




