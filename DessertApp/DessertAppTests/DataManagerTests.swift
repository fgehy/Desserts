//
//  DataManagerTests.swift
//  DessertAppTests
//
//  Created by Fabrice Gehy on 8/29/24.
//

import XCTest
@testable import DessertApp

final class DataManagerTests: XCTestCase {

    func test_MakeRequestForRecipes_ShouldReceive3Recipes() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO,
                                                                               Stubs.meal2DTO,
                                                                               Stubs.meal3DTO]))
        
        let dataManager = RecipeDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getRecipes(category: .dessert)
        
        //Then
        XCTAssertEqual(data.count, 3)
    }
    
    func test_MakeRequestForRecipeDetail_ShouldReceive1Recipe() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO]))
        
        let dataManager = RecipeDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getRecipeDetails(id: "")
        
        //Then
        XCTAssertEqual(data.name, "Meal 1")
    }
    
    func test_MakeRequestForRecipeDetail_ShouldAlwaysReceiveFirstRecipeInRespnse() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO, Stubs.meal2DTO]))
        
        let dataManager = RecipeDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getRecipeDetails(id: "")
        
        //Then
        XCTAssertEqual(data.name, "Meal 1")
    }
    
    func test_MakeRequestForRecipeDetail_ShouldReceiveCorrectNumberOfIngredientsForRecipe() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO]))
        
        let dataManager = RecipeDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getRecipeDetails(id: "")
        
        //Then
        XCTAssertEqual(data.ingredients?.count, 7)
    }

}
