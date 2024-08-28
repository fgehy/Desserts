//
//  LoadingView.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import SwiftUI

struct LoadingView: View {
    var text: String? = nil
    
    var body: some View {
        ProgressView {
            Text(text ?? "Something good \n is cooking...")
                .font(.headline)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }
        .tint(.black)
        .padding()
        .background {
            Color(red: 211/255, green: 211/255, blue: 211/255)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LoadingView()
}
