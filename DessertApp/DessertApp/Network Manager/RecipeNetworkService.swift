//
//  RecipeNetworkService.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// A type that can fetch recipe data from a remote source
protocol RecipeNetworkService {
    var endpoint: String { get }
    func getRecipes(category: String) async throws -> MealsDTO
    func getRecipe(id: String) async throws -> MealsDTO
}
