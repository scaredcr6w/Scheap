//
//  ScheapApp.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI
import SwiftData

@main
struct ScheapApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ShoppingList.self,
            PreSplitList.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
