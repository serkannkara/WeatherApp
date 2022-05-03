//
//  HomeScreenVC.swift
//  WeatherApp
//
//  Created by Serkan on 28.04.2022.
//

import UIKit
import CoreLocation

class WeatherListViewController: UIViewController {
    
    var currentLocation: CLLocationManager = {
        let crtLocation = CLLocationManager()
        crtLocation.desiredAccuracy = kCLLocationAccuracyBest
        crtLocation.requestWhenInUseAuthorization()
        crtLocation.startUpdatingLocation()
        return crtLocation
    }()
    
    var weatherListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.backgroundColor = UIColor(named: "appColor")
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.reuseId)
        return tableView
    }()
    
    var weathers        = [Weathers]()
    lazy var viewModel  = WeatherListViewModel()
    var indicator       = UIActivityIndicatorView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureNavigationBar()
        viewModel.setDelegate(output: self)
    }
    
    // Configuration NavBar
    func configureNavigationBar() {
        title                                                   = "City List"
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController?.navigationBar.tintColor           = .white
        navigationController?.navigationBar.barStyle            = .black
        navigationController?.navigationBar.barTintColor        = UIColor(named: "appColor")
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
    }
    
    // Delegate TableView & Location
    func configureTableView() {
        view.addSubview(weatherListTableView)
        weatherListTableView.frame      = view.bounds
        weatherListTableView.delegate   = self
        weatherListTableView.dataSource = self
        currentLocation.delegate        = self
    }
}

// Location Manager Delegate
extension WeatherListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        let location = "\(first.coordinate.longitude),\(first.coordinate.latitude)"
        viewModel.getWeathers(userLocation: location)
    }
}

// TableView DataSource
extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = weathers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.reuseId,for: indexPath) as! WeatherListCell
        cell.set(weather: weather)
        return cell
    }
}

// TableView Delegate
extension WeatherListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = weathers[indexPath.row]
        let destVC = WeatherDetailViewController()
        destVC.weatherId = weather.id
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}

// ViewModel Output
extension WeatherListViewController: WeatherListOutput {
    func fetchDatas(values: [Weathers]) {
        self.weathers = values
        DispatchQueue.main.async { self.weatherListTableView.reloadData() }
    }
    func changeLoading(isLoad: Bool) {
        DispatchQueue.main.async {  isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating() }
    }
}

