//
//  DetailForecastViewController.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

protocol DetailForecastViewControllerOutput: class {
    func viewDidLoad()
    func didClickCloseButton()
}

final class DetailForecastViewController: UIViewController {
    var output: DetailForecastViewControllerOutput!
    
    private lazy var cityNameLabel = UILabel(frame: .zero)
    private lazy var currentWeatherLabel = UILabel(frame: .zero)
    private lazy var currentTemperatureLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        output.viewDidLoad()
    }
    
    private func setUp() {
        view.addSubview(cityNameLabel)
        view.addSubview(currentWeatherLabel)
        view.addSubview(currentTemperatureLabel)
        
        setUpLabels()
       
    }
    
    private func setUpLabels() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameLabel.font = cityNameLabel.font.withSize(30)
        currentTemperatureLabel.font = currentTemperatureLabel.font.withSize(50)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currentWeatherLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            currentWeatherLabel.centerXAnchor.constraint(equalTo: cityNameLabel.centerXAnchor),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 20),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
}

extension DetailForecastViewController: DetailForecastPresenterOutput {
    func display(cityName: String) {
        cityNameLabel.text = cityName
    }
    
    func display(temperature: Double) {
        let formattedTemperature = String(format: "%.1f", temperature)
        currentTemperatureLabel.text = "\(formattedTemperature)°"
    }
}
