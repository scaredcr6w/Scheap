//
//  ShoppingListView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var preSplitList: [PreSplitList]
    
    @Binding var isShowingKeyboard: Bool
    @FocusState private var focusTextEditor: Bool
    @State private var isShowingInfoSheet: Bool = false
    @State private var isShowingComparisonPage: Bool = false
    @State private var isLoading: Bool = false
    
    @State private var didError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            if !isShowingComparisonPage {
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
                                doneButtonAction()
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
                                
                                Task {
                                    do {
                                        withAnimation(.easeInOut) {
                                            isLoading.toggle()
                                        }
                                        viewModel.cheapestLists.append(
                                            try await viewModel.createCheapestList(from: "aldi")
                                        )
                                        viewModel.cheapestLists.append(
                                            try await viewModel.createCheapestList(from: "spar")
                                        )
                                        
                                        viewModel.cheapestLists.append(
                                            try await viewModel.createCheapestList(from: "tesco")
                                        )
                                        
                                        withAnimation(.bouncy) {
                                            isLoading.toggle()
                                            isShowingComparisonPage.toggle()
                                        }
                                    } catch {
                                        self.didError = true
                                        self.errorMessage = error.localizedDescription
                                    }
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
                .overlay {
                    if isLoading {
                        LoadingView("Listák összeállítása")
                    }
                }
            } else {
                ComparisonPageView(
                    isShowingComparisonPage: $isShowingComparisonPage,
                    shoppingListsTemp: viewModel.cheapestLists
                )
            }
        }
        .onAppear {
            viewModel.userListInput = preSplitList.first?.preSplitList ?? ""
        }
        
    }
    
    private func doneButtonAction() {
        focusTextEditor = false
        
        do {
            try modelContext.delete(model: PreSplitList.self)
        } catch {
            print("ModelContext törlése sikertelen")
        }
        
        modelContext.insert(
            PreSplitList(
                preSplitList: viewModel.userListInput
            )
        )
    }
}

#Preview {
    ShoppingListView(isShowingKeyboard: .constant(false))
        .modelContainer(for: PreSplitList.self, inMemory: true)
}
