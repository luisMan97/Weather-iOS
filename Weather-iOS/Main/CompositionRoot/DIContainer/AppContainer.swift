//
//  Wather_iOSApp.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 29/01/23.
//

import Foundation

protocol AppContainerProtocol {
    var apiManager: APIManagerProtocol { get }
}

struct AppContainer: AppContainerProtocol {
    var apiManager: APIManagerProtocol = APIManager()
}
