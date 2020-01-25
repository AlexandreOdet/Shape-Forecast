
//
//  FindLocationRouter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API

final class FindLocationRouter {
    let api: ForecastClient
    
    var viewController: FindLocationViewController!
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationRouter: FindLocationInteractorAction {
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        let alertController = UIAlertController(title: nil, message: "Weather is loading...", preferredStyle: .alert)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func weatherFecthDidFail() {
        DispatchQueue.main.async { //Can be called from a background thread, to avoid using UI in background, use DispatchQueue.main to switch back to main thread.
            if self.viewController.presentedViewController != nil && self.viewController.presentedViewController is UIAlertController { //Remove previous alert if needed.
                self.viewController.dismiss(animated: true, completion: nil)
            }
            let alertController = UIAlertController(title: "Oops", message: "Something went wrong.\nWeather could not be fetched.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
        }
    }
    
    func weatherFetched() {
        DispatchQueue.main.async { //Can be called from a background thread, to avoid using UI in background, use DispatchQueue.main to switch back to main thread.
            if self.viewController.presentedViewController != nil && self.viewController.presentedViewController is UIAlertController { //Remove previous alert if needed.
                self.viewController.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
