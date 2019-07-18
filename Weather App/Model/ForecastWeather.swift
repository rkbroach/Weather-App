//
//  ForecastWeather.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 7/2/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import Foundation

class ForecastWeather {
    private var _date: String!
    private var _temperature: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
        
    }
    
    var temperature: Double {
        if _temperature == nil {
            _temperature = 0.0
        }
        return _temperature
        
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        if let temp = weatherDictionary["temp"] as? Dictionary<String, AnyObject> {
            if let dayTemp = temp["day"] as? Double {
                let rawValue = (dayTemp - 273.15).rounded(toPlaces: 0)
                
                self._temperature = rawValue
            }
        }
        
        if let date = weatherDictionary["dt"] as? Double {
            let rawDate = Date.init(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            self._date = "\(rawDate.dayOfTheWeek())" // from extension
        }
    }
    
}
