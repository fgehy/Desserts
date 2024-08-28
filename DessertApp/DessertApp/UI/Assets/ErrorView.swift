//
//  ErrorView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct ErrorView: View {

    let title: String
    let subtitle: String
    let buttonText: String
    let buttonAction: () -> Void
    
    private let imageName = "exclamationmark.triangle.fill"
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .imageScale(.small)
                .foregroundStyle(.yellow)
                .frame(maxWidth: 100)
            
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Button(action: {
                buttonAction()
            }, label: {
                Text(buttonText)
                    .font(.callout)
                    .padding(10)
                    .background(content: { Color.blue })
                    .foregroundStyle(Color.white)
                    .clipShape(Capsule())
            })
        }
    }
}

#Preview {
    ErrorView(title: "Test title", subtitle: "Test subtitle", buttonText: "Button title", buttonAction: {})
}

