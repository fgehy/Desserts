//
//  RecipeListView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

/// Displays recipe list
struct RecipeListView: View {
    @StateObject private var viewModel: RecipeListViewModel
    
    init(viewModel: RecipeListViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .fetching:
                LoadingView()
            case .loaded(let recipes):
                NavigationStack {
                    List {
                        ForEach(recipes) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeListRow(name: recipe.name.capitalized, thumbnail: recipe.thumbNail)
                            }
                        }
                    }
                    .navigationDestination(for: Recipe.self) { recipe in
                        let viewModel = RecipeDetailViewModel(dataManager: viewModel.dataManager, recipeId: recipe.id)
                        RecipeDetailView(viewModel: viewModel)
                    }
                    .navigationTitle("Recipes")
                }
                
            case .error(let err):
                ErrorView(title: err.errorTitle,
                          subtitle: err.errorSubtitle,
                          buttonText: "Try again") 
                {
                    Task {
                       await viewModel.fetchRecipes()
                    }
                    
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    let networkManager = RecipeNetworkManager(endpoint: "", useLocalResource: true)
    let dataManager = RecipeDataManager(networkManager: networkManager)
    return RecipeListView(viewModel: RecipeListViewModel(dataManager: dataManager))
}
