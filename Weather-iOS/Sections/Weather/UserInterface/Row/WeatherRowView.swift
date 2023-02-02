//
//  WeatherRowView.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 31/01/23.
//

import SwiftUI

struct WeatherRowView: View {
    
    let weather: Weather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weather.name)
            
            Text(weather.ubication)
        }
    }
}

struct WeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRowView(weather: Weather.dummy)
    }
}
