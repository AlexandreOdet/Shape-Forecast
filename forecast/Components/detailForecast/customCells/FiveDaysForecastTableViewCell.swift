//
//  FiveDaysForecastTableViewCell.swift
//  forecast
//
//  Created by Odet Alexandre on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

final class FiveDaysForecastTableViewCell: UITableViewCell {
    
    let dayLabel = UILabel()
    let weatherIcon = UIImageView()
    let maxTemperatureLabel = UILabel()
    let minTemperatureLabel = UILabel()
    
    func setUp(with item: ListBusiness) {
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(maxTemperatureLabel)
        contentView.addSubview(minTemperatureLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dayLabel.textColor = .white
        maxTemperatureLabel.textColor = .white
        minTemperatureLabel.textColor = .lightGray
        
        let formattedMinTemperature = String(format: "%.0f", Temperature.kelvinToCelsius(item.mainInfos.tempMin))
        let formattedMaxTemperature = String(format: "%.0f", Temperature.kelvinToCelsius(item.mainInfos.tempMax))
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 32),
            weatherIcon.heightAnchor.constraint(equalToConstant: 32),
            
            minTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            minTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            maxTemperatureLabel.trailingAnchor.constraint(equalTo: minTemperatureLabel.leadingAnchor, constant: -15),
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let date = Date(timeIntervalSince1970: TimeInterval(item.date))
        dayLabel.text = DateUtils.getFormattedDayName(from: date)
        weatherIcon.image = item.weather.icon
        minTemperatureLabel.text = formattedMinTemperature
        maxTemperatureLabel.text = formattedMaxTemperature
    }
}
