//
//  SaveWeatherUseCase.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

protocol SaveWeatherUseCaseProtocol {
    func invoke(weather: Weather)
}

struct SaveWeatherUseCase: SaveWeatherUseCaseProtocol {
    
    // Repository
    private(set) var repository: WeatherDetailRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke(weather: Weather) {
        repository.saveWeather(weather)
    }

}
