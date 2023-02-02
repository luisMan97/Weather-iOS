//
//  WeatherDetail.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct WeatherDetail {
    var current: Current?
    let forecast: Forecast?
}

extension WeatherDetail  {
    
    func toCoreData(_ weatherCoreData: WeatherCoreData) {
        let forecastCoreData = ForecastCoreData(context: PersistenceController.shared.managedContext)
        forecastCoreData.mintemp = forecast?.mintemp
        forecastCoreData.maxtemp = forecast?.maxtemp
        forecast?.forecastday.forEach {
            let forecastDayCoreData = ForecastDayCoreData(context: PersistenceController.shared.managedContext)
            forecastDayCoreData.textCondition = $0.textCondition
            forecastDayCoreData.maxtemp = $0.maxtemp
            forecastDayCoreData.mintemp = $0.mintemp
            forecastDayCoreData.date = $0.date
            forecastCoreData.addToForescastday(forecastDayCoreData)
        }
        forecast?.nextDays.forEach {
            let forecastDayCoreData = ForecastDayCoreData(context: PersistenceController.shared.managedContext)
            forecastDayCoreData.textCondition = $0.textCondition
            forecastDayCoreData.maxtemp = $0.maxtemp
            forecastDayCoreData.mintemp = $0.mintemp
            forecastDayCoreData.date = $0.date
            forecastCoreData.addToNextDays(forecastDayCoreData)
        }
        weatherCoreData.forecast = forecastCoreData
        
        let currentCoreData = CurrentCoreData(context: PersistenceController.shared.managedContext)
        currentCoreData.isCold = current?.isCold == true
        currentCoreData.textCondition = current?.textCondition
        currentCoreData.humidity = current?.humidity
        currentCoreData.wind = current?.wind
        currentCoreData.feelslike = current?.feelslike
        weatherCoreData.current = currentCoreData
        
    }

}
