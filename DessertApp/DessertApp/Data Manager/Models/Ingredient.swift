//
//  Ingredient.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

struct Ingredient: Identifiable {
    var id: String {
        name
    }
    
    let name: String
    let measurement: String
}
