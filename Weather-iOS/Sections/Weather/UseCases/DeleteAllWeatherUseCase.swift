//
//  DeleteAllWeatherUseCase.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation

protocol DeleteAllWeatherUseCaseProtocol {
    func invoke()
}

struct DeleteAllWeatherUseCase: DeleteAllWeatherUseCaseProtocol {
    
    // Repository
    private(set) var repository: WeatherRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke() {
        repository.deleteAllWeather()
    }

}
