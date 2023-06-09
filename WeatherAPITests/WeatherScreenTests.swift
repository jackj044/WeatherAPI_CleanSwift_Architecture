//
//  WeatherScreenAPIUnitTest.swift
//  WeatherAPITests
//
//  Created by Jatin Patel on 6/8/23.
//

import XCTest
@testable import WeatherAPI

final class WeatherScreenAPIUnitTest: XCTestCase {
    
    func testGetWeatherFromLocationSuceess() {
        
        let networkManager = NetworkManager()
        let weatherRequest = WeatherRequest(lat: 35.7327, long: 78.8503)
        let searchExpectation = self.expectation(description: "GetWeatherFromLocationSuceess")
        networkManager.fetchWeather(param: weatherRequest) { result in
            switch result {
            case .success(let locations):
                XCTAssertNotNil(locations)
                searchExpectation.fulfill()
            case .failure(let error):
                
                XCTAssertNil(error.localizedDescription)
                searchExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

}
