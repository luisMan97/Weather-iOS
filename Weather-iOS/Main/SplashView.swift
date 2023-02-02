//
//  SplashView.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive: Bool = false
    @State private var width: CGFloat = 45
    @State private var height: CGFloat = 55
    
    var body: some View {
        ZStack {
            if isActive {
                WeatherFactory.getWeatherView(appContainer: AppContainer())
            } else {
                VStack {
                    HStack {
                        Image("cloud")
                            .resizable()
                            .frame(width: 120, height: 80)
                            .padding(.top)
                            .offset(x: (width * 2))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Image("cloud")
                            .resizable()
                            .frame(width: 120, height: 80)
                            .padding(.top)
                            .offset(x: -(width * 2))
                    }
                    
                    Spacer()
                }
                
                Image("weather")
                    .resizable()
                    .frame(width: width, height: height)
                    .onAnimationCompleted(for: width) {
                        withAnimation { self.isActive = true }
                    }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.default.speed(0.5)) {
                    self.width += 200
                    self.height += 200
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
