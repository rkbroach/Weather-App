//
//  Extras.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 6/28/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import Foundation




let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude )&lon=\(Location.sharedInstance.longitude)&appid=175187a40ab669050fab7e3f2070758a"
let FORECAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude )&lon=\(Location.sharedInstance.latitude)&appid=175187a40ab669050fab7e3f2070758a"




//"http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=175187a40ab669050fab7e3f2070758a"


//"https://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=175187a40ab669050fab7e3f2070758a"

typealias DownloadComplete = () -> () // completion handler

