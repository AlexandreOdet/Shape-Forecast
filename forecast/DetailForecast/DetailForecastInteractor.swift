//
//  DetailForecastInteractor.swift
//  forecast
//
//  Created by Alexandre Odet on 22/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import API

final class DetailForecastInteractor {
    let apiClient: ForecastClient
    
    init(with apiClient: ForecastClient) {
        self.apiClient = apiClient
    }
}
