//
//  WeatherDetailViewModel.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation
import Combine

class WeatherDetailViewModel: ObservableObject {
    
    // Internal Output Events Properties
    @Published var showProgress = false
    @Published var weatherDetail: WeatherDetail?
    @Published var favoriteWeather: [WeatherCoreData] = []
    @Published var error: String?
    
    // Internal Properties
    var progressTitle = ""
    var title = "WeatherDetail"
    var currentDate = "Hoy, \(Date().formatted(.dateTime.month().day().hour().minute()))"
    
    private(set) var weather: Weather
    
    // Private Properties
    private var subscriptions: Set<AnyCancellable> = []
    
    // Interactor
    private var getWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol
    private var saveWeatherUseCase: SaveWeatherUseCaseProtocol
    private var getFavoriteWeatherUseCase: GetFavoriteWeatherProtocol
    
    // MARK: - Initializers
    
    init(getWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol,
         saveWeatherUseCase: SaveWeatherUseCaseProtocol,
         getFavoriteWeatherUseCase: GetFavoriteWeatherProtocol,
         weather: Weather) {
        self.getWeatherDetailUseCase = getWeatherDetailUseCase
        self.saveWeatherUseCase = saveWeatherUseCase
        self.getFavoriteWeatherUseCase = getFavoriteWeatherUseCase
        self.weather = weather
        getFavoriteRecipes()
    }
    
    // MARK: - Internal Methods
    
    @MainActor
    func doSomething() async {
        progressTitle = "Cargando..."
        showProgress = true
        
        let result = await getWeatherDetailUseCase.invoke(request: .init(name: weather.name))
        
        switch result {
        case .success(let weatherDetail):
            self.weatherDetail = weatherDetail
            showProgress = false
        case .failure(let error):
            self.error = error.localizedDescription
            showProgress = false
        }
    }
    
    func saveWeather() {
        saveWeatherUseCase.invoke(weather: weather)
    }
    
    func updateViewWithForecast(_ forecast: ForecastDay) {
        currentDate = forecast.date
        let current = Current(textCondition: forecast.textCondition,
                              feelslike: "",
                              wind: "",
                              humidity: "")
        let forecast = Forecast(maxtemp: forecast.maxtemp,
                                mintemp: forecast.mintemp,
                                forecastday: weatherDetail?.forecast?.forecastday ?? [])
        weatherDetail = .init(current: current,
                              forecast: forecast)
    }
    
    private func getFavoriteRecipes() {
        getFavoriteWeatherUseCase.invoke()
            .sink { [weak self] favoriteWeather in
                guard let self = self else { return }
                self.favoriteWeather = favoriteWeather
                /*print(self.weather.id)
                print(favoriteWeather.first?.toDomain().id)
                let currentFavoriteWeather = self.favoriteWeather.filter({ Int($0.id) == self.weather.id }).first
                if let weather = currentFavoriteWeather?.toDomain() {
                    self.weather = weather
                }
                if let forecast = currentFavoriteWeather?.toDomainDetail() {
                    self.updateViewWithForecast(forecast)
                }
                self.weatherDetail?.current?.feelslike = currentFavoriteWeather?.feelslike ?? .empty
                self.weatherDetail?.current?.wind = currentFavoriteWeather?.wind ?? .empty
                self.weatherDetail?.current?.humidity = currentFavoriteWeather?.humidity ?? .empty*/
        }.store(in: &subscriptions)
    }

}
