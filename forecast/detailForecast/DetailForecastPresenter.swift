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
    func display(weather: String)
    func set(backgroundViewWith weather: Weather)
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
    
    func display(weather: String) {
        output.display(weather: weather)
    }
    
    func add(backgroundViewWith weather: Weather) {
        output.set(backgroundViewWith: weather)
    }
    
}
