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
    
}

final class DetailForecastViewController: UIViewController {
    var output: DetailForecastViewControllerOutput!
    
    private let cityNameLabel = UILabel()
    private let currentWeatherLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
}

extension DetailForecastViewController: DetailForecastPresenterOutput {
    
}
