//
//  LocalWeatherDataSource.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation
import Combine

protocol LocalWeatherDataSource {
    var weather: CurrentValueSubject<[WeatherCoreData], Never> { get }
    func deleteFavoriteWeather(favoriteWeather: [WeatherCoreData], offsets: IndexSet)
    func deleteAllWeather()
}
