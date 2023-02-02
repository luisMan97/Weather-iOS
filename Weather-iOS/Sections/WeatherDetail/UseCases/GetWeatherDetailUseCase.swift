//
//  GetWeatherDetailUseCase.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

protocol GetWeatherDetailUseCaseProtocol {
    func invoke(request: WeatherDetailRequest) async -> Result<WeatherDetail, UseCaseError>
}

struct GetWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol {
    
    // Repository
    private(set) var repository: WeatherDetailRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke(request: WeatherDetailRequest) async -> Result<WeatherDetail, UseCaseError> {
        do {
            let something = try await repository.doSomething(request: request)
            return .success(something)
        } catch {
            return .failure(handleError(error))
        }
    }
    
    private func handleError(_ error: Error) -> UseCaseError {
        switch(error) {
        case APIServiceError.decodingError: return .decodingError
        default: return .networkError
        }
    }

}
