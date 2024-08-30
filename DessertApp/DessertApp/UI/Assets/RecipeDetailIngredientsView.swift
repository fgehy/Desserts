//
//  RecipeDetailIngredientsView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct RecipeDetailIngredientsView: View {
    let title: String
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            
            ForEach(ingredients) { ingredient in
                HStack(spacing: 5) {
                    let url = URL(string: ingredient.thumbnail ?? "")
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.orange.opacity(0.5)
                    }
                    .clipShape(Circle())
                    .frame(width: 25, height: 25)

                    Text(ingredient.name + ":")
                        .font(.callout)
                    
                    Spacer()
                    
                    Text(ingredient.measurement)
                        .font(.callout)
                        .padding(.bottom, 5)
                }
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecipeDetailIngredientsView(title: "Ingredients",
                              ingredients: [.init(name: "Milk", measurement: "200ml"),
                                            .init(name: "Oil", measurement: "60ml"),
                                            .init(name: "Eggs", measurement: "2"),
                                            .init(name: "Flour", measurement: "1600g")])
}
