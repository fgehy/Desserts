//
//  RecipeDataManager.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Handles the fetching of recipe data including converting models from a remote source into custom types
actor RecipeDataManager: RecipeDataService {
    let networkManager: RecipeNetworkService
    
    init(networkManager: RecipeNetworkService) {
        self.networkManager = networkManager
    }
    
    /// Gets a list of recipes for the selected category
    /// - Parameter category: category of recipe to fetch
    /// - Returns: an array of Recipe objects for the provided category
    func getRecipes(category: RecipeCategory) async throws -> [Recipe] {
        let data = try await networkManager.getRecipes(category: category.name)
        guard let meals = data.meals else { return [] }
        let recipes = meals.map { dto in
            Recipe(id: dto.idMeal,
                 name: dto.strMeal,
                 thumbNail: dto.strMealThumb,
                 instructions: dto.strInstructions,
                 ingredients: getIngredients(meal: dto))
        }
        
        return recipes
    }
    
    /// Gets the details for a recipe
    /// - Parameter id: the id of the recipe
    /// - Returns: the Recipe object for the `id`
    func getRecipeDetails(id: String) async throws -> Recipe {
        guard let recipe = try await networkManager.getRecipeDetails(id: id).meals?.first else { throw RecipeError.unknownRecipe }
        return Recipe(id: recipe.idMeal,
                    name: recipe.strMeal,
                    thumbNail: recipe.strMealThumb,
                    instructions: recipe.strInstructions,
                    ingredients: getIngredients(meal: recipe))
    }
    
    private func convertIngredient(name: String?, measurement: String?) -> Ingredient? {
        if let name, let measurement {
            if !name.isEmpty && !measurement.isEmpty {
                return .init(name: name.capitalized, 
                             measurement: measurement,
                             thumbnail: "https://www.themealdb.com/images/ingredients/\(name)-Small.png")
            }
        }
        return nil
    }
    
    private func getIngredients(meal: MealDTO) -> [Ingredient] {
        //Note: I decided to use a tuple instead of a dictionary because some recipes have more than 1 of the same ingredient (e.g. butter for Apple & Blackberry Crumble). Because of this, the key/value would overwrite itself when using a dictionary and only 1 would display. I made the assumption we want to display all ingredients provided by the source of truth since there are occurences where same ingredient has different measurements. A source of truth/back-end update to the ingredients DTO would fix this without requiring an app update.
        var ingredientsTuple: [(String?, String?)] = []
        ingredientsTuple.append((meal.strIngredient1, meal.strMeasure1))
        ingredientsTuple.append((meal.strIngredient2, meal.strMeasure2))
        ingredientsTuple.append((meal.strIngredient3, meal.strMeasure3))
        ingredientsTuple.append((meal.strIngredient4, meal.strMeasure4))
        ingredientsTuple.append((meal.strIngredient5, meal.strMeasure5))
        ingredientsTuple.append((meal.strIngredient6, meal.strMeasure6))
        ingredientsTuple.append((meal.strIngredient7, meal.strMeasure7))
        ingredientsTuple.append((meal.strIngredient8, meal.strMeasure8))
        ingredientsTuple.append((meal.strIngredient9, meal.strMeasure9))
        ingredientsTuple.append((meal.strIngredient10, meal.strMeasure10))
        ingredientsTuple.append((meal.strIngredient11, meal.strMeasure11))
        ingredientsTuple.append((meal.strIngredient12, meal.strMeasure12))
        ingredientsTuple.append((meal.strIngredient13, meal.strMeasure13))
        ingredientsTuple.append((meal.strIngredient14, meal.strMeasure14))
        ingredientsTuple.append((meal.strIngredient15, meal.strMeasure15))
        ingredientsTuple.append((meal.strIngredient16, meal.strMeasure16))
        ingredientsTuple.append((meal.strIngredient17, meal.strMeasure17))
        ingredientsTuple.append((meal.strIngredient18, meal.strMeasure18))
        ingredientsTuple.append((meal.strIngredient19, meal.strMeasure19))
        ingredientsTuple.append((meal.strIngredient20, meal.strMeasure20))
        
        var ingredients: [Ingredient] = []
        for (name, measurement) in ingredientsTuple {
            if let ingredient = convertIngredient(name: name, measurement: measurement) {
                ingredients.append(ingredient)
            }
        }
        return ingredients
    }
}
