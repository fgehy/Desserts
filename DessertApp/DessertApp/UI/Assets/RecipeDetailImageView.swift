//
//  RecipeDetailImageView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct RecipeDetailImageView: View {
    let name: String
    let thumbnail: String
    
    var body: some View {
        let url = URL(string: thumbnail)
        
        VStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.yellow
            }
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    RecipeDetailImageView(name: "Apam balik",
                        thumbnail: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
}
