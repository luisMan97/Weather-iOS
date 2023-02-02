//
//  CurrentResponse.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct CurrentResponse: Decodable {
    let condition: ConditionResponse?
    let feelslike_c: Double?
    let wind_mph: Double?
    let humidity: Double?
}

extension CurrentResponse {
    
    func toDomain() -> Current {
        .init(textCondition: condition?.text ?? .empty,
              feelslike: "\(feelslike_c?.roundDouble() ?? "0")°",
              wind: "\(wind_mph?.roundDouble() ?? "0") mph",
              humidity: "\(humidity?.roundDouble() ?? "0")%")
    }
    
}
