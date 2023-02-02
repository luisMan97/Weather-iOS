//
//  WeatherDetailRepository.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import Foundation
import Combine
import CoreData

protocol WeatherDetailRepositoryProtocol {
    func doSomething(request: WeatherDetailRequest) async throws -> WeatherDetail
    func getFavoriteWeather() -> AnyPublisher<[WeatherCoreData], Never>
    func saveWeather(_ weather: Weather)
}

class WeatherDetailRepository: NSObject, WeatherDetailRepositoryProtocol {
    
    // MARK: - Internal Properties

    var weather = CurrentValueSubject<[WeatherCoreData], Never>([])
    
    // MARK: - Private Properties

    private var viewContext = PersistenceController.shared.managedContext
    private var fetchRequest: NSFetchRequest<WeatherCoreData> = {
        let fetchRequest: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return fetchRequest
    }()
    private lazy var weatherFetchController: NSFetchedResultsController<WeatherCoreData> = {
        let recipeFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                             managedObjectContext: viewContext,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        return recipeFetchController
    }()
    
    private var weatherDetail: WeatherDetail?
    
    private var remoteDataSource: RemoteWeatherDetailDataSource
    
    init(remoteDataSource: RemoteWeatherDetailDataSource) {
        self.remoteDataSource = remoteDataSource
        super.init()
        weatherFetchController.delegate = self
        getFavoriteRecipes()
    }
    
    // MARK: - Internal Methods
    
    func doSomething(request: WeatherDetailRequest) async throws -> WeatherDetail {
        let weatherDetail = try await remoteDataSource.doSomething(request: request)
        self.weatherDetail = weatherDetail
        return weatherDetail
    }

    func saveWeather(_ weather: Weather) {
        let localRecipes = getWeather().filter { $0.id == weather.id }
        guard localRecipes.isEmpty else {
            deleteWeather(weather)
            return
        }
        let newItem = WeatherCoreData(context: viewContext)
        weather.toCoreData(newItem)
        weatherDetail?.toCoreData(newItem)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func getFavoriteWeather() -> AnyPublisher<[WeatherCoreData], Never> {
        weather.eraseToAnyPublisher()
    }
    
    // MARK: - Private Methods
    
    private func getWeather() -> [WeatherCoreData] {
        let fetchRequest: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()

        do {
            let recipes = try viewContext.fetch(fetchRequest)
            return recipes
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return []
        }
    }
    
    private func getFavoriteRecipes() {
        do {
            try weatherFetchController.performFetch()
            weather.value = weatherFetchController.fetchedObjects ?? []
        } catch {
            NSLog(error.localizedDescription)
        }
    }
    
    private func deleteWeather(_ weather: Weather) {
        let fetchRequest: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()

        do {
            let recipes = try viewContext.fetch(fetchRequest)

            guard let recipeToDelete = recipes.first(where: { $0.id == weather.id }) else {
                return
            }
            viewContext.delete(recipeToDelete)
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate
extension WeatherDetailRepository: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let Weather = controller.fetchedObjects as? [WeatherCoreData] else {
            return
        }
        self.weather.value = Weather
    }
}
