//
//  AppUserDefault.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.
//

import Foundation

public protocol StoryboardIDProvider: RawRepresentable where Self.RawValue == String {
}
enum Storyboard: String, StoryboardIDProvider {
    case main = "Main"
}


let AppUserDefaults = UserDefaults.standard
let DispatchQueueMain = DispatchQueue.main

let UserDefaultSelectedLocation = "selectedLocation"

let NoResultFoundMessage = "No Results Found!"

let DefaultLatitude = 35.7327
let DefaultLongitude = 78.8503

let CloudImageBaseURL = "https://openweathermap.org/img/wn/"

let OpenWeatherApiKey = "9132575dc29af24a1addf2f411f5e447"

