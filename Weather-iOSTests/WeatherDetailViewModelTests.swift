//
//  WeatherDetailViewModelTests.swift
//  Weather-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import XCTest
@testable import Weather_iOS

class WeatherDetailViewModelTests: XCTestCase {

    private var viewModel: WeatherDetailViewModel!
    private var getWeatherDetailUseCase: GetWeatherDetailUseCaseMock!
    
    override func setUp() {
        getWeatherDetailUseCase = GetWeatherDetailUseCaseMock()
        viewModel = WeatherDetailViewModel(getWeatherDetailUseCase: getWeatherDetailUseCase)
    }

    func testSomething() async {
        let expectedValue = WeatherDetail.Something.ViewModel(something: "something")
        getWeatherDetailUseCase.executeResult = .success(expectedValue)
        await viewModel.doSomething()
        XCTAssertEqual(viewModel.WeatherDetail, expectedValue)
    }
    
    func testSomethingError() async {
        getWeatherDetailUseCase.executeResult = .failure(UseCaseError.decodingError)
        await viewModel.doSomething()
        XCTAssertEqual(viewModel.error, UseCaseError.decodingError.localizedDescription)
    }

}

// TODO: Move to other file
class GetWeatherDetailUseCaseMock: GetWeatherDetailUseCaseProtocol {
    
    var executeResult: Result<WeatherDetail.Something.ViewModel, UseCaseError> = .success(.init(something: String()))
    
    func invoke(request: WeatherDetail.Something.Request) async -> Result<WeatherDetail.Something.ViewModel, UseCaseError> {
        return executeResult
    }
    
}
