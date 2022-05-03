//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Serkan on 28.04.2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var stackView: UIStackView = {
        let stckView = UIStackView()
        stckView.translatesAutoresizingMaskIntoConstraints = false
        stckView.axis                                      = .vertical
        stckView.distribution                              = .equalSpacing
        return stckView
    }()
    var contentView: UIView = {
        let ctntView = UIView()
        ctntView.translatesAutoresizingMaskIntoConstraints = false
        ctntView.layer.borderWidth                         = 0.8
        ctntView.layer.cornerRadius                        = 10
        ctntView.layer.borderColor = UIColor.systemGray3.cgColor
        ctntView.backgroundColor = UIColor(named: "appColor")
        return ctntView
    }()
    
    var cityName: UILabel = {
        let ctyName = UILabel()
        ctyName.translatesAutoresizingMaskIntoConstraints   = false
        ctyName.textAlignment                               = .center
        ctyName.textColor                                   = .white
        ctyName.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        
        return ctyName
    }()
    
    var timeZone: UILabel = {
        let ctyName = UILabel()
        ctyName.translatesAutoresizingMaskIntoConstraints   = false
        ctyName.textAlignment                               = .center
        ctyName.textColor                                   = .systemGray5
        ctyName.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        return ctyName
    }()
    
    var timeLabel: UILabel = {
        let tmLabel = UILabel()
        tmLabel.translatesAutoresizingMaskIntoConstraints   = false
        tmLabel.textAlignment                               = .center
        tmLabel.textColor                                   = .systemGray6
        tmLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return tmLabel
    }()
    
    var weatherDetailTableView: UITableView = {
        let wthrTableView = UITableView()
        wthrTableView.translatesAutoresizingMaskIntoConstraints = false
        wthrTableView.backgroundColor                           = UIColor(named: "appColor")
        wthrTableView.rowHeight                                 = 80
        wthrTableView.tintColor                                 = .white
        wthrTableView.separatorColor                            = .systemGray3
        wthrTableView.register(WeatherDetailCell.self, forCellReuseIdentifier: WeatherDetailCell.detailReuseId)
        return wthrTableView
    }()
    
    var details: Detail?
    var weatherId: Int?
    
    var consoleWeathers: [ConsoleWeather] = []
    lazy var viewModel      = WeatherDetailViewModel()
    private var indicator   = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "appColor")
        configureStackView()
        configurContentView()
        contentHeader()
        configureTableView()
        configureNavigationBar()
        viewModel.setDelegate(output: self)
        viewModel.getConsoleWeather(cityId: weatherId ?? 44418)
        viewModel.getDetailWeather(cityId: weatherId ?? 44418)
    }
    
    // Configuration StackView
    func configureStackView(){
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Configuration Content
    func configurContentView() {
        stackView.addArrangedSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: stackView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 185)
        ])
    }
    
    // Configuration Header
    func contentHeader() {
        contentView.addSubview(cityName)
        contentView.addSubview(timeZone)
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cityName.heightAnchor.constraint(equalToConstant: 50),
            
            timeZone.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 5),
            timeZone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeZone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            timeZone.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: timeZone.bottomAnchor, constant: 25),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // Configuration TableView
    func configureTableView() {
        stackView.addArrangedSubview(weatherDetailTableView)
        weatherDetailTableView.delegate = self
        weatherDetailTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            weatherDetailTableView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherDetailTableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            weatherDetailTableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            weatherDetailTableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    // Configuration NavBar
    func configureNavigationBar(){
        title = "Weather State"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]

    }
}

// TableView Delegate
extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consoleWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let consoleWeather = consoleWeathers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailCell.detailReuseId, for: indexPath) as! WeatherDetailCell
        cell.setCell(weather: consoleWeather)
        return cell
    }
}

// View Model Output
extension WeatherDetailViewController: WeatherDetailOutput {
    func changeLoadin(isLoad: Bool) {
        DispatchQueue.main.async { isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating() }
    }
    
    func fetchConsoleData(values: [ConsoleWeather]) {
        consoleWeathers = values
        DispatchQueue.main.async { self.weatherDetailTableView.reloadData() }
    }
    
    func fetchDetailData(detail: Detail) {
        details = detail
        DispatchQueue.main.async {
            self.cityName.text =  "\(self.details?.title ?? "") , \(self.details?.parent?.title ?? "")"
            self.timeZone.text = self.details?.timezone
            self.timeLabel.text = self.details?.time.convertToDisplayFormat2()
        }
    }
}
