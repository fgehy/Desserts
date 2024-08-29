//
//  MealDetailViewModelTests.swift
//  DessertAppTests
//
//  Created by Fabrice Gehy on 8/29/24.
//

import XCTest
@testable import DessertApp

final class MealDetailViewModelTests: XCTestCase {

    func test_FetchMeal_ShouldBeInLoadedState() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO]))
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        let viewModel = MealDetailViewModel(dataManager: dataManager, mealId: "")
        
        //When
        await viewModel.fetchDetails()
        
        //Then
        var isLoadedState: Bool {
            switch viewModel.state {
            case .loaded: return true
            default:
                return false
            }
        }
        
        XCTAssertTrue(isLoadedState)
    }

    func test_IssueFetchingMeal_ShouldBeInErrorState() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: nil)
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        let viewModel = MealDetailViewModel(dataManager: dataManager, mealId: "")
        
        //When
        await viewModel.fetchDetails()
        
        //Then
        var isErrorState: Bool {
            switch viewModel.state {
            case .error: return true
            default:
                return false
            }
        }
        
        XCTAssertTrue(isErrorState)
    }

}
