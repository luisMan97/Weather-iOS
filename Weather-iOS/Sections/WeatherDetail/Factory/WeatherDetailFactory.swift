//
//  WeatherDetailFactory.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import UIKit
import Combine

enum WeatherDetailFactory {
    
    static func getWeatherDetailView(_ weather: Weather,
                                     comesFromFavorites: Bool,
                                     appContainer: AppContainerProtocol) -> WeatherDetailView {
        // DataSources
        let remoteDataSource = WeatherDetailURLSessionDataSource(apiManager: appContainer.apiManager)
        // Repository
        let repository = WeatherDetailRepository(remoteDataSource: remoteDataSource)
        // Interactor
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let saveWeatherUseCase = SaveWeatherUseCase(repository: repository)
        let getFavoriteWeatherUseCase = GetFavoriteWeather(repository: repository)
        // ViewModel
        let viewModel = WeatherDetailViewModel(getWeatherDetailUseCase: getWeatherDetailUseCase,
                                               saveWeatherUseCase: saveWeatherUseCase,
                                               getFavoriteWeatherUseCase: getFavoriteWeatherUseCase,
                                               weather: weather,
                                               comesFromFavorites: comesFromFavorites)
        return WeatherDetailView(viewModel: viewModel)
    }
    
}
