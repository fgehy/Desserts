//
//  Meal.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation


struct Meal {
    let id: String
    let name: String
    let thumbNail: String
    
    let instructions: String?
    let ingredients: [Ingredient]?
}

extension Meal: Hashable, Identifiable {
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.id == rhs.id
    }
}
