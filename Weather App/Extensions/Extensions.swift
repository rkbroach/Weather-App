//
//  Extensions.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 6/28/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import Foundation

extension Double {
    /// rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
