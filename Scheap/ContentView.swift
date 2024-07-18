//
//  ContentView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State var activePage: ActivePageItem = .home
    
    var body: some View {
        ZStack {
            switch activePage {
            case .home:
                HomepageView()
            case .shoppingList:
                ShoppingListView()
            case .map:
                StoreMapView()
            }
            VStack {
                Spacer()
                TabView(activePage: $activePage)
            }
        }
    }
}


#Preview {
    ContentView()
}
