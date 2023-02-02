//
//  Current.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct Current {
    let textCondition: String
    var feelslike: String
    var wind: String
    var humidity: String
    
    var isCold: Bool { Int(feelslike.parseToInt() ?? 0) < 20 }
}
