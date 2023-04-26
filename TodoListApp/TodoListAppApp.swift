//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Andrii Hlybchenko on 26.04.2023.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
