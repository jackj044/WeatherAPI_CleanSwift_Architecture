//
//  SearchInteractor.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.


import UIKit

protocol SearchInteractorProtocol {
    func apiCallForSearchPlace(query: String)
}

final class SearchInteractor: SearchInteractorProtocol {
    
    private let networkManager = NetworkManager()
    var presenter: SearchPresentationProtocol?
    
    // MARK: Protocol Implementation
    
    func apiCallForSearchPlace(query: String) {
        
        let request = SearchRequest(keyword: query)
        
        networkManager.getSearchData(param: request) { result in
            switch result {
            case .success(let data):
                self.presenter?.searchPlaceDataWith(model: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
