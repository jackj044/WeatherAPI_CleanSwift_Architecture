//
//  WeatherInteractor.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.


import UIKit

protocol WeatherInteractorProtocol {
    func apiCallForWeather(lat: Double, long: Double)
}

final class WeatherInteractor: WeatherInteractorProtocol {
   
    private let networkManager = NetworkManager()
    var presenter: WeatherPresentationProtocol?
    
    // MARK: Protocol Implementation
    
    func apiCallForWeather(lat: Double, long: Double) {
        
        let request = WeatherRequest(lat: lat, long: long)
    
        networkManager.fetchWeather(param: request) { result in
            switch result {
            case .success(let data):
                self.presenter?.weatherDataWith(model: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
