//
//  FindLocationPresenter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import MapKit

protocol FindLocationPresenterOutput: class {
    func blurView()
    func addAnnotation(at coordinate: CLLocationCoordinate2D)
    func unblurView()
}

final class FindLocationPresenter {
    weak var output: FindLocationPresenterOutput!
}

extension FindLocationPresenter: FindLocationInteractorOutput {
    func blurView() {
        output.blurView()
    }
    
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        output.addAnnotation(at: coordinate)
    }
}
