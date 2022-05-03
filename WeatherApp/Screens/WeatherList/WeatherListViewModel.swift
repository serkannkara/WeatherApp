//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Serkan on 30.04.2022.
//

import Foundation

protocol WeatherListViewModelProtocol {
    var weather: [Weathers] { get set }
    var service: WeatherServiceProtocol { get set }
    var weatherOutput: WeatherListOutput? { get }
    func setDelegate(output: WeatherListOutput)
    func getWeathers(userLocation: String)
    func changeLoading()
}
    

protocol WeatherListOutput {
    func changeLoading(isLoad: Bool)
    func fetchDatas(values: [Weathers])
}


class WeatherListViewModel: WeatherListViewModelProtocol {
    var weather: [Weathers] = []
    var service: WeatherServiceProtocol
    var weatherOutput: WeatherListOutput?
    
    private var isLoading = false
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func getWeathers(userLocation: String) {
        changeLoading()
        service.fetchWeathers(userLocation: userLocation) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                self.changeLoading()
                self.weather = weather
                self.weatherOutput?.fetchDatas(values: self.weather)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setDelegate(output: WeatherListOutput) {
        weatherOutput = output
    }
    
    func changeLoading() {
        isLoading = !isLoading
        weatherOutput?.changeLoading(isLoad: isLoading)
    }
    
}
