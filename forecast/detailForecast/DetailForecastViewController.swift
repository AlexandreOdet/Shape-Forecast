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
    private lazy var backgroundView = UIImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        output.viewDidLoad()
    }
    
    private func setUp() {
        view.addSubview(backgroundView)
        
        view.addSubview(cityNameLabel)
        view.addSubview(currentWeatherLabel)
        view.addSubview(currentTemperatureLabel)
        
        setUpLabels()
        setUpBackgroundView()
    }
    
    private func setUpBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpLabels() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        currentTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        cityNameLabel.textColor = .white
        currentWeatherLabel.textColor = .white
        currentTemperatureLabel.textColor = .white
        
        cityNameLabel.textAlignment = .center
        currentWeatherLabel.textAlignment = .center
        currentTemperatureLabel.textAlignment = .center
        
        cityNameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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
        let formattedTemperature = String(format: "%.0f", temperature)
        currentTemperatureLabel.text = "\(formattedTemperature)°"
    }
    
    func display(weather: String) {
        currentWeatherLabel.text = weather
    }
    
    func set(backgroundViewWith weather: Weather) {
        backgroundView.alpha = 0.5
        backgroundView.image = weather.backgroundView
    }
}
