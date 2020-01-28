//
//  MainBusiness.swift
//  forecast
//
//  Created by Odet Alexandre on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities

final class MainBusiness {
    var tempMax: Double
    var tempMin: Double
    var temp: Double
    
    init(fromResource res: Main) {
        self.tempMax = res.tempMax
        self.temp = res.temp
        self.tempMin = res.tempMin
    }
}
