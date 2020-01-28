//
//  ListBusiness.swift
//  forecast
//
//  Created by Alexandre Odet on 28/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities

final class ListBusiness {
    let date: Int
    var weather: Weather
    var mainInfos: MainBusiness
    
    init(fromResource res: List) {
        self.date = res.dt
        self.weather = Weather.init(with: res.weather.first!.id)
        self.mainInfos = MainBusiness(fromResource: res.main)
    }
}

extension ListBusiness: Hashable { //Create extension of ListBusiness that conforms to hashable and equatable to use in collectionViewDiffableDataSource
    static func ==(lhs: ListBusiness, rhs: ListBusiness) -> Bool {
        return lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
