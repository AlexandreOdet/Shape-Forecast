//
//  DetailForecastInteractor.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import API

protocol DetailForecastInteractorOutput: class { //Presenter
    func display(_ currentWeather: CurrentWeather)
    func displayTodayWeather(_ list: [List])
    func displayForecast(_ list: [List])
}

protocol DetailForecastInteractorAction: class { //Router
    func displayErrorAlert()
    func didClickCloseButton()
}

final class DetailForecastInteractor {
    var action: DetailForecastInteractorAction!
    var output: DetailForecastInteractorOutput!
    
    private var currentWeather: CurrentWeather
    private var apiClient: ForecastClient
    
    init(with weather: CurrentWeather, and apiClient: ForecastClient) {
        self.currentWeather = weather
        self.apiClient = apiClient
    }
}

extension DetailForecastInteractor: DetailForecastViewControllerOutput {
    func viewDidLoad() {
        output.display(currentWeather)
        apiClient.perform(DailyForecast.getHourlyForecast(for: currentWeather.coordinates.lat,
                                                          and: currentWeather.coordinates.lon),
                          completion: { result in
                            if result.error != nil {
                                self.action.displayErrorAlert()
                            } else {
                                let todayWeather = result.value!.list.filter({ DateUtils.isDateInTheNext24Hours(Date(timeIntervalSince1970: TimeInterval($0.dt))) //Get today weather
                                })
                                self.output.displayTodayWeather(todayWeather)
                                let forecast = result.value!.list.filter({ !DateUtils.isDateInTheNext24Hours(Date(timeIntervalSince1970: TimeInterval($0.dt)))
                                })
                                self.output.displayForecast(forecast)
                            }
            }).resume()
    }
    
    func didClickCloseButton() {
        
    }
}
