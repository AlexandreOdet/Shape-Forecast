
//
//  FindLocationRouter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities

final class FindLocationRouter {
    let api: ForecastClient
    
    var viewController: FindLocationViewController!
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
    
    private func dismissPreviousAlertIfNeeded(withCompletion completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            if self.viewController.presentedViewController != nil && self.viewController.presentedViewController is UIAlertController { //Remove previous alert if needed.
                self.viewController.presentedViewController?.dismiss(animated: true, completion: completion)
            }
        }
    }
}

extension FindLocationRouter: FindLocationInteractorAction {
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        let alertController = UIAlertController(title: nil, message: "Weather is loading...", preferredStyle: .alert)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func weatherFecthDidFail() {
        dismissPreviousAlertIfNeeded(withCompletion: {
            let alertController = UIAlertController(title: "Oops", message: "Something went wrong.\nWeather could not be fetched.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.viewController.present(alertController, animated: true)
        })
    }
    
    func weatherFetched(_ weather: CurrentWeather) {
        dismissPreviousAlertIfNeeded(withCompletion: {
            let nextViewController = DetailWeatherConfig.build(with: weather)
            self.viewController.present(nextViewController, animated: true, completion: nil)
        })
    }
    
    func connectivityNotAvailable() {
        self.dismissPreviousAlertIfNeeded(withCompletion: {
            self.viewController.alertWhenNetworkNotAvailable()
        })
    }
}
