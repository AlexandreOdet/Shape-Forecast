//
//  Wind.swift
//  Entities
//
//  Created by Alexandre Odet on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

public struct Wind: Codable {
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    public let speed: Double
    public let degree: Double
}
