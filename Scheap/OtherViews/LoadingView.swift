//
//  LoadingView.swift
//  Scheap
//
//  Created by Anda Levente on 13/08/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Listák összeállítása")
                .progressViewStyle(CircularProgressViewStyle())
                .tint(Color.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primaryBackground)
    }
}

#Preview {
    LoadingView()
}
