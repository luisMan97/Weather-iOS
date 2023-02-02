//
//  OtherWeatherRowView.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import SwiftUI

struct OtherWeatherRowView: View {
    let forecastDay: ForecastDay
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(forecastDay.date)
        }
    }
}

struct OtherWeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        OtherWeatherRowView(forecastDay: ForecastDay.dummy)
    }
}
