//
//  WeatherView.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        LoadingView(isShowing: $viewModel.showProgress, text: viewModel.progressTitle) {
            NavigationView {
                VStack {
                    Picker(String(),
                           selection: $viewModel.selectorIndex.onChange(segmentedChanged)) {
                        ForEach(viewModel.pickerOptionsRange, id: \.self) { index in
                            Text(viewModel.pickerOptions[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top)
                    
                    if viewModel.weather.isEmpty {
                        Text(viewModel.emptyText)
                            .font(.system(.title3, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        List {
                            ForEach(viewModel.weather) { weather in
                                NavigationLink {
                                    WeatherDetailFactory.getWeatherDetailView(weather, comesFromFavorites: viewModel.showFavorites, appContainer: AppContainer())
                                } label: {
                                    WeatherRowView(weather: weather)
                                }
                            }.onDelete(perform: deleteItems)
                        }
                    }
                    
                    Spacer()
                }
                .preferredColorScheme(.dark)
                .add(viewModel.searchBar)
                .navigationBarTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { rightButton }
                }
                .environment(\.editMode, $editMode)
            }
        }
        .alert(item: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text($0),
                  dismissButton: .default(Text("Ok"))
            )
        }
        .onChange(of: viewModel.favoriteWeather) { _ in
            if editMode == .active && viewModel.favoriteWeather.isEmpty {
                editMode = .inactive
            }
        }
    }
    
    private var rightButton: some View {
        return Group {
            switch viewModel.showFavorites {
            case true:
                editButton
            case false:
                EmptyView()
            }
        }
    }
    
    private var editButton: some View {
        return Group {
            switch editMode {
            case .inactive:
                if viewModel.favoriteWeather.isEmpty {
                    EmptyView()
                } else {
                    EditButton()
                }
            case .active:
                EditButton()
            default:
                EmptyView()
            }
        }
    }
    
    private func segmentedChanged(to value: Int) {
        if value == 0 { editMode = .inactive }
        viewModel.segmentedChanged(to: value)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation { viewModel.deleteFavoriteWeather(offsets: offsets) }
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherFactory.getWeatherView(appContainer: AppContainer())
    }
}
