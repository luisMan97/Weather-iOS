//
//  GetFavoriteWeather.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation
import Combine

protocol GetFavoriteWeatherProtocol {
    func invoke() -> AnyPublisher<[WeatherCoreData], Never>
}

struct GetFavoriteWeather: GetFavoriteWeatherProtocol {
    
    // Repository
    private(set) var repository: WeatherDetailRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke() -> AnyPublisher<[WeatherCoreData], Never> {
        repository.getFavoriteWeather()
    }

}
