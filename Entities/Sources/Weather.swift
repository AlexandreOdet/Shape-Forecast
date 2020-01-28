//
//  Weather.swift
//  Entities
//
//  Created by Alexandre Odet on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

public struct Weather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}
