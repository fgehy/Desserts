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
    case other
    case noInternetConnection
}

extension MealError {
    var errorTitle: String {
        switch self {
        case .errorFetchingMeals, .other, .invalidURL, .unknownMeal, .errorDecodingMeals:
            return "Uh oh..looks like \n we overcooked this one."
        case .noInternetConnection:
            return "Uh oh..looks like we lost the connection."
        }
        
    }
    
    var errorSubtitle: String {
        switch self {
        case .errorFetchingMeals, .other, .invalidURL, .unknownMeal, .errorDecodingMeals:
            return "There was an issue fetching the receipes. \n Please try again."
        case .noInternetConnection:
            return "You are not connected to the internet. Please reconnect and try again."
        }
    }
}
