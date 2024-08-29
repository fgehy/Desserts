//
//  DessertNetworkService.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

protocol MealNetworkService {  
    var endpoint: String { get }
    func getMeals(category: String) async throws -> MealsDTO
    func getMeal(id: String) async throws -> MealsDTO
}
