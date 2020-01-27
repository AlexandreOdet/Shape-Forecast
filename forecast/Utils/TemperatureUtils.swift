//
//  TemperatureUtils.swift
//  forecast
//
//  Created by Alexandre Odet on 27/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

final class Temperature {
    class func kelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }
}
