//
//  DateUtils.swift
//  forecast
//
//  Created by Odet Alexandre on 27/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation

final class DateUtils {
    
    private static let formattedDayFormat = "EEEE" //Formatted day string
    private static let hoursFormat = "HH"
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()
    
    public class func getFormattedDayName(from date: Date = Date()) -> String {
        dateFormatter.dateFormat = formattedDayFormat
        return dateFormatter.string(from: date)
    }
    
    public class func isDateInTheNext24Hours(_ date: Date) -> Bool {
        if let diff = Calendar.current.dateComponents([.hour], from: Date(), to: date).hour, diff <= 24 {
            return true
        }
        return false
    }
    
    public class func getHour(from date: Date) -> String {
        dateFormatter.dateFormat = hoursFormat
        return dateFormatter.string(from: date)
    }
}
