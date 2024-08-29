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
                NavigationStack {
                    List {
                        ForEach(meals) { meal in
                            NavigationLink(value: meal) {
                                MealListRow(name: meal.name.capitalized, thumbnail: meal.thumbNail)
                            }
                        }
                    }
                    .navigationDestination(for: Meal.self) { meal in
                        let viewModel = MealDetailViewModel(dataManager: viewModel.dataManager, mealId: meal.id)
                        MealDetailView(viewModel: viewModel)
                    }
                    .navigationTitle("Recipes")
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
    let networkManager = MealNetworkManager(endpoint: "", useLocalResource: true)
    let dataManager = MealDataManager(networkManager: networkManager)
    return MealListView(viewModel: MealListViewModel(dataManager: dataManager))
}
