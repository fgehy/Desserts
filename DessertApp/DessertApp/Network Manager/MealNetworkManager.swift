//
//  DessertDataManager.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

actor MealNetworkManager: MealNetworkService {
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func getMeals(category: String) async throws -> MealsDTO {
        let categoryEndpoint = endpoint + "/filter.php?c=\(category)"
        guard let url = URL(string: categoryEndpoint) else { throw MealError.invalidURL }
        
        let data = try await fetchData(for: url)
        return try getDTO(type: MealsDTO.self, data: data)
    }
    
    func getMeal(id: String) async throws -> MealsDTO {
        let detailEndpoint = endpoint + "/lookup.php?i=\(id)"
        guard let url = URL(string: detailEndpoint) else { throw MealError.invalidURL }
        
        let data = try await fetchData(for: url)
        return try getDTO(type: MealsDTO.self, data: data)
    }
    
    private func fetchData(for url: URL) async throws -> Data {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode != 404 else {
                throw MealError.unknownMeal
            }
        
            return data
        } catch {
            throw handleFetchError(error: error)
        }
    }
    
    private func handleFetchError(error: Error) -> Error {
        print("Error: \(error.localizedDescription)")
        
        if let err = error as? URLError {
            switch URLError.Code(rawValue: err.errorCode) {
            case .notConnectedToInternet, .networkConnectionLost, .badServerResponse:
                return MealError.noInternetConnection
            default: return MealError.errorFetchingMeals
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
            throw MealError.errorDecodingMeals
        }
    }
}
