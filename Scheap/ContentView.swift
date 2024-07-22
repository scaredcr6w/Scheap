//
//  ContentView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State var activePage: ActivePageItem = .home
    @State private var keyboardActive: Bool = false
    
    var body: some View {
        ZStack {
            HomepageView()
                .opacity(activePage == .home ? 1 : 0)
                .disabled(activePage == .home ? false : true)
            ShoppingListView()
                .opacity(activePage == .shoppingList ? 1 : 0)
                .disabled(activePage == .shoppingList ? false : true)
            StoreMapView()
                .opacity(activePage == .map ? 1 : 0)
                .disabled(activePage == .map ? false : true)
        }
        
        VStack {
            if !keyboardActive {
                TabView(activePage: $activePage)
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                self.keyboardActive = true
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardActive = false
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}


#Preview {
    ContentView()
}
