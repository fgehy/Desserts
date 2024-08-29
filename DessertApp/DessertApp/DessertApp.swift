//
//  DessertAppApp.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

@main
struct DessertApp: App {
    let endpoint = Bundle.main.object(forInfoDictionaryKey: "Endpoint") as? String
    var body: some Scene {
        WindowGroup {
            let networkManager = MealNetworkManager(endpoint: endpoint ?? "", useLocalResource: false)
            let dataManager = MealDataManager(networkManager: networkManager)
            let viewModel = MealListViewModel(dataManager: dataManager)
            MealListView(viewModel: viewModel)
        }
    }
}
