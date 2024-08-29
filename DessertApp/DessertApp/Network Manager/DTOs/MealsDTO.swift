//
//  MealsDTO.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Data transfer object from remote source for meals
struct MealsDTO: Decodable {
    let meals: [MealDTO]
}
