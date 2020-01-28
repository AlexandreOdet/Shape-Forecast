//
//  DetailWeatherConfig.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import API

struct DetailWeatherConfig {
    static func build(with weather: CurrentWeather, andApi client: ForecastClient) -> UIViewController {
        let viewController = DetailForecastViewController()
        let router = DetailForecastRouter()
        let presenter = DetailForecastPresenter()
        let interactor = DetailForecastInteractor(with: weather, and: client)
        
        viewController.output = interactor
        interactor.action = router
        interactor.output = presenter
        presenter.output = viewController
        router.viewController = viewController
        return viewController
    }
}
