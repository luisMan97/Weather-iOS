//
//  DayRespone.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation

struct DayRespone: Decodable {
    let maxtemp_c: Double?
    let mintemp_c: Double?
    let condition: ConditionResponse?
}
