//
//  WeatherCoreDataDataSource.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Combine
import CoreData

class WeatherCoreDataDataSource: NSObject, LocalWeatherDataSource {
    
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
        let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                         managedObjectContext: viewContext,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
        return fetchController
    }()

    // MARK: - Initializers

    override init() {
        super.init()
        weatherFetchController.delegate = self
        getFavoriteWeather()
    }

    // MARK: - Internal Methods
    
    func deleteFavoriteWeather(favoriteWeather: [WeatherCoreData], offsets: IndexSet) {
        offsets.map { favoriteWeather[$0] }.forEach(viewContext.delete)
        saveContext()
    }

    func deleteAllWeather() {
        let fetchRequest: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()

        do {
            let Weather = try viewContext.fetch(fetchRequest)

            Weather.forEach(viewContext.delete)
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Private Methods

    private func getFavoriteWeather() {
        do {
            try weatherFetchController.performFetch()
            weather.value = weatherFetchController.fetchedObjects ?? []
        } catch {
            NSLog(error.localizedDescription)
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate
extension WeatherCoreDataDataSource: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let Weather = controller.fetchedObjects as? [WeatherCoreData] else {
            return
        }
        self.weather.value = Weather
    }
}
