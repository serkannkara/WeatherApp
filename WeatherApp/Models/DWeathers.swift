//
//  DWeathers.swift
//  WeatherApp
//
//  Created by Serkan on 1.05.2022.
//

import Foundation


struct Detail: Decodable {
    let title: String
    let type: String
    let time: String
    let timezone: String
    let parent: Parent?
    let consoleWeather: [ConsoleWeather]
    enum CodingKeys: String, CodingKey {
        case consoleWeather = "consolidated_weather"
        case title
        case type = "location_type"
        case time
        case timezone
        case parent
    }
}

struct Parent: Decodable {
    let title: String?
}
