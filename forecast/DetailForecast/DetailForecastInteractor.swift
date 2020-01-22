//
//  DetailForecastInteractor.swift
//  forecast
//
//  Created by Alexandre Odet on 22/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import API

protocol DetailForecastInteractorAction: class { //Router
    
}

protocol DetailForecastInteractorOutput: class { //Presenter
    
}

final class DetailForecastInteractor {
    let apiClient: ForecastClient
    
    weak var action: DetailForecastInteractorAction!
    weak var output: DetailForecastInteractorOutput!
    
    init(with apiClient: ForecastClient) {
        self.apiClient = apiClient
    }
}

extension DetailForecastInteractor: DetailForecastViewControllerOutput {
    //Implement functions for every event of the UIViewController.
}
