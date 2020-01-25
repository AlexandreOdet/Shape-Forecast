//
//  FindLocationAnnotation.swift
//  forecast
//
//  Created by Odet Alexandre on 25/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import MapKit

final class FindLocationAnnotation: NSObject, MKAnnotation {
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(with name: String, and coordinate: CLLocationCoordinate2D) {
        self.locationName = name
        self.coordinate = coordinate
        super.init()
    }
}
