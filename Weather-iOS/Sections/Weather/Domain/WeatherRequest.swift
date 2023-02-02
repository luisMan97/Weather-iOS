//
//  WeatherRequest.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct WeatherRequest: Encodable {
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case city = "q"
    }
}
