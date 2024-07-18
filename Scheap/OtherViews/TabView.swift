//
//  TabView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct TabView: View {
    @Binding var activePage: ActivePageItem

    var body: some View {
        HStack {
            TabViewItem(symbol: "house")
                .onTapGesture {
                    activePage = .home
                }
            
            TabViewItem(symbol: "list.bullet.rectangle.portrait")
                .onTapGesture {
                    activePage = .shoppingList
                }
            
            TabViewItem(symbol: "map")
                .onTapGesture {
                    activePage = .map
                }
        }
        .frame(width: 320, height: 80)
        .background(Color.primaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 10)
    }
}

struct TabViewItem: View {
    let symbol: String
    
    var body: some View {
        VStack {
            Image(systemName: symbol)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 70, maxHeight: 50)
        }
        .padding()
    }
}

enum ActivePageItem {
    case home
    case shoppingList
    case map
}

#Preview {
    TabView(activePage: .constant(.home))
}
