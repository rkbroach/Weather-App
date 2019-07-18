//
//  ForecastCell.swift
//  Weather App
//
//  Created by Rohan Kevin Broach on 7/2/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var forecastDay: UILabel!
    @IBOutlet weak var forecastTemperature: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(forecastData: ForecastWeather) {
        self.forecastDay.text = "\(forecastData.date)"
        self.forecastTemperature.text = "\(Int(forecastData.temperature))"
    }
    
    
    
}
