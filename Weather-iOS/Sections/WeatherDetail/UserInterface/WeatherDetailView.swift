//
//  WeatherDetailView.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import SwiftUI

struct WeatherDetailView: View {
    
    @ObservedObject var viewModel: WeatherDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showOthers = false
    
    private var primaryColor: Color {
        (viewModel.weatherDetail?.current?.isCold ?? false) ? Color.blueCold : Color.orangeHot
    }
    
    var body: some View {
        LoadingView(isShowing: $viewModel.showProgress, text: viewModel.progressTitle) {
            ZStack(alignment: .leading) {
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.weather.name)
                            .bold()
                            .font(.title)
                        
                        Text(viewModel.currentDate)
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud")
                                    .font(.system(size: 40))
                                
                                Text(viewModel.weatherDetail?.current?.textCondition ?? .empty)
                            }
                            .frame(width: 140, alignment: .leading)
                            
                            Spacer()
                            
                            Text(viewModel.weatherDetail?.current?.feelslike ?? .empty)
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        Spacer()
                            .frame(height:  80)
                        
                        Image("city")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Clima actual")
                                .bold()
                            
                            Spacer()
                            
                            Button(action: {
                                showOthers = true
                            }, label: {
                                Text("Ver el clima de los siguientes 4 días")
                                    .font(.caption)
                            })
                        }.padding(.bottom)
                        
                        HStack {
                            WeatherItemView(logo: "thermometer", name: "Temp mínima", value: viewModel.weatherDetail?.forecast?.mintemp ?? .empty)
                            Spacer()
                            WeatherItemView(logo: "thermometer", name: "Temp máxima", value: viewModel.weatherDetail?.forecast?.maxtemp ?? .empty)
                        }
                        
                        HStack {
                            WeatherItemView(logo: "wind", name: "Velocidad del viento", value: viewModel.weatherDetail?.current?.wind ?? .empty)
                            Spacer()
                            WeatherItemView(logo: "humidity", name: "Humedad", value: viewModel.weatherDetail?.current?.humidity ?? .empty)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(primaryColor)
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(primaryColor)
        .navigationBarTitle(viewModel.title)
        .sheet(isPresented: $showOthers) {
            FutureWeather(forecastdays: viewModel.weatherDetail?.forecast?.nextDays ?? [],
                          isPresented: $showOthers,
                          onClose: viewModel.updateViewWithForecast)
        }
        .alert(item: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text($0),
                  dismissButton: .default(Text("Ok"))
            )
        }.toolbar {
            ToolbarItem {
                Button(action: {
                    viewModel.saveWeather()
                }) {
                    let localRecipes = viewModel.favoriteWeather.filter { $0.id == viewModel.weather.id }
                    Label("Add Item", systemImage: localRecipes.isEmpty ? "star" : "star.fill")
                       .foregroundColor(.yellow)
                }
            }
        }.task {
            await viewModel.doSomething()
        }
        .onAppear { isWeatherDetailViewVisible = true }
        .onDisappear { isWeatherDetailViewVisible = false }
    }
    
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailFactory.getWeatherDetailView(Weather.dummy, comesFromFavorites: false, appContainer: AppContainer())
    }
}
