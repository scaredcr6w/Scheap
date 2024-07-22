//
//  ShoppingListView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @State private var isShowingKeyboard: Bool = false
    @State private var isShowingInfoSheet: Bool = false
    @FocusState private var focusTextEditor: Bool
    
    @State var userInputString: String = ""
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
            
            TextEditor(text: $viewModel.userList)
                .focused($focusTextEditor)
                .font(.system(size: 28))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            
            
            if !isShowingKeyboard && !viewModel.userList.isEmpty {
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
}
