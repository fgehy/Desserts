//
//  Recipe.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Defines a single recipe
struct Recipe {
    let id: String
    let name: String
    let thumbNail: String
    
    let instructions: String?
    let ingredients: [Ingredient]?
}

extension Recipe: Hashable, Identifiable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
