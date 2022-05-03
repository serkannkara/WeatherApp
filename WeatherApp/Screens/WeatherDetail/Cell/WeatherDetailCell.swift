//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by Serkan on 29.04.2022.
//

import UIKit
import Kingfisher

class WeatherDetailCell: UITableViewCell {
    
    static let detailReuseId = "weatherDetailCell"
    
    
    
    var dayDate: UILabel = {
        let dyDate = UILabel()
        dyDate.translatesAutoresizingMaskIntoConstraints    = false
        dyDate.textColor                                    = .white
        dyDate.adjustsFontSizeToFitWidth                    = true
        dyDate.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return dyDate
    }()
    
    var iconImage: UIImageView = {
        let icnImage = UIImageView()
        icnImage.translatesAutoresizingMaskIntoConstraints  = false
        icnImage.tintColor                                  = .white
        return icnImage
    }()
    
    var highTemperature: UILabel = {
        let hghTemperature = UILabel()
        hghTemperature.translatesAutoresizingMaskIntoConstraints    = false
        hghTemperature.textColor                                    = .white
        hghTemperature.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return hghTemperature
    }()
    
    var lowTemperature: UILabel = {
        let lwTemperature = UILabel()
        lwTemperature.translatesAutoresizingMaskIntoConstraints = false
        lwTemperature.textColor                                 = .systemGray5
        lwTemperature.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return lwTemperature
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "appColor")
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = UIColor(named: "appColor")
    }
    
    func setCell(weather: ConsoleWeather){
        dayDate.text = weather.theDate.convertToDisplayFormat()
        highTemperature.text = "\(Int(weather.maxTemp))"
        lowTemperature.text = "\(Int(weather.minTemp))"
        iconImage.setImage(imageUrl: weather.weatherStateImageId)
    }
    
    private func configureCellUI(){
        addSubview(dayDate)
        addSubview(iconImage)
        addSubview(highTemperature)
        addSubview(lowTemperature)
        
        NSLayoutConstraint.activate([
            dayDate.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dayDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dayDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dayDate.trailingAnchor.constraint(equalTo: iconImage.leadingAnchor, constant: -10),
            
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            iconImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            highTemperature.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            highTemperature.trailingAnchor.constraint(equalTo: lowTemperature.leadingAnchor),
            highTemperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            highTemperature.widthAnchor.constraint(equalTo: highTemperature.heightAnchor),
            
            lowTemperature.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lowTemperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            lowTemperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            lowTemperature.widthAnchor.constraint(equalTo: lowTemperature.heightAnchor)
        ])
    }
}
