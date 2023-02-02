//
//  RemoteWeatherDataSource.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

protocol RemoteWeatherDataSource {
    func doSomething(request: WeatherRequest) async throws -> [Weather]
}
