//
//  ComparisonPageView.swift
//  Scheap
//
//  Created by Anda Levente on 29/07/2024.
//

import SwiftUI
import SwiftData

struct ComparisonPageView: View {
    var shoppingLists: [ShoppingList]
    
    var body: some View {
        Text("Tabs on the top")
    }
}

#Preview {
    ComparisonPageView(shoppingLists: [ShoppingList(store: "ALDI", shoppingList: [Product(brand: "Marka", name: "Cucc", category: "beverage", price: 200, image: nil)])])
}
