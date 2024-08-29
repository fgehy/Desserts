//
//  RecipeListViewModelTests.swift
//  DessertAppTests
//
//  Created by Fabrice Gehy on 8/29/24.
//

import XCTest
@testable import DessertApp

final class RecipeListViewModelTests: XCTestCase {

    func test_FetchRecipes_ShouldBeInLoadedState() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: MealsDTO(meals: [Stubs.meal1DTO, Stubs.meal2DTO]))
        let dataManager = RecipeDataManager(networkManager: mockNetworkManager)
        let viewModel = RecipeListViewModel(dataManager: dataManager)
        
        //When
        await viewModel.fetchRecipes()
        
        //Then
        var fetchedRecipes: [Recipe] = []
        var isLoadedState: Bool {
            switch viewModel.state {
            case .loaded(let recipes):
                fetchedRecipes = recipes
                return true
            default:
                return false
            }
        }
        
        XCTAssertTrue(isLoadedState)
        XCTAssertEqual(fetchedRecipes.count, 2)
    }

    func test_IssueFetchingRecipes_ShouldBeInErrorState() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager(endpoint: "", mealsDTO: nil)
        let dataManager = RecipeDataManager(networkManager: mockNetworkManager)
        let viewModel = RecipeListViewModel(dataManager: dataManager)
        
        //When
        await viewModel.fetchRecipes()
        
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
