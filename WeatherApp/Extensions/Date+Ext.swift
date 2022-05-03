//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Serkan on 30.04.2022.
//

import Foundation


extension Date {
    
    // Conver from yyyy-MM-dd
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    // Convert from yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ
    func convertToMonthYearFormat2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MMM / dd"
        return dateFormatter.string(from: self)
    }
}
