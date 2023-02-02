//
//  ForecastDay.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct ForecastDay: Identifiable {
    var id = UUID()
    let date: String
    let textCondition: String
    let maxtemp: String
    let mintemp: String
}

extension ForecastDay {
    
    static var dummy: ForecastDay {
        .init(date: "2023-02-01",
              textCondition: "Nublado",
              maxtemp: "10",
              mintemp: "10")
    }
    
}
