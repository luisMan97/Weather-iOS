//
//  WeatherViewModelTests.swift
//  Weather-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import XCTest
import Combine
@testable import Weather_iOS

class WeatherViewModelTests: XCTestCase {

    private var viewModel: WeatherViewModel!
    private var getWeatherUseCase: GetWeatherUseCaseMock!
    
    override func setUp() {
        getWeatherUseCase = GetWeatherUseCaseMock()
        viewModel = .init(getWeatherUseCase: getWeatherUseCase,
                          getFavoritesWeatherUseCase: GetFavoritesWeatherUseCaseMock(),
                          deleteFavoriteWeatherUseCase: DeleteFavoriteWeatherUseCase(),
                          deleteAllWeatherUseCase: DeleteAllWeatherUseCase())
    }

    func testSomething() async {
        // Given
        let expectedValue = [Weather.dummy]
        getWeatherUseCase.executeResult = .success(expectedValue)
        // When
        await viewModel.doSomething(city: "Bogota")
        // Then
        XCTAssertEqual(viewModel.weather, expectedValue)
    }
    
    func testSomethingError() async {
        // Given
        getWeatherUseCase.executeResult = .failure(UseCaseError.decodingError)
        // When
        await viewModel.doSomething(city: "Bogota")
        // Then
        XCTAssertEqual(viewModel.error, UseCaseError.decodingError.localizedDescription)
    }

}

// TODO: Move to other file
class GetWeatherUseCaseMock: GetWeatherUseCaseProtocol {
    
    var executeResult: Result<[Weather], UseCaseError> = .success([.dummy])
    
    func invoke(request: WeatherRequest) async -> Result<[Weather], UseCaseError> {
        executeResult
    }
    
}

class GetFavoritesWeatherUseCaseMock: GetFavoriteWeatherUseCaseProtocol {
    func invoke() -> AnyPublisher<[WeatherCoreData], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
}

class DeleteFavoriteWeatherUseCase: DeleteFavoriteWeatherUseCaseProtocol {
    
    func invoke(favoriteWeather: [WeatherCoreData], offsets: IndexSet) {
        
    }
    
}
 
class DeleteAllWeatherUseCase: DeleteAllWeatherUseCaseProtocol {
    
    func invoke() {
        
    }
    
}
