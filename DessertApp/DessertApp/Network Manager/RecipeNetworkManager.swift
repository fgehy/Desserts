//
//  RecipeNetworkManager.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Handles all actions needed to obtain recipe data from a remote source
actor RecipeNetworkManager: RecipeNetworkService {
    nonisolated var endpoint: String {
        endpointValue
    }
    
    private let endpointValue: String
    private let useLocalResource: Bool
    
    init(endpoint: String, 
         useLocalResource: Bool = false) {
        self.endpointValue = endpoint
        self.useLocalResource = useLocalResource
    }
    
    /// Handles the fetching of all recipes for a selected filter from a remote source
    /// - Parameter category: the recipe type to fetch
    /// - Returns: Data transfer object of a recipe list
    func getRecipes(category: String) async throws -> MealsDTO {
        guard useLocalResource else {
            let categoryEndpoint = endpoint + "/filter.php?c=\(category)"
            guard let url = URL(string: categoryEndpoint) else { throw handleFetchError(error: RecipeError.invalidURL) }
            let data = try await fetchData(for: url)
            return try getDTO(type: MealsDTO.self, data: data)
        }
        return try getDTO(type: MealsDTO.self, data: try getLocalResourceMeals())
    }
    
    /// Handles the fetching of details for a individual recipe from a remote source
    /// - Parameter id: The id of the recipe to fetch
    /// - Returns: Data transfer object of a recipe list containing one recipe (corresponding to the `id`) provided
    func getRecipeDetails(id: String) async throws -> MealsDTO {
        guard useLocalResource else {
            let detailEndpoint = endpoint + "/lookup.php?i=\(id)"
            guard let url = URL(string: detailEndpoint) else { throw handleFetchError(error: RecipeError.invalidURL) }
            
            let data = try await fetchData(for: url)
            return try getDTO(type: MealsDTO.self, data: data)
        }
        return try getDTO(type: MealsDTO.self, data: try getLocalResourceMealDetails())
    }
    
    private func fetchData(for url: URL) async throws -> Data {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode != 404 else {
                throw handleFetchError(error: RecipeError.unknownRecipe)
            }
        
            return data
        } catch {
            throw handleFetchError(error: error)
        }
    }
    
    private func handleFetchError(error: Error) -> Error {
        if let err = error as? RecipeError {
            switch err {
            case .invalidURL:
                print("RecipeError: Invalid URL")
            case .errorFetchingRecipes:
                print("RecipeError: Could not fetch meals")
            case .errorDecodingRecipes:
                print("RecipeError: Could not decode fetched meals")
            case .unknownRecipe:
                print("RecipeError: Cound not find meal for selected id")
            case .noInternetConnection:
                print("RecipeError: Not connected to the internet")
             default:
                print("RecipeError: unknown")
            }
        } else {
            print("Error: \(error.localizedDescription)")
        }
        
        
        if let err = error as? URLError {
            switch URLError.Code(rawValue: err.errorCode) {
            case .notConnectedToInternet, .networkConnectionLost, .badServerResponse:
                return handleFetchError(error: RecipeError.noInternetConnection)
            default: return handleFetchError(error: RecipeError.errorFetchingRecipes)
            }
        } else {
            return error
        }
    }
    
    private func getDTO<T: Decodable>(type: T.Type, data: Data) throws -> T {
        do {
            let dto = try JSONDecoder().decode(T.self, from: data)
            return dto
        } catch {
            throw handleFetchError(error: RecipeError.errorDecodingRecipes)
        }
    }
    
    private func getLocalResourceMeals() throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: "MealsDTO", withExtension: "json") else { throw handleFetchError(error: RecipeError.errorFetchingRecipes) }
        return try Data(contentsOf: fileURL)
    }
    
    private func getLocalResourceMealDetails() throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: "MealDTO_Apaim_Balik", withExtension: "json") else { throw handleFetchError(error: RecipeError.errorFetchingRecipes) }
        return try Data(contentsOf: fileURL)
    }
}
