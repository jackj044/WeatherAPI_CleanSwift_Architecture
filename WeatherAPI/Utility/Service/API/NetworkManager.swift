//
//  NetworkManager.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.
//

import Foundation
import Moya

protocol Networkable {
    
    var provider: MoyaProvider<APIRouter> { get }
    func fetchWeather(param: WeatherRequest, completion: @escaping (Result<WeatherData, Error>) -> ())
    func getSearchData(param: SearchRequest, completion: @escaping (Result<[SearchResponse], Error>) -> ())
}

final class NetworkManager: Networkable {
    
    let provider = MoyaProvider<APIRouter>(plugins: [NetworkLoggerPlugin()])
    
    func fetchWeather(param: WeatherRequest, completion: @escaping (Result<WeatherData, Error>) -> ()) {
        request(target: .fetchWeather(param), completion: completion)
    }
    
    func getSearchData(param: SearchRequest, completion: @escaping (Result<[SearchResponse], Error>) -> ()) {
        request(target: .getSearchData(param), completion: completion)
    }
}

extension NetworkManager {
    
    private func request<T: Decodable>(target: APIRouter, completion: @escaping (Result<T, Error>) -> ()) {
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
