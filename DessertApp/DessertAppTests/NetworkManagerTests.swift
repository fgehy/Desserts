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
        let networkManager = MealNetworkManager(endpoint: "", useLocalResource: false)
        
        //When
        let data =  try? await networkManager.getMeals(category: "dessert")
        
        //Then
        XCTAssertNil(data)
    }
    
    func test_IssueMakingRemoteRequestForReceipeDetail_ShouldReceiveFailure() async throws {
        //Given
        let networkManager = MealNetworkManager(endpoint: "", useLocalResource: false)
        
        //When
        let data = try? await networkManager.getMeal(id: "")
        
        //Then
        XCTAssertNil(data)
    }
    
    func test_MakeRequestForRecipeList_ShouldReceive65Recipes() async throws {
        //Given
        let networkManager = MealNetworkManager(endpoint: "", useLocalResource: true)
        
        //When
        let data =  try await networkManager.getMeals(category: "dessert")
        
        //Then
        XCTAssertEqual(data.meals.count, 65)
    }
    
    func test_IssueMakingRemoteRequestForReceipeDetail_ShouldReceiveApaimBalikMeal() async throws {
        //Given
        let networkManager = MealNetworkManager(endpoint: "", useLocalResource: true)
        
        //When
        let data = try await networkManager.getMeal(id: "")
        
        //Then
        if let meal = data.meals.first {
            XCTAssertEqual(meal.strMeal, "Apam balik")
        } else {
            XCTFail("Did not receive meal")
        }
        
    }
}
