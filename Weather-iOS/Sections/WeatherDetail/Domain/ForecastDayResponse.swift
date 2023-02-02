//
//  ForecastDayResponse.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct ForecastDayResponse: Decodable {
    let day: DayRespone?
    let date: String?
}

extension ForecastDayResponse {
    
    func toDomain() -> ForecastDay {
        .init(date: date ?? .empty,
              textCondition: day?.condition?.text ?? .empty,
              maxtemp: "\(day?.maxtemp_c?.roundDouble() ?? "0")°",
              mintemp: "\(day?.mintemp_c?.roundDouble() ?? "0")°")
    }
    
}
