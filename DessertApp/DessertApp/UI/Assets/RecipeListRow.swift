//
//  RecipeListRow.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct RecipeListRow: View {
    let name: String
    let thumbnail: String
    
    var body: some View {
        HStack(alignment: .center) {
            let url = URL(string: thumbnail)
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.yellow.opacity(0.5)
            }
            .frame(width: 45, height: 45)
            .clipShape(Circle())

            Text(name)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

#Preview("Downloaded image") {
    
    RecipeListRow(name: "Apam balik", 
                thumbnail: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    
    
}

#Preview("Image placeholder") {
    RecipeListRow(name: "Apam balik",
                thumbnail: "")
}
