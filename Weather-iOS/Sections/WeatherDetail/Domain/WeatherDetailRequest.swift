//
//  WeatherDetailRequest.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct WeatherDetailRequest: Encodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "q"
    }
}
