//
//  DetailForecastPresenter.swift
//  forecast
//
//  Created by Alexandre Odet on 22/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

protocol DetailForecastPresenterOutput: class {
    
}

final class DetailForecastPresenter {
    weak var output: DetailForecastPresenterOutput!
}

extension DetailForecastPresenter: DetailForecastInteractorOutput {
    
}
