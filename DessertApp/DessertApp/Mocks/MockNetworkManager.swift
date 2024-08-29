//
//  MockNetworkManager.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/29/24.
//

import Foundation

final class MockNetworkManager: RecipeNetworkService {
    var endpoint: String
    
    private var mealsDTO: MealsDTO?
    
    init(endpoint: String, mealsDTO: MealsDTO? = nil) {
        self.endpoint = endpoint
        self.mealsDTO = mealsDTO
    }
    
    func getRecipes(category: String) async throws -> MealsDTO {
        guard let mealsDTO else { throw RecipeError.errorFetchingRecipes }
        return mealsDTO
    }
    
    func getRecipeDetails(id: String) async throws -> MealsDTO {
        guard let mealsDTO else { throw RecipeError.errorFetchingRecipes }
        return mealsDTO
    }
}

struct Stubs {
    static let meal1DTO = MealDTO(idMeal: "001",
                              strMeal: "Meal 1",
                              strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                              strInstructions: "Test instructions",
                           
                              strIngredient1: "Milk",
                              strIngredient2: "Oil",
                              strIngredient3: "Eggs",
                              strIngredient4: "Flour",
                              strIngredient5: "Baking powder",
                              strIngredient6: "Salt",
                              strIngredient7: "Sugar",
                              strIngredient8: "",
                              strIngredient9: nil,
                              strIngredient10: nil,
                              strIngredient11: nil,
                              strIngredient12: nil,
                              strIngredient13: nil,
                              strIngredient14: nil,
                              strIngredient15: nil,
                              strIngredient16: nil,
                              strIngredient17: "",
                              strIngredient18: nil,
                              strIngredient19: nil,
                              strIngredient20: nil,
                           
                              strMeasure1: "200ml",
                              strMeasure2: "60ml",
                              strMeasure3: "2",
                              strMeasure4: "1600g",
                              strMeasure5: "3 tsp",
                              strMeasure6: "1/2 tsp",
                              strMeasure7: "25g",
                              strMeasure8: nil,
                              strMeasure9: nil,
                              strMeasure10: nil,
                              strMeasure11: nil,
                              strMeasure12: nil,
                              strMeasure13: nil,
                              strMeasure14: nil,
                              strMeasure15: nil,
                              strMeasure16: nil,
                              strMeasure17: nil,
                              strMeasure18: "",
                              strMeasure19: nil,
                              strMeasure20: nil)
    
    
    static let meal2DTO = MealDTO(idMeal: "002",
                              strMeal: "Meal 2",
                              strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                              strInstructions: "Test instructions",
                           
                              strIngredient1: "Milk",
                              strIngredient2: "Oil",
                              strIngredient3: "Eggs",
                              strIngredient4: "Flour",
                              strIngredient5: "Baking powder",
                              strIngredient6: "",
                              strIngredient7: "",
                              strIngredient8: "",
                              strIngredient9: nil,
                              strIngredient10: nil,
                              strIngredient11: nil,
                              strIngredient12: nil,
                              strIngredient13: nil,
                              strIngredient14: nil,
                              strIngredient15: nil,
                              strIngredient16: nil,
                              strIngredient17: "",
                              strIngredient18: nil,
                              strIngredient19: nil,
                              strIngredient20: nil,
                           
                              strMeasure1: "200ml",
                              strMeasure2: "60ml",
                              strMeasure3: "2",
                              strMeasure4: "1600g",
                              strMeasure5: "3 tsp",
                              strMeasure6: "",
                              strMeasure7: " ",
                              strMeasure8: nil,
                              strMeasure9: nil,
                              strMeasure10: nil,
                              strMeasure11: nil,
                              strMeasure12: nil,
                              strMeasure13: nil,
                              strMeasure14: nil,
                              strMeasure15: nil,
                              strMeasure16: nil,
                              strMeasure17: nil,
                              strMeasure18: "",
                              strMeasure19: nil,
                              strMeasure20: nil)
    
    
    static let meal3DTO = MealDTO(idMeal: "003",
                              strMeal: "Meal 3",
                              strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                              strInstructions: "Test instructions",
                           
                              strIngredient1: "Milk",
                              strIngredient2: "Oil",
                              strIngredient3: "Eggs",
                              strIngredient4: "Flour",
                              strIngredient5: nil,
                              strIngredient6: "",
                              strIngredient7: "",
                              strIngredient8: "",
                              strIngredient9: nil,
                              strIngredient10: nil,
                              strIngredient11: nil,
                              strIngredient12: nil,
                              strIngredient13: nil,
                              strIngredient14: nil,
                              strIngredient15: nil,
                              strIngredient16: nil,
                              strIngredient17: "",
                              strIngredient18: nil,
                              strIngredient19: nil,
                              strIngredient20: nil,
                           
                              strMeasure1: "200ml",
                              strMeasure2: "60ml",
                              strMeasure3: "2",
                              strMeasure4: "1600g",
                              strMeasure5: "",
                              strMeasure6: "",
                              strMeasure7: "",
                              strMeasure8: nil,
                              strMeasure9: nil,
                              strMeasure10: nil,
                              strMeasure11: nil,
                              strMeasure12: nil,
                              strMeasure13: nil,
                              strMeasure14: nil,
                              strMeasure15: nil,
                              strMeasure16: nil,
                              strMeasure17: nil,
                              strMeasure18: "",
                              strMeasure19: nil,
                              strMeasure20: nil)
    
    
    
    static let mealsDTO = MealsDTO(meals: [Stubs.meal1DTO,
                                           Stubs.meal2DTO,
                                           Stubs.meal3DTO])
}



