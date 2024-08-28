//
//  Meal.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation


struct Meal: Identifiable {
    let id: String
    let name: String
    let thumbNail: String
    
    let instructions: String?
    let ingredients: [Ingredient]?
}
