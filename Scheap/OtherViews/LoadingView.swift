//
//  LoadingView.swift
//  Scheap
//
//  Created by Anda Levente on 13/08/2024.
//

import SwiftUI

struct LoadingView: View {
    var title: String
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2.0)
                .progressViewStyle(CircularProgressViewStyle())
                .tint(Color.white)
                .padding()
            Text(title)
                .foregroundStyle(Color.white)
        }
        .frame(width: 200, height: 200)
        .background(Color.secondaryBackground)
        .opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    init(_ title: String) {
        self.title = title
    }
}

#Preview {
    LoadingView("Listák összeállítása")
}
