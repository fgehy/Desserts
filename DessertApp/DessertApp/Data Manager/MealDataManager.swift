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
            if !name.isEmpty || !measurement.isEmpty {
                return .init(name: name, measurement: measurement)
            }
        }
        
        return nil
    }
    
    private func getIngredients(meal: MealDTO) -> [Ingredient] {
        //TODO: Redo ingredient conversion
        let ingredients: [Ingredient] = {
            var array: [Ingredient] = []
            
            if let name = meal.strIngredient1, let measurement = meal.strMeasure1 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient2, let measurement = meal.strMeasure2 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient3, let measurement = meal.strMeasure3 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient4, let measurement = meal.strMeasure4 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient5, let measurement = meal.strMeasure5 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient6, let measurement = meal.strMeasure6 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient7, let measurement = meal.strMeasure7 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient8, let measurement = meal.strMeasure8 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient9, let measurement = meal.strMeasure9 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient10, let measurement = meal.strMeasure10 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient11, let measurement = meal.strMeasure11 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient12, let measurement = meal.strMeasure12 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient13, let measurement = meal.strMeasure13 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient14, let measurement = meal.strMeasure14 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient15, let measurement = meal.strMeasure15 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient16, let measurement = meal.strMeasure16 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient17, let measurement = meal.strMeasure17 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient18, let measurement = meal.strMeasure18 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient19, let measurement = meal.strMeasure19 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            if let name = meal.strIngredient20, let measurement = meal.strMeasure20 {
                if let ingredient = convertIngredient(name: name, measurement: measurement) {
                    array.append(ingredient)
                }
            }
            
            return array
        }()
        
        return ingredients
    }
}
