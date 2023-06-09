//
//  APIRouter.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.
//

import Foundation
import Moya

enum APIRouter {
    case fetchWeather(_ param: WeatherRequest)
    case getSearchData(_ param: SearchRequest)
}

extension APIRouter: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/")!
    }

    var path: String {
        switch self {
        case .fetchWeather:
            return "data/2.5/weather"
        case .getSearchData:
            return "geo/1.0/direct"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWeather, .getSearchData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWeather (let param):
            return .requestParameters(parameters: param.toJSON, encoding: URLEncoding.default)
        case .getSearchData(let param):
            return .requestParameters(parameters: param.toJSON, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type":"application/json"]
    }
    
    var sampleData: Data { return Data() }
}
