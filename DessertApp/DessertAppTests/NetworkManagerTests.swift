//
//  NetworkManagerTests.swift
//  DessertAppTests
//
//  Created by Fabrice Gehy on 8/29/24.
//

import XCTest
@testable import DessertApp

final class NetworkManagerTests: XCTestCase {
    func test_IssueMakingRemoteRequestForRecipeList_ShouldReceiveFailure() async throws {
        //Given
        let networkManager = RecipeNetworkManager(endpoint: "", useLocalResource: false)
        
        //When
        let data =  try? await networkManager.getRecipes(category: "dessert")
        
        //Then
        XCTAssertNil(data)
    }
    
    func test_IssueMakingRemoteRequestForReceipeDetail_ShouldReceiveFailure() async throws {
        //Given
        let networkManager = RecipeNetworkManager(endpoint: "", useLocalResource: false)
        
        //When
        let data = try? await networkManager.getRecipe(id: "")
        
        //Then
        XCTAssertNil(data)
    }
    
    func test_MakeRequestForRecipeList_ShouldReceive65Recipes() async throws {
        //Given
        let networkManager = RecipeNetworkManager(endpoint: "", useLocalResource: true)
        
        //When
        let data =  try await networkManager.getRecipes(category: "dessert")
        
        //Then
        XCTAssertEqual(data.meals.count, 65)
    }
    
    func test_IssueMakingRemoteRequestForReceipeDetail_ShouldReceiveApaimBalikRecipe() async throws {
        //Given
        let networkManager = RecipeNetworkManager(endpoint: "", useLocalResource: true)
        
        //When
        let data = try await networkManager.getRecipe(id: "")
        
        //Then
        if let meal = data.meals.first {
            XCTAssertEqual(meal.strMeal, "Apam balik")
        } else {
            XCTFail("Did not receive meal")
        }
        
    }
}
