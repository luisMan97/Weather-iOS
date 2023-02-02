//
//  StringExtensions.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation

extension String {

    static var empty: String { String() }
    
    func queryString(params: [String: Any]) -> String {
        var components = URLComponents(string: self)
        components?.setQueryItems(with: params)
        return components?.url?.absoluteString ?? self
    }
    
    func appendQueryItems(params: [String: Any]) -> String {
        var components = URLComponents(string: self)
        components?.appendQueryItems(with: params)
        return components?.url?.absoluteString ?? self
    }
    
    func parseToInt() -> Int? {
        Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
     }

}

extension String: Identifiable {
    public var id: String { self }
}
