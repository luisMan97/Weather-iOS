//
//  FutureWeather.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import SwiftUI

struct FutureWeather: View {
    
    var forecastdays: [ForecastDay]
    @Binding var isPresented: Bool
    var onClose: (ForecastDay) -> ()
    
    var body: some View {
        VStack {
            VStack {
                HandleBar()
                    .padding(.vertical, 10)
                
            }.frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.handlebarBackgroundGrayColor)
            
            Text("Selecciona el clima del día que quieres ver.")
                .padding(.top)
            
            List {
                ForEach(forecastdays) { forecastday in
                    OtherWeatherRowView(forecastDay: forecastday)
                        .onTapGesture {
                            onClose(forecastday)
                            isPresented = false
                        }
                }
            }
        }
    }
    
}

struct FutureWeather_Previews: PreviewProvider {
    static var previews: some View {
        FutureWeather(forecastdays: [ForecastDay.dummy], isPresented: .constant(false), onClose: { _ in })
    }
}
