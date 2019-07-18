//
//  Location.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 7/1/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import Foundation

class Location {
    // Create a singleton class i.e. only one object can be created of this class
    static var sharedInstance = Location()
    var longitude: Double!
    var latitude: Double!
    
    
}
