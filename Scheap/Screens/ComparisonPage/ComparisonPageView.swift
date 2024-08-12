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
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) private var modelContext
    @Query var shoppingLists: [ShoppingList] = []
    @State private var isShowingInfoSheet = false
    
    
    @State private var selectedStore: Stores = .aldi
    var shoppingListsTemp: [ShoppingList]
    
    var filteredShoppingList: [Product] {
        shoppingLists.first { $0.store == selectedStore.storename }?.shoppingList ?? []
    }
    
    var selectedShoppingSum: Int {
        filteredShoppingList.reduce(0, { $0 + $1.price })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Bevásárlólisták")
                    .bold()
                    .font(.system(size: 36))
                    .padding()
                
                Image(systemName: "info.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28)
                    .foregroundStyle(Color.gray)
                    .padding(.trailing)
                    .onTapGesture {
                        isShowingInfoSheet.toggle()
                    }
            }
            
            Picker("Boltok", selection: $selectedStore) {
                ForEach(Stores.allCases) { store in
                    Text(store.storename.capitalized).tag(store)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
                        
            List {
                ForEach(filteredShoppingList) { product in
                    Section {
                        ListCardView(productName: product.name,
                                     price: "\(product.price) Ft",
                                     productImage: product.image)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(shoppingLists[index])
                    }
                }
            }
            .scrollContentBackground(colorScheme == .dark ? .hidden : .visible)
            .sheet(isPresented: $isShowingInfoSheet) {
                ShoppingListInfoSheet()
            }
            
            Text("\(selectedShoppingSum) Ft")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom, 90)
        }
        .onAppear {
            do {
                try modelContext.delete(model: ShoppingList.self)
            } catch {
                print("ModelContext törlése sikertelen compView")
            }
            shoppingListsTemp.forEach { list in
                modelContext.insert(list)
            }
        }
    }
}

struct ListCardView: View {
    let productName: String
    let price: String
    let productImage: Data?
    
    var body: some View {
        HStack {
            if let productImage,
               let uiImage = UIImage(data: productImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
            } else {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .foregroundStyle(Color.gray)
            }
            
            VStack (alignment: .leading) {
                Text(productName)
                    .bold()
                    .font(.system(size: 18))
                Text(price)
                
            }
            .padding(.trailing)
        }
        .frame(width: 340, height: 80, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(Rectangle())
    }
}

#Preview {
    ComparisonPageView(shoppingListsTemp: [
        ShoppingList(store: "aldi",
                     shoppingList: [Product(name: "Cucc", price: 200, image: nil)]
                    )
    ])
    .modelContainer(for: [ShoppingList.self], inMemory: true)
}
