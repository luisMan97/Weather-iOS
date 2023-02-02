//
//  WeatherDetailURLSessionDataSource.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

enum APIServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK
}

struct WeatherDetailURLSessionDataSource: RemoteWeatherDetailDataSource {
    
    private(set) var apiManager: APIManagerProtocol
    
    func doSomething(request: WeatherDetailRequest) async throws -> WeatherDetail {
        try await fetchWeatherDetail(request: request).toDomain()
    }
    
}

private extension WeatherDetailURLSessionDataSource {
    
    func fetchWeatherDetail(request: WeatherDetailRequest) async throws -> WeatherDetailResponse {
        try await apiManager.request(service: .WeatherDetail(request))
    }
    
}
