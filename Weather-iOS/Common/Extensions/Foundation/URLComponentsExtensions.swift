//
//  URLComponentsExtensions.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 31/01/23.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        queryItems = parameters.map { .init(name: $0.key, value: $0.value as? String) }
    }
    
    mutating func appendQueryItems(with parameters: [String: Any]) {
        queryItems?.append(contentsOf: parameters.map { .init(name: $0.key, value: $0.value as? String) })
    }
    
}
