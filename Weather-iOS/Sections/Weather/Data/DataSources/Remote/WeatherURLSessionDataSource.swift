//
//  WeatherURLSessionDataSource.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

struct WeatherURLSessionDataSource: RemoteWeatherDataSource {
    
    private(set) var apiManager: APIManagerProtocol
    
    func doSomething(request: WeatherRequest) async throws -> [Weather] {
        try await fetchWeather(request: request).map { $0.toDomain() }
    }
    
}

private extension WeatherURLSessionDataSource {
    
    func fetchWeather(request: WeatherRequest) async throws -> [WeatherResponse] {
        try await apiManager.request(service: .SearchWeather(request))
    }
    
}
