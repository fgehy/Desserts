//
//  MealDetailViewModel.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

final class MealDetailViewModel: ObservableObject {
    private let dataManager: MealDataService
    private let mealId: String
    
    @Published private(set) var state: DataState = .fetching
    
    init(dataManager: MealDataService, mealId: String) {
        self.dataManager = dataManager
        self.mealId = mealId
    }
    
    @MainActor
    func fetchDetails() async {
        state = .fetching
        
        do {
            let meal = try await dataManager.getMealDetails(id: mealId)
            let mealWithSortedIngredients = Meal(id: meal.id,
                                                 name: meal.name,
                                                 thumbNail: meal.thumbNail,
                                                 instructions: meal.instructions,
                                                 ingredients: meal.ingredients?.sorted(by: {$0.name < $1.name }))
            state = .loaded(meal: mealWithSortedIngredients)
        } catch {
            if let err = error as? MealError {
                state = .error(error: err)
            } else {
                state = .error(error: MealError.other)
            }
        }
    }
    
    enum DataState {
        case fetching
        case loaded(meal: Meal)
        case error(error: MealError)
    }
}
