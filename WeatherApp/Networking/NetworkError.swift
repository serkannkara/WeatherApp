//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Serkan on 1.05.2022.
//

import Foundation

enum NetworkError: String, Error {
    case invalidResponse = "Invalid to response, Please check your internet."
}
