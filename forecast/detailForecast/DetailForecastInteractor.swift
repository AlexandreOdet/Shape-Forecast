//
//  DetailForecastInteractor.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities

protocol DetailForecastInteractorOutput: class { //Presenter
    func display(_ currentWeather: CurrentWeather)
}

protocol DetailForecastInteractorAction: class { //Router

}

final class DetailForecastInteractor {
    var action: DetailForecastInteractorAction!
    var output: DetailForecastInteractorOutput!
    
    private var currentWeather: CurrentWeather
    init(with weather: CurrentWeather) {
        self.currentWeather = weather
    }
}

extension DetailForecastInteractor: DetailForecastViewControllerOutput {
    func viewDidLoad() {
        output.display(currentWeather)
    }
    
    func didClickCloseButton() {
        
    }
}
