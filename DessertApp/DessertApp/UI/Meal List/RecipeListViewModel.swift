//
//  RecipeListViewModel.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

final class RecipeListViewModel: ObservableObject {
    let dataManager: RecipeDataService
    @Published private(set) var state: DataState = .fetching
    
    init(dataManager: RecipeDataService) {
        self.dataManager = dataManager
    }
    
    @MainActor
    func fetchRecipes() async {
        state = .fetching
        
        do {
            let recipes = try await dataManager.getRecipes(category: .dessert).sorted(by: { $0.name < $1.name } )
            state = .loaded(recipes: recipes)
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
        case loaded(recipes: [Recipe])
        case error(error: RecipeError)
    }
}
