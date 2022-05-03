//
//  WeatherListCell.swift
//  WeatherApp
//
//  Created by Serkan on 28.04.2022.
//

import UIKit

class WeatherListCell: UITableViewCell {

    static let reuseId = "weatherListCell"
    
    var weatherImage: UIImageView = {
        let wthrImage = UIImageView()
        wthrImage.translatesAutoresizingMaskIntoConstraints = false
        wthrImage.layer.cornerRadius                        = 10
        wthrImage.clipsToBounds                             = true
        return wthrImage
    }()
    
    var cityName: UILabel = {
        let ctyName = UILabel()
        ctyName.translatesAutoresizingMaskIntoConstraints = false
        ctyName.textColor                                 = .white
        ctyName.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return ctyName
    }()
    
    var cityDistance: UILabel = {
        let ctyDistance = UILabel()
        ctyDistance.translatesAutoresizingMaskIntoConstraints = false
        ctyDistance.textColor                                 = .systemGray5
        ctyDistance.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return ctyDistance
    }()
    
    var goImage: UIImageView = {
        let gImage = UIImageView()
        gImage.translatesAutoresizingMaskIntoConstraints = false
        gImage.tintColor                                 = .white
        gImage.image                                     = UIImage(systemName: "chevron.right")
        return gImage
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = UIColor(named: "appColor")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(weather: Weathers){
        cityName.text = weather.title
        weatherImage.image = UIImage(named: "weather")
        cityDistance.text = "\(weather.distance/1000) km"
    }
    
    private func setupUI() {
        addSubview(weatherImage)
        addSubview(cityName)
        addSubview(cityDistance)
        addSubview(goImage)
        
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            weatherImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor),
            
            cityName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cityName.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 20),
            cityName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cityName.heightAnchor.constraint(equalToConstant: 30),

            cityDistance.bottomAnchor.constraint(equalTo: weatherImage.bottomAnchor,constant: -5),
            cityDistance.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 20),
            cityDistance.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cityDistance.heightAnchor.constraint(equalToConstant: 20),
            
            goImage.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            goImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            goImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            goImage.heightAnchor.constraint(equalTo: goImage.widthAnchor)
        ])
    }
}
