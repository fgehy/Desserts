//
//  DataManagerTests.swift
//  DessertAppTests
//
//  Created by Fabrice Gehy on 8/29/24.
//

import XCTest
@testable import DessertApp

final class DataManagerTests: XCTestCase {

    func test_MakeRequestForMeals_ShouldReceive3Meals() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO,
                                                                               Stubs.meal2DTO,
                                                                               Stubs.meal3DTO]))
        
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getMeals(category: .dessert)
        
        //Then
        XCTAssertEqual(data.count, 3)
    }
    
    func test_MakeRequestForMealDetail_ShouldReceive1Meal() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO]))
        
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getMealDetails(id: "")
        
        //Then
        XCTAssertEqual(data.name, "Meal 1")
    }
    
    func test_MakeRequestForMealDetail_ShouldAlwaysReceiveFirstMealInRespnse() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO, Stubs.meal2DTO]))
        
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getMealDetails(id: "")
        
        //Then
        XCTAssertEqual(data.name, "Meal 1")
    }
    
    func test_MakeRequestForMealDetail_ShouldReceiveCorrectNumberOfIngredientsForMeal() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO]))
        
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        
        //When
        let data = try await dataManager.getMealDetails(id: "")
        
        //Then
        XCTAssertEqual(data.ingredients?.count, 7)
    }

}
