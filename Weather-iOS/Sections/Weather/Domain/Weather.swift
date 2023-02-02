//
//  Weather.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct Weather: Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let url: String
    
    var ubication: String {
        "\(region) - \(country)"
    }
}

extension Weather {
    
    static var dummy: Weather {
        .init(id: 502209,
              name: "Bogota",
              region: "Cundinamarca",
              country: "Colombia",
              latitude: 4.6,
              longitude: -74.08,
              url: "bogota-cundinamarca-colombia")
    }
    
    func toCoreData(_ weatherCoreData: WeatherCoreData) {
        weatherCoreData.id = Int32(id)
        weatherCoreData.name = name
        weatherCoreData.region = region
        weatherCoreData.country = country
        weatherCoreData.latitude = latitude
        weatherCoreData.longitude = longitude
        weatherCoreData.url = url
    }
    
}
