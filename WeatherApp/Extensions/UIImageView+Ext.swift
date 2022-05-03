//
//  UIImageView+Ext.swift
//  WeatherApp
//
//  Created by Serkan on 1.05.2022.
//

import Foundation
import Kingfisher


extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: "https://www.metaweather.com/static/img/weather/png/\(imageUrl).png"))
    }
}


