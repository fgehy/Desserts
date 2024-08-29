//
//  RecipeDetailView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

/// Displays recipe details
struct RecipeDetailView: View {
    @StateObject private var viewModel: RecipeDetailViewModel
    
    init(viewModel: RecipeDetailViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .fetching:
                LoadingView()
            case .loaded(let recipe):
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Spacer()
                            RecipeDetailImageView(name: recipe.name,
                                                thumbnail: recipe.thumbNail)
                            Spacer()
                        }
                        
                        if let ingredients = recipe.ingredients {
                            RecipeDetailIngredientsView(title: "Ingredients",
                                                      ingredients: ingredients)
                        }
                        
                        if let instructions = recipe.instructions {
                            RecipeDetailInstructionsView(title: "Instructions",
                                                       instructions: instructions)
                        }
                    }
                }
            case .error(let err):
                ErrorView(title: err.errorTitle,
                          subtitle: err.errorSubtitle,
                          buttonText: "Try again")
                {
                    Task {
                       await viewModel.fetchDetails()
                    }
                    
                }
                .padding()
            }
        }
        .toolbarRole(.editor)
        .task {
            await viewModel.fetchDetails()
        }
        
    }
}

#Preview {
    let networkManager = RecipeNetworkManager(endpoint: "", useLocalResource: true)
    let dataManager = RecipeDataManager(networkManager: networkManager)
    
    return RecipeDetailView(viewModel: .init(dataManager: dataManager, recipeId: "53049"))
}
