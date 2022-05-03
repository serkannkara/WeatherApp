//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Serkan on 1.05.2022.
//

import Foundation


enum WeatherAPI {
    case fetchWeather
    case fetchDetailAndConsole
}


extension WeatherAPI: APISetting {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "www.metaweather.com"
    }
    
    var path: String {
        return "/api/location"
    }
    
    var parameterUserLocation: String {
        return "/search/?lattlong="
    }
    
    func baseUrlWeather(userLocation: String) -> String {
        return "\(scheme)://\(host)\(path)\(parameterUserLocation)\(userLocation)"
    }
    
    func baseUrlDetailAndConsole(locationId: Int) -> String {
        return "\(scheme)://\(host)\(path)/\(locationId)"
    }
    
    
}
