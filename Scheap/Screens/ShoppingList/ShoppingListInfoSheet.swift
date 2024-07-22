//
//  ShoppingListInfoSheet.swift
//  Scheap
//
//  Created by Anda Levente on 22/07/2024.
//

import SwiftUI

struct ShoppingListInfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hogyan használjam a listát?")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Text("Írd be a megvásárolni kívánt árukat, sortöréssel (Return) elválasztva.")
                        .font(.title2)
                        .padding()
                }
                
                VStack (alignment: .leading){
                    Text(" tej\n tojás\n liszt")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .frame(width: 150)
                .background(Color.primaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10 ))
                .padding()
                
                VStack {
                    
                    Text("Ha bevitt minden elemet, a jobb alsó sarokban megjelenik egy jobbra mutató nyíl.")
                        .font(.title2)
                        .padding()
                    
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56)
                    
                    Text("Ennek segítségével továbbléphet, és az algoritmus összeállítja a lehetséges üzletláncokat, a teljes bevásárlás összegével.")
                        .font(.title2)
                        .padding()
                }
            }
            .navigationTitle("Infó")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button ("Mégsem") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    ShoppingListInfoSheet()
}
