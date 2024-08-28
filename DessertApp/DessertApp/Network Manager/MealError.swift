//
//  MealError.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

enum MealError: Error {
    case invalidURL
    case errorFetchingMeals
    case errorDecodingMeals
    case unknownMeal
}
