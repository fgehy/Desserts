//
//  MealListViewModelTests.swift
//  DessertAppTests
//
//  Created by Fabrice Gehy on 8/29/24.
//

import XCTest
@testable import DessertApp

final class MealListViewModelTests: XCTestCase {

    func test_FetchMeals_ShouldBeInLoadedState() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO, Stubs.meal2DTO]))
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        let viewModel = MealListViewModel(dataManager: dataManager)
        
        //When
        await viewModel.fetchMeals()
        
        //Then
        var fetchedMeals: [Meal] = []
        var isLoadedState: Bool {
            switch viewModel.state {
            case .loaded(let meals):
                fetchedMeals = meals
                return true
            default:
                return false
            }
        }
        
        XCTAssertTrue(isLoadedState)
        XCTAssertEqual(fetchedMeals.count, 2)
    }

    func test_IssueFetchingMeals_ShouldBeInErrorState() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: nil)
        let dataManager = MealDataManager(networkManager: mockNetworkManager)
        let viewModel = MealListViewModel(dataManager: dataManager)
        
        //When
        await viewModel.fetchMeals()
        
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
