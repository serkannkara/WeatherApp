//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Serkan on 1.05.2022.
//

import Foundation


protocol WeatherDetailViewModelProtocol {
    var consolerWeather: [ConsoleWeather] { get set}
    var detail: Detail? { get set }
    var service: WeatherDetailServiceProtocol { get set }
    var consoleOutPut: WeatherDetailOutput? { get}
    func getConsoleWeather(cityId: Int)
    func getDetailWeather(cityId: Int)
    func changeLoading()
    func setDelegate(output: WeatherDetailOutput)
}


protocol WeatherDetailOutput {
    func changeLoadin(isLoad: Bool)
    func fetchConsoleData(values: [ConsoleWeather])
    func fetchDetailData(detail: Detail)
}


class WeatherDetailViewModel: WeatherDetailViewModelProtocol {
    
    var detail: Detail?
    var consolerWeather: [ConsoleWeather] = []
    var service: WeatherDetailServiceProtocol
    var consoleOutPut: WeatherDetailOutput?
    
    private var isLoading = false
    
    init(service: WeatherDetailServiceProtocol = WeatherDetailService()) {
        self.service = service
    }
    
    func getConsoleWeather(cityId: Int) {
        changeLoading()
        service.fetchConsoleWeather(with: cityId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let consolerWeather):
                self.changeLoading()
                self.consolerWeather = consolerWeather
                self.consoleOutPut?.fetchConsoleData(values: consolerWeather)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDetailWeather(cityId: Int) {
        changeLoading()
        service.fetchWeathersDetail(with: cityId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let detail):
                self.changeLoading()
                self.detail = detail
                self.consoleOutPut?.fetchDetailData(detail: detail)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        consoleOutPut?.changeLoadin(isLoad: isLoading)
    }
    
    func setDelegate(output: WeatherDetailOutput) {
        consoleOutPut = output
    }
}
