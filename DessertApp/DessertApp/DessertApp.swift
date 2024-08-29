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
            let networkManager = RecipeNetworkManager(endpoint: endpoint ?? "", useLocalResource: false)
            let dataManager = RecipeDataManager(networkManager: networkManager)
            let viewModel = RecipeListViewModel(dataManager: dataManager)
            RecipeListView(viewModel: viewModel)
        }
    }
}
