//
//  SearchRequest.swift
//  WeatherPOC
//
//  Created by Jatin Patel on 6/7/23.
//

import Foundation

struct SearchRequest {
    
    let keyword: String
    
    var toJSON: [String: Any] {
        
        return ["q": keyword,
                "limit": 100,
                "appid": OpenWeatherApiKey]
    }
}
