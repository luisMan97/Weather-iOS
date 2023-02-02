//
//  Forecast.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct Forecast {
    let maxtemp: String
    let mintemp: String
    let forecastday: [ForecastDay]
    var nextDays: [ForecastDay] {
        var nextDays: [ForecastDay] = forecastday
        nextDays.removeFirst()
        return nextDays
    }
}
