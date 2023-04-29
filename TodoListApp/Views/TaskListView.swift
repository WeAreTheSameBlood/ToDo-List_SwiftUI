//
//  ContentView.swift
//  TodoListApp
//
//  Created by Andrii Hlybchenko on 26.04.2023.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.counter, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>

    var body: some View
    {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items) { taskItem in
                            NavigationLink (destination: TaskEditView(passedTaskItem: taskItem, initialDate: Date())
                                .environmentObject(dateHolder)) {
                                TaskCell(passedTaskItem: taskItem)
                                        .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                        .onMove(perform: move)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    FloatingButton()
                        .position(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.75)
                        .environmentObject(dateHolder)
                }
            }.navigationTitle("To Do List")
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        
        let itemForMove = source.first!
        
        if itemForMove < destination {
            var startIndex = itemForMove+1
            var startOrder = items[itemForMove].counter
            
            while startIndex <= destination-1 {
                items[startIndex].counter = startOrder
                startOrder += 1
                startIndex += 1
            }
            items[itemForMove].counter = startOrder
            
        } else if destination < itemForMove {
            var startIndex = destination
            var startOrder = items[destination].counter+1
            let newOrder = items[destination].counter
            
            while startIndex <= itemForMove-1 {
                items[startIndex].counter = startOrder
                startOrder += 1
                startIndex += 1
            }
            items[itemForMove].counter = newOrder
        }
            
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        withAnimation {
            dateHolder.saveContext(viewContext)
        }
    }

    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
