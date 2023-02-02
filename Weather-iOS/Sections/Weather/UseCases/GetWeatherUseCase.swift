//
//  GetWeatherUseCase.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation

enum UseCaseError: Error {
    case networkError, decodingError
    
    public var localizedDescription: String {
        switch self {
        case .networkError:
            return "Verifica tu conexión a internet e intenta nuevamente."
        case .decodingError:
            return "Ha ocurrido un error, inténtalo en unos minutos."
        }
    }
}

protocol GetWeatherUseCaseProtocol {
    func invoke(request: WeatherRequest) async -> Result<[Weather], UseCaseError>
}

struct GetWeatherUseCase: GetWeatherUseCaseProtocol {
    
    // Repository
    private(set) var repository: WeatherRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke(request: WeatherRequest) async -> Result<[Weather], UseCaseError> {
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
