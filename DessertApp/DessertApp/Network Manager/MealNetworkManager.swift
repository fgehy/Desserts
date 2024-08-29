//
//  DessertDataManager.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

actor MealNetworkManager: MealNetworkService {
    
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
    
    func getMeals(category: String) async throws -> MealsDTO {
        guard useLocalResource else {
            let categoryEndpoint = endpoint + "/filter.php?c=\(category)"
            guard let url = URL(string: categoryEndpoint) else { throw handleFetchError(error: MealError.invalidURL) }
            let data = try await fetchData(for: url)
            return try getDTO(type: MealsDTO.self, data: data)
        }
        return try getDTO(type: MealsDTO.self, data: try getLocalResourceMeals())
    }
    
    func getMeal(id: String) async throws -> MealsDTO {
        guard useLocalResource else {
            let detailEndpoint = endpoint + "/lookup.php?i=\(id)"
            guard let url = URL(string: detailEndpoint) else { throw handleFetchError(error: MealError.invalidURL) }
            
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
                throw handleFetchError(error: MealError.unknownMeal)
            }
        
            return data
        } catch {
            throw handleFetchError(error: error)
        }
    }
    
    private func handleFetchError(error: Error) -> Error {
        if let err = error as? MealError {
            switch err {
            case .invalidURL:
                print("MealError: Invalid URL")
            case .errorFetchingMeals:
                print("MealError: Could not fetch meals")
            case .errorDecodingMeals:
                print("MealError: Could not decode fetched meals")
            case .unknownMeal:
                print("MealError: Cound not find meal for selected id")
            case .noInternetConnection:
                print("MealError: Not connected to the internet")
             default:
                print("MealError: unknown")
            }
        } else {
            print("Error: \(error.localizedDescription)")
        }
        
        
        if let err = error as? URLError {
            switch URLError.Code(rawValue: err.errorCode) {
            case .notConnectedToInternet, .networkConnectionLost, .badServerResponse:
                return handleFetchError(error: MealError.noInternetConnection)
            default: return handleFetchError(error: MealError.errorFetchingMeals)
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
            throw handleFetchError(error: MealError.errorDecodingMeals)
        }
    }
    
    private func getLocalResourceMeals() throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: "MealsDTO", withExtension: "json") else { throw handleFetchError(error: MealError.errorFetchingMeals) }
        return try Data(contentsOf: fileURL)
    }
    
    private func getLocalResourceMealDetails() throws -> Data {
        guard let fileURL = Bundle.main.url(forResource: "MealDTO_Apaim_Balik", withExtension: "json") else { throw handleFetchError(error: MealError.errorFetchingMeals) }
        return try Data(contentsOf: fileURL)
    }
}
