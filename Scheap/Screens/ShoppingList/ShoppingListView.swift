//
//  ShoppingListView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @Binding var isShowingKeyboard: Bool
    @State private var isShowingInfoSheet: Bool = false
    @FocusState private var focusTextEditor: Bool
    
    @State private var didError: Bool = false
    @State private var errorMessage: String = ""
    
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
            
            TextEditor(text: $viewModel.userListInput)
                .focused($focusTextEditor)
                .font(.system(size: 28))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            
            
            if !isShowingKeyboard && !viewModel.userListInput.isEmpty {
                Button {
                    viewModel.handleUserInput() { error in
                        if let error {
                            self.errorMessage = error.localizedDescription
                            self.didError = true
                        }
                    }
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .padding(.bottom, 70)
                .alert("Hiba!",
                       isPresented: $didError,
                       actions: {
                    Button("OK", role: .cancel) { }
                },
                       message: {
                    Text(errorMessage)
                })
            }
            
        }
        .sheet(isPresented: $isShowingInfoSheet) {
            ShoppingListInfoSheet()
        }
    }
}

#Preview {
    ShoppingListView(isShowingKeyboard: .constant(false))
}
