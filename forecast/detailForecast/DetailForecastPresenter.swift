//
//  DetailForecastPresenter.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

protocol DetailForecastPresenterOutput: class { //ViewController
    func display(temperature: Double)
    func display(cityName: String)
}

final class DetailForecastPresenter {
    var output: DetailForecastPresenterOutput!
}

extension DetailForecastPresenter: DetailForecastInteractorOutput {
    func display(temperature: Double) {
        let celsiusTemp = Temperature.kelvinToCelsius(temperature)
        output.display(temperature: celsiusTemp)
    }
    
    func display(cityName: String) {
        output.display(cityName: cityName)
    }
    
}
