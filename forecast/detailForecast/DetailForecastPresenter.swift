//
//  DetailForecastPresenter.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities

protocol DetailForecastPresenterOutput: class { //ViewController
    func display(temperature: Double)
    func display(cityName: String)
    func display(weather: String)
    func set(backgroundViewWith weather: Weather)
    func displayTodayDate()
}

final class DetailForecastPresenter {
    var output: DetailForecastPresenterOutput!
}

extension DetailForecastPresenter: DetailForecastInteractorOutput {
    func display(_ currentWeather: CurrentWeather) {
        let celsiusTemp = Temperature.kelvinToCelsius(currentWeather.infos.temp)
        output.display(temperature: celsiusTemp)
        output.display(cityName: currentWeather.name)
        output.displayTodayDate()
        output.display(weather: currentWeather.weather.first!.main)
        
        let weather = Weather(with: currentWeather.weather.first!.id)
        output.set(backgroundViewWith: weather)
    }    
}
