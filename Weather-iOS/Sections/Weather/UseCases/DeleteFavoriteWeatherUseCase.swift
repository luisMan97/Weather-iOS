//
//  DeleteFavoriteWeatherUseCase.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation

protocol DeleteFavoriteWeatherUseCaseProtocol {
    func invoke(favoriteWeather: [WeatherCoreData], offsets: IndexSet)
}

struct DeleteFavoriteWeatherUseCase: DeleteFavoriteWeatherUseCaseProtocol {
    
    // Repository
    private(set) var repository: WeatherRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke(favoriteWeather: [WeatherCoreData], offsets: IndexSet) {
        repository.deleteWeather(favoriteWeather: favoriteWeather, offsets: offsets)
    }

}
