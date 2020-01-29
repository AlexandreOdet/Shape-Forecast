//
//  DetailForecastRouter.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

final class DetailForecastRouter {
    var viewController: DetailForecastViewController!
    
    private func dismissPreviousAlertIfNeeded(withCompletion completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            if self.viewController.presentedViewController != nil && self.viewController.presentedViewController is UIAlertController { //Remove previous alert if needed.
                self.viewController.presentedViewController?.dismiss(animated: true, completion: completion)
            }
        }
    }
}

extension DetailForecastRouter: DetailForecastInteractorAction {
    func displayErrorAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Oops", message: "Something went wrong.\nWeather could not be fetched.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.viewController.present(alertController, animated: true)
        }
    }
    
    func didClickCloseButton() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func connectivityNotAvailable() {
        self.dismissPreviousAlertIfNeeded(withCompletion: {
            self.viewController.alertWhenNetworkNotAvailable()
        })
    }

}
