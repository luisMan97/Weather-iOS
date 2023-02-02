//
//  WeatherRepository.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol {
    func doSomething(request: WeatherRequest) async throws -> [Weather]
    func getFavoriteWeather() -> AnyPublisher<[WeatherCoreData], Never>
    func deleteWeather(favoriteWeather: [WeatherCoreData], offsets: IndexSet)
    func deleteAllWeather()
}

struct WeatherRepository: WeatherRepositoryProtocol {
    
    private(set) var remoteDataSource: RemoteWeatherDataSource
    private(set) var localDataSource: LocalWeatherDataSource
    
    func doSomething(request: WeatherRequest) async throws -> [Weather] {
        return try await remoteDataSource.doSomething(request: request)
    }
    
    func getFavoriteWeather() -> AnyPublisher<[WeatherCoreData], Never> {
        localDataSource.weather.eraseToAnyPublisher()
    }
    
    func deleteWeather(favoriteWeather: [WeatherCoreData], offsets: IndexSet) {
        localDataSource.deleteFavoriteWeather(favoriteWeather: favoriteWeather, offsets: offsets)
    }

    func deleteAllWeather() {
        localDataSource.deleteAllWeather()
    }
    
}
