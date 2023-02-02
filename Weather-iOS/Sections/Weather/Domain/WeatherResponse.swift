//
//  WeatherResponse.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct WeatherResponse: Decodable {
    let id: Int?
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let url: String?
}

extension WeatherResponse {
    
    func toDomain() -> Weather {
        .init(id: id ?? -1,
              name: name ?? .empty,
              region: region ?? .empty,
              country: country ?? .empty,
              latitude: lat ?? .zero,
              longitude: lon ?? .zero,
              url: url ?? .empty)
    }
    
}
