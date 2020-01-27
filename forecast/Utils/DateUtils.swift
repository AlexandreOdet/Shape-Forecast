//
//  DateUtils.swift
//  forecast
//
//  Created by Odet Alexandre on 27/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

final class DateUtils {
    
    private static let format = "EEEE" //Formatted day string
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateUtils.format
        return dateFormatter
    }()
    
    public class func getFormattedDayName() -> String {
        return dateFormatter.string(from: Date())
    }
}
