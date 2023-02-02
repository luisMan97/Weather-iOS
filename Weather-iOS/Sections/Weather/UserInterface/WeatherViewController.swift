//
//  WeatherViewController.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: WeatherViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Initializers
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        setupSubscribers()
    }
    
    // MARK: - Private Methods
    
    private func doSomething() {
        Task { await viewModel.doSomething(city: "Bogota") }
    }
    
    private func setupSubscribers() {
        viewModel.$showProgress.sink { showProgress in
            print(showProgress)
        }.store(in: &subscriptions)
        
        viewModel.$error.sink { error in
            print(error)
        }.store(in: &subscriptions)
    }
    
}
