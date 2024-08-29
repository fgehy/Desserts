//
//  MealDataManager.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

actor MealDataManager: MealDataService {
    let networkManager: MealNetworkService
    
    init(networkManager: MealNetworkService) {
        self.networkManager = networkManager
    }
    
    func getMeals(category: MealCategory) async throws -> [Meal] {
        let data = try await networkManager.getMeals(category: category.name)
        let meals = data.meals.map { dto in
            Meal(id: dto.idMeal,
                 name: dto.strMeal,
                 thumbNail: dto.strMealThumb,
                 instructions: dto.strInstructions,
                 ingredients: getIngredients(meal: dto))
        }
        
        return meals
    }
    
    func getMealDetails(id: String) async throws -> Meal {
        guard let meal = try await networkManager.getMeal(id: id).meals.first else { throw MealError.unknownMeal }
        return Meal(id: meal.idMeal,
                    name: meal.strMeal,
                    thumbNail: meal.strMealThumb,
                    instructions: meal.strInstructions,
                    ingredients: getIngredients(meal: meal))
    }
    
    private func convertIngredient(name: String?, measurement: String?) -> Ingredient? {
        if let name, let measurement {
            if !name.isEmpty && !measurement.isEmpty {
                return .init(name: name.capitalized, measurement: measurement)
            }
        }
        
        return nil
    }
    
    private func addToIngredientArray(name: String?, measurement: String?) {
        if let name, let measurement {
            if let ingredient = convertIngredient(name: name, measurement: measurement) {
                
            }
        }
    }
    
    private func getIngredients(meal: MealDTO) -> [Ingredient] {
        //Note: I decided to use a tuple instead of a dictionary because some reciples have more than 1 of the same ingredient (i.e. butter for Apple & Blackberry Crumble). Because of this, the key would overwrite itself. I made the assumption we want to display all ingredients provided by the source of truth so decided to use a tuple to accomplish this instead.
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
