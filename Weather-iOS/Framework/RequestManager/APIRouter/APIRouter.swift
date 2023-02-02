//
//  APIRouter.swift
//  Weather-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation

enum APIRouter {

    case SearchWeather(Encodable)
    case WeatherDetail(Encodable)
    
    private var method: HTTPMethod {
        switch self {
        case .SearchWeather,
             .WeatherDetail:
            return .GET
        }
    }

    private var path: String {
        switch self {
        case .SearchWeather(let model):
            return "search.json?key=c38fd65b44cb4fc0b3e155539233101".appendQueryItems(params: model.dictionary ?? [:])
        case .WeatherDetail(let model):
            return "forecast.json?key=c38fd65b44cb4fc0b3e155539233101".appendQueryItems(params: model.dictionary ?? [:]) + "&days=5"
        }
    }

    private var url: String { APIManagerConstants.endpoint }

    private var urlRequest: URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = APIManager.defaultHeaders as? [String: String]
        return urlRequest
    }

    private var nsUrlRequest: URLRequest? {
        guard let nsUrl = NSURL(string: self.url + path) else {
            return nil
        }
        var urlRequest = URLRequest(url: nsUrl as URL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = APIManager.defaultHeaders as? [String: String]
        return urlRequest
    }

    var request: URLRequest? {
        switch self {
        case .SearchWeather,
             .WeatherDetail:
            return nsUrlRequest
        }
    }

}

