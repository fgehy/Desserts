//
//  RecipeDetailViewModel.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

final class RecipeDetailViewModel: ObservableObject {
    private let dataManager: RecipeDataService
    private let recipeId: String
    
    @Published private(set) var state: DataState = .fetching
    
    init(dataManager: RecipeDataService, recipeId: String) {
        self.dataManager = dataManager
        self.recipeId = recipeId
    }
    
    @MainActor
    func fetchDetails() async {
        state = .fetching
        
        do {
            let recipe = try await dataManager.getRecipeDetails(id: recipeId)
            let recipeWithSortedIngredients = Recipe(id: recipe.id,
                                                 name: recipe.name.capitalized,
                                                 thumbNail: recipe.thumbNail,
                                                 instructions: recipe.instructions,
                                                 ingredients: recipe.ingredients?.sorted(by: {$0.name < $1.name }))
            state = .loaded(recipe: recipeWithSortedIngredients)
        } catch {
            if let err = error as? RecipeError {
                state = .error(error: err)
            } else {
                state = .error(error: RecipeError.other)
            }
        }
    }
    
    enum DataState {
        case fetching
        case loaded(recipe: Recipe)
        case error(error: RecipeError)
    }
}
