//
//  DetailWeatherConfig.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities

struct DetailWeatherConfig {
    static func build(with weather: CurrentWeather) -> UIViewController {
        let viewController = DetailForecastViewController()
        let router = DetailForecastRouter()
        let presenter = DetailForecastPresenter()
        let interactor = DetailForecastInteractor(with: weather)
        
        viewController.output = interactor
        interactor.action = router
        interactor.output = presenter
        presenter.output = viewController
        router.viewController = viewController
        return viewController
    }
}
