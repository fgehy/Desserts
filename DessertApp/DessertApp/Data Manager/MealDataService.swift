//
//  MealDataService.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

protocol MealDataService {
    var networkManager: MealNetworkService { get }
    func getMeals(category: MealCategory) async throws -> [Meal]
    func getMealDetails(id: String) async throws -> Meal
}
