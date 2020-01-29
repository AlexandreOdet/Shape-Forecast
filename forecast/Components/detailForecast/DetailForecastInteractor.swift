//
//  DetailForecastInteractor.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import API

protocol DetailForecastInteractorOutput: class { //Presenter
    func display(_ currentWeather: CurrentWeather)
    func displayTodayWeather(_ list: [ListBusiness])
    func displayForecast(_ list: [ListBusiness])
}

protocol DetailForecastInteractorAction: class { //Router
    func displayErrorAlert()
    func didClickCloseButton()
    func connectivityNotAvailable()
}

final class DetailForecastInteractor: Reachable {
    var action: DetailForecastInteractorAction!
    var output: DetailForecastInteractorOutput!
    
    private var currentWeather: CurrentWeather
    private var apiClient: ForecastClient
    
    init(with weather: CurrentWeather, and apiClient: ForecastClient) {
        self.currentWeather = weather
        self.apiClient = apiClient
    }
}

extension DetailForecastInteractor: DetailForecastViewControllerOutput {
    func viewDidLoad() {
        output.display(currentWeather)
        guard isReachable else {
            action.connectivityNotAvailable()
            return
        }
        apiClient.perform(DailyForecast.getHourlyForecast(for: currentWeather.coordinates.lat,
                                                          and: currentWeather.coordinates.lon),
                          completion: { result in
                            if result.error != nil {
                                self.action.displayErrorAlert()
                            } else {
                                let todayWeather = result.value!.list.filter({ DateUtils.isDateInTheNext24Hours(Date(timeIntervalSince1970: TimeInterval($0.dt))) //Get today weather
                                })
                                self.output.displayTodayWeather(todayWeather.map { ListBusiness(fromResource: $0) })
                                let forecast = result.value!.list.filter({ !DateUtils.isDateInTheNext24Hours(Date(timeIntervalSince1970: TimeInterval($0.dt)))
                                })
                                let empty: [Date: [List]] = [:]
                                let groupedByDate = forecast.reduce(into: empty) { acc, cur in
                                    let currentDate = Date(timeIntervalSince1970: TimeInterval(cur.dt))
                                    let components = Calendar.current.dateComponents([.day], from: currentDate)
                                    let date = Calendar.current.date(from: components)!
                                    let existing = acc[date] ?? []
                                    acc[date] = existing + [cur]
                                } //Gather forecast by day
                                var array = [ListBusiness]()
                                for value in groupedByDate.values {
                                    let item = ListBusiness(fromResource: value.first!)
                                    item.mainInfos.tempMax = value.max(by: { $0.main.tempMax < $1.main.tempMax})!.main.tempMax
                                    item.mainInfos.tempMin = value.min(by: { $0.main.tempMin < $1.main.tempMin })!.main.tempMin
                                    array.append(item)
                                }
                                self.output.displayForecast(array.sorted(by: { $0.date < $1.date }))
                            }
            }).resume()
    }
    
    func didClickCloseButton() {
        action.didClickCloseButton()
    }
}
