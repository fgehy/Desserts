//
//  Ingredient.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

/// Defines an ingredient for a recipe
struct Ingredient {
    var id: String {
        UUID().uuidString
    }
    
    let name: String
    let measurement: String
}

extension Ingredient: Hashable, Identifiable {}
