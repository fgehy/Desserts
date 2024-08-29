//
//  RecipeCategory.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Defines the different types of recipes
enum RecipeCategory {
    case beef
    case dessert
    case lamb
    case chicken
    case miscellaneous
    case pasta
    case pork
    case side
    case seafood
    case goat
    case breakfast
    case vegetarian
    case vegan
    case starter
    
    var name: String {
        String(describing: self)
    }
}
