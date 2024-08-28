//
//  MealListViewModel.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

enum DataState {
    case fetching
    case loaded(meals: [Meal])
    case error(error: MealError)
}

final class MealListViewModel: ObservableObject {
    let dataManager: MealDataService
    @Published private(set) var state: DataState = .fetching
    
    init(dataManager: MealDataService) {
        self.dataManager = dataManager
    }
    
    @MainActor
    func fetchMeals() async {
        state = .fetching
        
        do {
            let meals = try await dataManager.getMeals(category: .dessert).sorted(by: { $0.name < $1.name } )
            state = .loaded(meals: meals)
        } catch {
            if let err = error as? MealError {
                state = .error(error: err)
            } else {
                state = .error(error: MealError.other)
            }
            
        }
    }
}
