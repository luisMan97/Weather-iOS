//
//  GetWeatherUseCaseTests.swift
//  Weather-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import XCTest
import Combine
@testable import Weather_iOS

class GetWeatherUseCaseTests: XCTestCase {

    private var repository: WeatherRepositoryMock!
    private var useCase: GetWeatherUseCase!
    
    override func setUp() {
        repository = WeatherRepositoryMock()
        useCase = .init(repository: repository)
    }

    func testSomething() async {
        // Given
        let expectedValue = [Weather.dummy]
        repository.somethingInputResult = expectedValue
        // When
        let response = await useCase.invoke(request: .init(city: "Bogota"))
        // Then
        XCTAssertEqual(response, .success(expectedValue))
    }
    
    func testSomethingError() async {
        // Given
        let expectedValue: [Weather] = []
        repository.somethingInputResult = expectedValue
        // When
        let response = await useCase.invoke(request: .init(city: "Bogota"))
        // Then
        XCTAssertEqual(response, .failure(UseCaseError.decodingError))
    }

}

// TODO: Move to other file
class WeatherRepositoryMock: WeatherRepositoryProtocol {
    
    var somethingInputResult: [Weather] = [.dummy]
    
    private var somethingOutputResult: [Weather] {
        get throws { return try somethingResult() }
    }
    
    func doSomething(request: WeatherRequest) async throws -> [Weather] {
        return try somethingOutputResult
    }
    
    func getFavoriteWeather() -> AnyPublisher<[WeatherCoreData], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    func deleteWeather(favoriteWeather: [WeatherCoreData], offsets: IndexSet) {
        
    }
    
    func deleteAllWeather() {
        
    }
    
    private func somethingResult() throws -> [Weather] {
        if somethingInputResult.isEmpty {
            throw APIServiceError.decodingError
        } else {
            return somethingInputResult
        }
    }
    
}

// TODO: Move to other file
extension Weather: Equatable {
    
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.id == rhs.id
    }
    
}
