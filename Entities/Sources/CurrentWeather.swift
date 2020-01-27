//
//  CurrentWeather.swift
//  Entities
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public struct CurrentWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case name
        case coordinates = "coord"
        case weather
        case infos = "main"
        case wind
        case clouds
        case system = "sys"
    }
    
    public let date: Date
    public let name: String
    public let coordinates: Coordinates
    public let weather: [Weather]
    public let infos: Infos
    public let wind: Wind
    public let clouds: Cloud
    public let system: System
}

public struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

public struct Weather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

public struct Infos: Codable {
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
    
    public let temp: Double
    public let feelsLike: Double
    public let tempMin: Double
    public let tempMax: Double
    public let pressure: Int
    public let humidity: Int
}

public struct Wind: Codable {
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    public let speed: Double
    public let degree: Double
}

public struct Cloud: Codable {
    public let all: Int
}

public struct System: Codable {
    public let type: Int
    let id: Int
    let message: Double
    let country: String
    public let sunrise: Date
    public let sunset: Date
}
