//
//  APISettings.swift
//  WeatherApp
//
//  Created by Serkan on 1.05.2022.
//

import Foundation


protocol APISetting {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameterUserLocation: String { get }
    func baseUrlWeather(userLocation: String) -> String
    func baseUrlDetailAndConsole(locationId: Int) -> String
}
