//
//  WeatherViewModel.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    // Internal Output Events Properties
    @Published var showProgress = false
    @Published var weather: [Weather] = []
    @Published var favoriteWeather: [WeatherCoreData] = []
    @Published var error: String?
    @Published var showFavorites = false
    
    // Internal Properties
    var searchBar = SearchBar()
    var progressTitle = ""
    var title = "Weather"
    var pickerOptions = ["Ciudades", "Favoritos"]
    var selectorIndex = 0
    
    var pickerOptionsRange: Range<Int> { 0..<pickerOptionsCount }
    var emptyText: String { showFavorites ? "No tienes favoritos guardados." : "Realiza la busqueda colocando el nombre del lugar que quieres ver su clima." }
    
    // Private Properties
    @Published private var searchText: String = ""
    
    private var subscriptions: Set<AnyCancellable> = []
    private var originalWeather: [Weather] = []
    
    private var pickerOptionsCount: Int { pickerOptions.count }
    
    // Interactor
    private var getWeatherUseCase: GetWeatherUseCaseProtocol
    private var getFavoritesWeatherUseCase: GetFavoriteWeatherUseCaseProtocol
    private var deleteFavoriteWeatherUseCase: DeleteFavoriteWeatherUseCaseProtocol
    private var deleteAllWeatherUseCase: DeleteAllWeatherUseCaseProtocol
    
    // MARK: - Initializers
    
    init(getWeatherUseCase: GetWeatherUseCaseProtocol,
         getFavoritesWeatherUseCase: GetFavoriteWeatherUseCaseProtocol,
         deleteFavoriteWeatherUseCase: DeleteFavoriteWeatherUseCaseProtocol,
         deleteAllWeatherUseCase: DeleteAllWeatherUseCaseProtocol) {
        self.getWeatherUseCase = getWeatherUseCase
        self.getFavoritesWeatherUseCase = getFavoritesWeatherUseCase
        self.deleteFavoriteWeatherUseCase = deleteFavoriteWeatherUseCase
        self.deleteAllWeatherUseCase = deleteAllWeatherUseCase
        publishedAssign()
        getFavoriteWeather()
        search()
    }
    
    // MARK: - Internal Methods
    
    @MainActor
    func doSomething(city: String) async {
        progressTitle = "Cargando..."
        showProgress = true
        
        let result = await getWeatherUseCase.invoke(request: .init(city: city))
        
        switch result {
        case .success(let weather):
            initializeWeather(weather)
            originalWeather = self.weather
        case .failure(let error):
            self.error = error.localizedDescription
        }
        showProgress = false
    }
    
    func segmentedChanged(to value: Int) {
        searchText.removeAll()
        showFavorites = value == 1
        initializeWeather(originalWeather)
        originalWeather = weather
        weather = showFavorites ? favoriteWeather.map { $0.toDomain() } : originalWeather
    }
    
    func deleteFavoriteWeather(offsets: IndexSet) {
        deleteFavoriteWeatherUseCase.invoke(favoriteWeather: favoriteWeather, offsets: offsets)
    }

    func deleteAllWeather() {
        deleteAllWeatherUseCase.invoke()
    }
    
    // MARK: - Private Methods
    
    private func publishedAssign() {
        searchBar.$text
            .assign(to: \.searchText, on: self)
            .store(in: &subscriptions)
    }
    
    private func search() {
        $searchText
            .debounce(for: showFavorites ? .zero : .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 && !self.showFavorites {
                    self.weather.removeAll()
                    return nil
                }
                return string
            })
            .compactMap { $0 }
            .sink(receiveValue: { [self] searchField in
                if showFavorites {
                    if searchField.isEmpty {
                        weather = favoriteWeather.map { $0.toDomain() }
                        return
                    }
                    weather = favoriteWeather.map { $0.toDomain() }.filter({ weather in
                        weather.name.contains(searchField)
                    })
                    return
                }
                Task { await self.doSomething(city: searchField) }
            }).store(in: &subscriptions)
    }
    
    private func getFavoriteWeather() {
        getFavoritesWeatherUseCase.invoke()
            .sink { [weak self] favoriteWeather in
                guard let self = self else { return }
                self.favoriteWeather = favoriteWeather
                
                if self.showFavorites {
                    self.initializeWeather(self.favoriteWeather.map { $0.toDomain() })
                } else {
                    self.initializeWeather(self.originalWeather)
                }
        }.store(in: &subscriptions)
    }
    
    private func initializeWeather(_ weather: [Weather]) {
        let weatherIds = favoriteWeather.map { Int($0.id) }
        let noFavoriteRecipes = weather.filter( { !weatherIds.contains($0.id) } )
        self.weather = weather.filter( { weatherIds.contains($0.id) } )
        self.weather.append(contentsOf: noFavoriteRecipes)
    }
    

}
