//
//  Weathers.swift
//  WeatherApp
//
//  Created by Serkan on 28.04.2022.
//

import Foundation


struct Weathers: Decodable {
    let id: Int
    let title: String
    let locationType: String
    let lattLong: String
    let distance: Int
    let consoleWeather: Detail?
    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case lattLong = "latt_long"
        case distance
        case id = "woeid"
        case consoleWeather
    }
}


