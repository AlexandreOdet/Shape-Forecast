//
//  Weather.swift
//  forecast
//
//  Created by Odet Alexandre on 27/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

enum Weather {
    case thunderstorm
    case rain
    case snow
    case clear
    case cloudy
    
    init(with id: Int) {
        switch id {
        case 200..<300:
            self = .thunderstorm
        case 300..<600:
            self = .rain
        case 600..<700:
            self = .snow
        case 800:
            self = .clear
        case 801..<900:
            self = .cloudy
        default:
            self = .clear
        }
    }
    
    var backgroundView: UIImage { //Get associated background view to set in DetailForecastViewController
        switch self {
        case .thunderstorm:
            return UIImage(named: "thunderstorm")!
        case .rain:
            return UIImage(named: "rain")!
        case .snow:
            return UIImage(named: "snow")!
        case .clear:
            return UIImage(named: "clear_sky")!
        case .cloudy:
            return UIImage(named: "cloudy")!
        }
    }
    
}
