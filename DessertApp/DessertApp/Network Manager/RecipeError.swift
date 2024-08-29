//
//  RecipeError.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Defines custom errors
enum RecipeError: Error {
    case invalidURL
    case errorFetchingRecipes
    case errorDecodingRecipes
    case unknownRecipe
    case other
    case noInternetConnection
}

extension RecipeError {
    var errorTitle: String {
        switch self {
        case .errorFetchingRecipes, .other, .invalidURL, .unknownRecipe, .errorDecodingRecipes:
            return "Uh oh..looks like \n we overcooked this one."
        case .noInternetConnection:
            return "Uh oh..looks like we lost the connection."
        }
        
    }
    
    var errorSubtitle: String {
        switch self {
        case .errorFetchingRecipes, .other, .invalidURL, .unknownRecipe, .errorDecodingRecipes:
            return "There was an issue fetching the receipes. \n Please try again."
        case .noInternetConnection:
            return "You are not connected to the internet. Please reconnect and try again."
        }
    }
}
