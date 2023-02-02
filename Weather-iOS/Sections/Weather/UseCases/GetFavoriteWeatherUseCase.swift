//
//  GetFavoriteWeatherUseCase.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Combine

protocol GetFavoriteWeatherUseCaseProtocol {
    func invoke() -> AnyPublisher<[WeatherCoreData], Never>
}

struct GetFavoriteWeatherUseCase: GetFavoriteWeatherUseCaseProtocol {
    
    // Repository
    private(set) var repository: WeatherRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke() -> AnyPublisher<[WeatherCoreData], Never> {
        repository.getFavoriteWeather()
    }

}
