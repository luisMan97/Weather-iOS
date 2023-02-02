//
//  WeatherCoreDataExtension.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

extension WeatherCoreData {

    func toDomain() -> Weather {
        .init(id: Int(id),
              name: name ?? .empty,
              region: region ?? .empty,
              country: country ?? .empty,
              latitude: latitude,
              longitude: longitude,
              url: url ?? .empty)
    }
    
    func toDomainDetail() -> ForecastDay {
        .init(date: "",
              textCondition: current?.textCondition ?? .empty,
              maxtemp: forecast?.maxtemp ?? .empty,
              mintemp: forecast?.mintemp ?? .empty)
    }
    
}
