//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 6/28/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather {
    
    // Accessible only within this class
    private var _cityName : String!
    private var _weatherType : String!
    private var _currentTemperature : Double!
    private var _currentDate : String!
    
    // Accessible to other classes
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        
        return _cityName
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemperature: Double {
        if _currentTemperature == nil {
            _currentTemperature = 0.0
        }
        return _currentTemperature
    }
    var currentDate: String {
        if _currentDate == nil {
            _currentDate = ""
        }
        return _currentDate
    }
    
    // @escaping so that the reference count must be changed.
    func downloadCurrentWeather (completed: @escaping DownloadComplete) {
        Alamofire.request(API_URL).responseJSON() { (response) in
            let result = response.result
            let json = JSON(result.value)
            
            // City
            self._cityName = json["name"].stringValue
            
            // Date
            let tempDate = json["dt"].double
            let convertedDate = Date.init(timeIntervalSince1970: tempDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: convertedDate)
            self._currentDate = "\(currentDate)"
            
            // Weather Type
            self._weatherType = json["weather"][0]["main"].stringValue
            
            
            // Current Temperature, converted from Kelvin to Celsius and rounded off
            let downloadedTemp = json["main"]["temp"].double
            self._currentTemperature = (downloadedTemp! - 273.15).rounded(toPlaces: 0)
            
            completed()
        }
    }
}

