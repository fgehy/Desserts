//
//  MealListView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel: MealListViewModel
    
    init(viewModel: MealListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .fetching:
                LoadingView()
            case .loaded(let meals):
                List {
                    ForEach(meals) { meal in
                        MealListRow(name: meal.name, thumbnail: meal.thumbNail)
                    }
                }
            case .error(let err):
                ErrorView(title: err.errorTitle,
                          subtitle: err.errorSubtitle,
                          buttonText: "Try again") 
                {
                    Task {
                       await viewModel.fetchMeals()
                    }
                    
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetchMeals()
        }
    }
}

#Preview {
    let networkManager = MealNetworkManager(endpoint: "https://themealdb.com/api/json/v1/1")
    let dataManager = MealDataManager(networkManager: networkManager)
    return MealListView(viewModel: MealListViewModel(dataManager: dataManager))
}
