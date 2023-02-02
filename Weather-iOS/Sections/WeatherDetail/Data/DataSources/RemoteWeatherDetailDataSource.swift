//
//  RemoteWeatherDetailDataSource.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

protocol RemoteWeatherDetailDataSource {
    func doSomething(request: WeatherDetailRequest) async throws -> WeatherDetail
}
