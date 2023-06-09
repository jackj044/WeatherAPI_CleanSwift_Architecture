//
//  WeatherPresenter.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.


import UIKit

protocol WeatherPresentationProtocol {
    func weatherDataWith(model: WeatherData)
    func apiCallForWeather(lat: Double, long: Double)
}

final class WeatherPresenter: WeatherPresentationProtocol {
    
    weak var viewController: WeatherProtocol?
    var interactor: WeatherInteractorProtocol?
    
    // MARK: Presenter API call
    
    func apiCallForWeather(lat: Double, long: Double) {
        interactor?.apiCallForWeather(lat: lat, long: long)
    }
    
    func weatherDataWith(model: WeatherData) {
        
        if let viewController {
            viewController.weatherDataWith(weather: model)
        }
    }
}
