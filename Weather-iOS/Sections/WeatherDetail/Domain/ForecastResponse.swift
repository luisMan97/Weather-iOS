//
//  ForecastResponse.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct ForecastResponse: Decodable {
    let forecastday: [ForecastDayResponse]?
}

extension ForecastResponse {
    
    func toDomain() -> Forecast {
        .init(maxtemp: "\(forecastday?.first?.day?.maxtemp_c?.roundDouble() ?? "0")°",
              mintemp: "\(forecastday?.first?.day?.mintemp_c?.roundDouble() ?? "0")°",
              forecastday: forecastday?.map { $0.toDomain() } ?? [])
    }
    
}
