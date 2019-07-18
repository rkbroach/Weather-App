//
//  ViewController.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 6/28/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    
    // Variables
    var currentWeather: CurrentWeather!
    var currentLocation: CLLocation!
    var forecastWeather: ForecastWeather!
    var forecastArray = [ForecastWeather]()
    
    // Constants
    let locationManager = CLLocationManager()
    
    // UI Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyParallax(to: backgroundImage, with: -40 )
        applyParallax(to: weatherImage, with: 3)
        
        currentWeather = CurrentWeather()
        
        callDelegates()
        setupLocation()
        downloadForecastWeather() {
            print("FORECAST DATA DOWNLOADED")
            print(self.forecastArray)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthCheck()
    }
    
    func updateUI() {
        cityName.text = currentWeather.cityName
        currentTemperature.text = "\(Int(currentWeather.currentTemperature))˚C"
        currentDate.text = currentWeather.currentDate
        weatherType.text = currentWeather.weatherType
    }
    
    // Delegate
    func callDelegates() {
        locationManager.delegate = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
    }
    
    func setupLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // use gps only when app is open and take permission for that
        locationManager.startMonitoringSignificantLocationChanges() // update only when significant
    }
    
    func locationAuthCheck() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // get location from device
            currentLocation = locationManager.location
                       // pass location coordinates to API
//            Location.sharedInstance.latitude = 28.4595
//            Location.sharedInstance.longitude = 77.0266

//            print("Location.sharedInstance.latitude is \(currentLocation.coordinate.latitude)")
//            print("Location.sharedInstance.longitude is \(currentLocation.coordinate.longitude)")

            
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            // download API Data
            currentWeather.downloadCurrentWeather {
                // update GUI after download is completed
                self.updateUI()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthCheck()
        }
    }
    
    
    func downloadForecastWeather(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_API_URL).responseJSON() { (response) in
            let result = response.result
          
            //let json = JSON(result.value)
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>] {
                    for item in list {
                        let forecast = ForecastWeather(weatherDictionary: item)
                        
                        self.forecastArray.append(forecast)
                    }
                    self.forecastTableView.reloadData()
                }
            }
            
            //self.forecastArray.remove(at: 0)
            
            completed()
        }
    }
    
    // Effects
    func applyParallax(to view: UIView, with intensity: Double) {
        
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -intensity
        horizontalMotion.maximumRelativeValue = intensity
        
        let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -intensity
        verticalMotion.maximumRelativeValue = intensity
        
        let parallaxMovementGroup = UIMotionEffectGroup()
        parallaxMovementGroup.motionEffects = [horizontalMotion, verticalMotion]
        view.addMotionEffect(parallaxMovementGroup)
    }
    
    // END OF CLASS
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        cell.configureCell(forecastData: forecastArray[indexPath.row])
        return cell
    }
    
    // END OF EXTENSION
}
