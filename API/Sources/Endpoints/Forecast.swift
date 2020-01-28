//
//  Forecast.swift
//  API
//
//  Created by Alexandre Odet on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import Client

extension DailyForecast {
    public static func getHourlyForecast(for latitude: Double, and longitude: Double) -> Request<DailyForecast, APIError> {
        return Request(
            url: URL(string: "forecast")!,
            method: .get,
            parameters: [QueryParameters([URLQueryItem(name: "lat", value: "\(latitude)"),
                                          URLQueryItem(name: "lon", value: "\(longitude)")]
                )],
            resource: decodeResource(DailyForecast.self),
            error: APIError.init,
            needsAuthorization: true
        )
    }
}
