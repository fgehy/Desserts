//
//  DessertAppApp.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

@main
struct DessertApp: App {
    var body: some Scene {
        WindowGroup {
            //TODO: Move endpoint to plist
            let networkManager = MealNetworkManager(endpoint: "https://themealdb.com/api/json/v1/1")
            let dataManager = MealDataManager(networkManager: networkManager)
            let viewModel = MealListViewModel(dataManager: dataManager)
            MealListView(viewModel: viewModel)
        }
    }
}
