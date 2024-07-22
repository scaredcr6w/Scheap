//
//  ShoppingListView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var isShowingKeyboard: Bool = false
    @State private var isShowingInfoSheet: Bool = false
    @FocusState private var focusTextEditor: Bool
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
                    .padding(.trailing)
                    .onTapGesture {
                        isShowingInfoSheet.toggle()
                    }
                
                if isShowingKeyboard {
                    Button("Kész") {
                        focusTextEditor = false
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                }
            }
            
            TextEditor(text: $input)
                .focused($focusTextEditor)
                .font(.system(size: 28))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            
            
            if !input.isEmpty {
                Button {
                    //tovabb a splitre
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            
        }
        .sheet(isPresented: $isShowingInfoSheet) {
            ShoppingListInfoSheet()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                self.isShowingKeyboard = true
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.isShowingKeyboard = false
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}

#Preview {
    ShoppingListView()
        .modelContainer(for: Product.self, inMemory: true)
}
