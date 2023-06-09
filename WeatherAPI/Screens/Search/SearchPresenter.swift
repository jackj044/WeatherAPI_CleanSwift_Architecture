//
//  SearchPresenter.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.


import UIKit

protocol SearchPresentationProtocol {
    func searchPlaceDataWith(model: [SearchResponse])
    func apiCallForSearchPlace(query: String)
}

final class SearchPresenter: SearchPresentationProtocol {
    
    weak var viewController: SearchProtocol?
    var interactor: SearchInteractorProtocol?
    
    // MARK: Presenter API call
    
    func searchPlaceDataWith(model: [SearchResponse]) {
        
        if let viewController {
            viewController.searchPlaceDataWith(model: model)
        }
    }
    
    func apiCallForSearchPlace(query: String) {
        interactor?.apiCallForSearchPlace(query: query)
    }
}
