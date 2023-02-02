//
//  WeatherDetailResponse.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct WeatherDetailResponse: Decodable {
    let current: CurrentResponse?
    let forecast: ForecastResponse?
}

extension WeatherDetailResponse {
    
    func toDomain() -> WeatherDetail {
        .init(current: current?.toDomain(),
              forecast: forecast?.toDomain())
    }
    
}
