//
//  WeatherFactory.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import UIKit
import Combine

enum WeatherFactory {
    
    static func getWeatherView(appContainer: AppContainerProtocol) -> WeatherView {
        // DataSources
        let remoteDataSource = WeatherURLSessionDataSource(apiManager: appContainer.apiManager)
        let localDataSource = WeatherCoreDataDataSource()
        // Repository
        let repository = WeatherRepository(remoteDataSource: remoteDataSource,
                                                            localDataSource: localDataSource)
        // Interactor
        let getWeatherUseCase = GetWeatherUseCase(repository: repository)
        let getFavoritesWeatherUseCase = GetFavoriteWeatherUseCase(repository: repository)
        let deleteFavoriteWeatherUseCase = DeleteFavoriteWeatherUseCase(repository: repository)
        let deleteAllWeatherUseCase = DeleteAllWeatherUseCase(repository: repository)
        // ViewModel
        let viewModel = WeatherViewModel(getWeatherUseCase: getWeatherUseCase,
                                                          getFavoritesWeatherUseCase: getFavoritesWeatherUseCase,
                                                          deleteFavoriteWeatherUseCase: deleteFavoriteWeatherUseCase,
                                                          deleteAllWeatherUseCase: deleteAllWeatherUseCase)
        return WeatherView(viewModel: viewModel)
    }
    
}
