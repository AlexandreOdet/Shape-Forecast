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
    }
    
    public let date: Date
    public let name: String
    public let coordinates: Coordinates
    public let weather: [Weather]
    public let infos: Infos
}

public struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

public struct Weather: Codable {
    let id: Int
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

/*
 {
   "wind": {
     "speed": 0.47,
     "deg": 107.538
   },
   "clouds": {
     "all": 2
   },
   "dt": 1560350192,
   "sys": {
     "type": 3,
     "id": 2019346,
     "message": 0.0065,
     "country": "JP",
     "sunrise": 1560281377,
     "sunset": 1560333478
   },
   "timezone": 32400,
   "id": 1851632,
   "name": "Shuzenji",
   "cod": 200
 }
 */
