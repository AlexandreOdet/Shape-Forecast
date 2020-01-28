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
    func display(minTemp: Double)
    func display(maxTemp: Double)
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
        output.display(minTemp: Temperature.kelvinToCelsius(currentWeather.infos.tempMin))
        output.display(maxTemp: Temperature.kelvinToCelsius(currentWeather.infos.tempMax))
    }
    
    func displayTodayWeather(_ list: [List]) {
        let businessList = list.map({
            ListBusiness(fromResource: $0)
        })
    }
}
