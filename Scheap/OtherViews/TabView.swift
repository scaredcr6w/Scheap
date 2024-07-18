//
//  TabView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI

struct TabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        HStack {
            VStack {
                Image(systemName: "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 50)
            }
            .padding()
            
            VStack {
                Image(systemName: "list.bullet.rectangle.portrait")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 50)
            }
            .padding()
            
            VStack {
                Image(systemName: "map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 50)
            }
            .padding()
            
        }
        .frame(width: 320, height: 80)
        .background(Color.primaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TabView()
}
