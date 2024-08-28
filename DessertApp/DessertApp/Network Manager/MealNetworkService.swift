//
//  DessertNetworkService.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

protocol MealNetworkService {    
    func getMeal(id: String?) async throws -> MealsDTO
}
