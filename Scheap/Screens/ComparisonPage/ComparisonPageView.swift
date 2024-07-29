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
        List {
            ForEach(shoppingLists) { shoppingList in
                DisclosureGroup(shoppingList.store ?? "Ismeretlen bolt") {
                    ForEach(shoppingList.shoppingList) { product in
                        HStack {
                            Text(product.name)
                            Spacer()
                            Text("\(product.price)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ComparisonPageView(shoppingLists: [ShoppingList(store: "ALDI", shoppingList: [Product(brand: "Marka", name: "Cucc", category: "beverage", price: 200, image: nil)])])
}
