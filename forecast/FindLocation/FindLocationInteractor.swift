//
//  FindLocationInteractor.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities

protocol FindLocationInteractorOutput: class {
    func addPoint(at coordinates: CLLocationCoordinate2D)
}

protocol FindLocationInteractorAction: class {
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}


final class FindLocationInteractor {
    var output: FindLocationInteractorOutput!
    var action: FindLocationInteractorAction!
    
    let api: ForecastClient
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationInteractor: FindLocationViewControllerOutput {
    func viewIsReady() {
        // Request example to load the current weather with a query
        // Documentation for using the OpenWeatherAPI, is available at https://openweathermap.org/api
    }
    
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        action.locationSelected(at: coordinate)
    }
    
    func addPoint(at coordinate: CLLocationCoordinate2D) {
        output.addPoint(at: coordinate)
    }
}
