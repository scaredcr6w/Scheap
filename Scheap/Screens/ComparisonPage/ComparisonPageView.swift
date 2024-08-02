//
//  ComparisonPageView.swift
//  Scheap
//
//  Created by Anda Levente on 29/07/2024.
//

import SwiftUI
import SwiftData

enum Stores: String, CaseIterable, Identifiable {
    case aldi, spar, tesco
    
    var id: String { self.rawValue }
    
    var storename: String {
        switch self {
        case .aldi:
            return "aldi"
        case .spar:
            return "spar"
        case .tesco:
            return "tesco"
        }
    }
}

struct ComparisonPageView: View {
    @State private var selectedStore: Stores = .aldi
    var shoppingLists: [ShoppingList]
    
    var filteredShoppingList: [Product] {
        shoppingLists.first { $0.store == selectedStore.storename }?.shoppingList ?? []
    }
    
    var body: some View {
        VStack {
            Picker("Boltok", selection: $selectedStore) {
                ForEach(Stores.allCases) { store in
                    Text(store.storename.capitalized).tag(store)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List(filteredShoppingList) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("\(product.price)")
                }
            }
        }
    }
}

#Preview {
    ComparisonPageView(shoppingLists: [ShoppingList(store: "aldi", shoppingList: [Product(name: "Cucc", price: 200, image: nil)])])
}
