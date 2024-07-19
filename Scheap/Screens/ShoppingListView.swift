//
//  ShoppingListView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var isShowingCreateSheet: Bool = false
    @State private var isShowingInfoSheet: Bool = false
    @State var input: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Bevásárlólista")
                    .bold()
                    .font(.system(size: 36))
                    .padding()
                
                Image(systemName: "info.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28)
                    .foregroundStyle(Color.gray)
                    .padding(.trailing, 40)
                    .onTapGesture {
                        isShowingInfoSheet.toggle()
                    }
                
                if !input.isEmpty {
                    Button {
                        //tovabb a splitre
                    } label: {
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28)
                    }
                }
            }
            
            TextEditor(text: $input)
                .font(.system(size: 28))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            
        }
    }
}

#Preview {
    ShoppingListView()
        .modelContainer(for: Product.self, inMemory: true)
}
