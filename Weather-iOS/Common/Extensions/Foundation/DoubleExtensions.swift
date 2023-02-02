//
//  DoubleExtensions.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

extension Double {
    
    func roundDouble() -> String {
        String(format: "%.0f", self)
    }
    
}
