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
            
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
