//
//  GetWeatherDetailUseCaseTests.swift
//  Weather-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import XCTest
import Combine
@testable import Weather_iOS

class GetWeatherDetailUseCaseTests: XCTestCase {

    private var repository: WeatherDetailRepositoryMock!
    private var useCase: GetWeatherDetailUseCase!
    
    override func setUp() {
        repository = WeatherDetailRepositoryMock()
        useCase = .init(repository: repository)
    }

    func testSomething() async {
        // Given
        let expectedValue = WeatherDetail(current: .init(textCondition: "", feelslike: "", wind: "", humidity: ""), forecast: nil)
        repository.somethingInputResult = expectedValue
        // When
        let response = await useCase.invoke(request: .init(name: "Bogota"))
        // Then
        XCTAssertEqual(response, .success(expectedValue))
    }
    
    func testSomethingError() async {
        // Given
        let expectedValue = WeatherDetail(current: nil, forecast: nil)
        repository.somethingInputResult = expectedValue
        // When
        let response = await useCase.invoke(request: .init(name: "Bogota"))
        // Then
        XCTAssertEqual(response, .failure(UseCaseError.decodingError))
    }

}

class WeatherDetailRepositoryMock: WeatherDetailRepositoryProtocol {
    
    var somethingInputResult: WeatherDetail = .init(current: nil, forecast: nil)
    
    private var somethingOutputResult: WeatherDetail {
        get throws { return try somethingResult() }
    }
    
    func doSomething(request: WeatherDetailRequest) async throws -> WeatherDetail {
        return try somethingOutputResult
    }
    
    func getFavoriteWeather() -> AnyPublisher<[WeatherCoreData], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    func saveWeather(_ weather: Weather) {
        
    }
    
    
    private func somethingResult() throws -> WeatherDetail {
        if somethingInputResult.current == nil {
            throw APIServiceError.decodingError
        } else {
            return somethingInputResult
        }
    }
    
}

extension WeatherDetail: Equatable {
    
    public static func == (lhs: WeatherDetail, rhs: WeatherDetail) -> Bool {
        lhs.current == rhs.current
    }
    
}

extension Current: Equatable {
    
    public static func == (lhs: Current, rhs: Current) -> Bool {
        lhs.isCold == rhs.isCold
    }
    
}
