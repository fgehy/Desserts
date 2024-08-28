//
//  MealDetailInstructionsView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct MealDetailInstructionsView: View {
    let title: String
    let instructions: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                
            Text(instructions)
                .font(.callout)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MealDetailInstructionsView(title: "Instructions",
                               instructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.")
}
