//
//  RecipeDataService.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// A type that can provide recipe data
protocol RecipeDataService {
    var networkManager: RecipeNetworkService { get }
    func getRecipes(category: RecipeCategory) async throws -> [Recipe]
    func getRecipeDetails(id: String) async throws -> Recipe
}
