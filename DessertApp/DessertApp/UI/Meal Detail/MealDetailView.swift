//
//  MealDetailView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel: MealDetailViewModel
    
    init(viewModel: MealDetailViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .fetching:
                LoadingView()
            case .loaded(let meal):
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Spacer()
                            MealDetailImageView(name: meal.name,
                                                thumbnail: meal.thumbNail)
                            Spacer()
                        }
                        
                        if let ingredients = meal.ingredients {
                            MealDetailIngredientsView(title: "Ingredients",
                                                      ingredients: ingredients)
                        }
                        
                        if let instructions = meal.instructions {
                            MealDetailInstructionsView(title: "Instructions",
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
    let networkManager = MealNetworkManager(endpoint: "", useLocalResource: true)
    let dataManager = MealDataManager(networkManager: networkManager)
    
    return MealDetailView(viewModel: .init(dataManager: dataManager, mealId: "53049"))
}
