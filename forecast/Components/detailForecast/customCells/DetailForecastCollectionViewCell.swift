//
//  DetailForecastCollectionViewCell.swift
//  forecast
//
//  Created by Odet Alexandre on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

final class DetailForecastCollectionViewCell: UICollectionViewCell {
    private var hourLabel = UILabel()
    private var weatherIcon = UIImageView()
    private var temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUpView(with item: ListBusiness, andIsNow isNow: Bool) {
        contentView.addSubview(hourLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(temperatureLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hourLabel.textColor = .white
        hourLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        temperatureLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            weatherIcon.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 15),
            weatherIcon.centerXAnchor.constraint(equalTo: hourLabel.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 32),
            weatherIcon.heightAnchor.constraint(equalToConstant: 32),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 15),
            temperatureLabel.centerXAnchor.constraint(equalTo: hourLabel.centerXAnchor)
        ])
        
        if isNow {
            hourLabel.text = "Now"
        } else {
            let date = Date(timeIntervalSince1970: TimeInterval(item.date))
            hourLabel.text = DateUtils.getHour(from: date) + "h"
        }
        weatherIcon.image = item.weather.icon
        let formattedTemperature = String(format: "%.0f", Temperature.kelvinToCelsius(item.mainInfos.temp))
        temperatureLabel.text = "\(formattedTemperature)°"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
