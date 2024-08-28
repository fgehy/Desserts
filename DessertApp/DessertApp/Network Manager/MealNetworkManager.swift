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
    
    func getMeal(id: String? = nil) async throws -> MealsDTO {
        guard let url = URL(string: endpoint) else { throw DessertError.invalidURL }
        let data = try await fetchData(for: url)
        return try getDTO(type: MealsDTO.self, data: data)
    }
    
    private func fetchData(for url: URL) async throws -> Data {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode != 404 else {
                throw DessertError.unknownMeal
            }
        
            return data
        } catch {
            throw DessertError.errorFetchingMeals
        }
    }
    
    private func getDTO<T: Decodable>(type: T.Type, data: Data) throws -> T {
        do {
            let dto = try JSONDecoder().decode(T.self, from: data)
            return dto
        } catch {
            throw DessertError.errorDecodingMeals
        }
    }
}
