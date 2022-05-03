//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Serkan on 28.04.2022.
//

import Foundation
import UIKit
import Alamofire




protocol WeatherServiceProtocol {
    func fetchWeathers(userLocation: String, completion: @escaping (Result<[Weathers], NetworkError>) -> Void)
}


public class WeatherService: WeatherServiceProtocol {
    func fetchWeathers(userLocation: String, completion: @escaping (Result<[Weathers], NetworkError>) -> Void) {
        
        let baseUrl = WeatherAPI.fetchWeather.baseUrlWeather(userLocation: userLocation)
        
        guard let urlString = URL(string: baseUrl)  else { return }
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([Weathers].self, from: data)
                    completion(.success(response))
                }catch {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


