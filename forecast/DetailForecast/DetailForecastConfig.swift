//
//  detailForecastConfig.swift
//  forecast
//
//  Created by Alexandre Odet on 22/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import API

struct DetailForecastConfig {
    static func build(with apiClient: ForecastClient) -> UIViewController {
        let viewController = DetailForecastViewController()
        //let interactor = DetailForecastInteractor(with: apiClient)
        //let presenter = DetailForecastPresenter()
        //let router = DetailForecastRouter(with: apiClient)
        
        //viewController.output = interactor
        //interactor.action = router
        //interactor.output = presenter
        //presenter.output = viewController
        
        return viewController
    }
}
