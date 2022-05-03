//
//  ConsoleWeathers.swift
//  WeatherApp
//
//  Created by Serkan on 29.04.2022.
//

import Foundation


struct ConsoleWeather: Decodable {
    let weatherStateName: String
    let weatherStateImageId: String
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
    let theDate: String
    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case weatherStateImageId = "weather_state_abbr"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case theDate = "applicable_date"
    }
}
