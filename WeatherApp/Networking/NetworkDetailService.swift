//
//  NetworkDetailService.swift
//  WeatherApp
//
//  Created by Serkan on 3.05.2022.
//

import Foundation
import Alamofire


protocol WeatherDetailServiceProtocol {
    func fetchConsoleWeather(with cityId: Int, completion: @escaping (Result<[ConsoleWeather], NetworkError>) -> Void)
    func fetchWeathersDetail(with cityId: Int, completion: @escaping (Result<Detail, NetworkError>) -> Void)
}

public class WeatherDetailService: WeatherDetailServiceProtocol {
    
    func fetchConsoleWeather(with locationId: Int, completion: @escaping (Result<[ConsoleWeather], NetworkError>) -> Void) {
        
        let baseUrl = WeatherAPI.fetchDetailAndConsole.baseUrlDetailAndConsole(locationId: locationId)
        
        guard let url = URL(string: baseUrl) else { return }
        
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Detail.self, from: data)
                    completion(.success(response.consoleWeather))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchWeathersDetail(with locationId: Int, completion: @escaping (Result<Detail, NetworkError>) -> Void) {
        
        let baseUrl = WeatherAPI.fetchDetailAndConsole.baseUrlDetailAndConsole(locationId: locationId)
        
        guard let url = URL(string: baseUrl) else { return }
        
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Detail.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
