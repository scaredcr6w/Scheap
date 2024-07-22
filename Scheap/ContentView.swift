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
        VStack {
            switch activePage {
            case .home:
                HomepageView()
            case .shoppingList:
                ShoppingListView()
            case .map:
                StoreMapView()
            }
            Spacer()
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
