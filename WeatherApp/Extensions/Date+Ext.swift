//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Serkan on 30.04.2022.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func convertToMonthYearFormat2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MMM / dd"
        return dateFormatter.string(from: self)
    }
}
