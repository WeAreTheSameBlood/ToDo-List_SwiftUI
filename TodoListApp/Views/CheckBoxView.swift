//
//  CheckBoxView.swift
//  TodoListApp
//
//  Created by Andrii Hlybchenko on 28.04.2023.
//

import SwiftUI

struct CheckBoxView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        Image(systemName: passedTaskItem.isCompleted()
              ? "checkmark.circle.fill"
              : "circle")
        .foregroundColor(passedTaskItem.isCompleted()
                         ? .green
                         : .secondary)
        .onTapGesture {
            withAnimation {
                passedTaskItem.completedDate = passedTaskItem.isCompleted() ? nil : Date()
                passedTaskItem.counter = passedTaskItem.isCompleted() ? +100 : -100
                dateHolder.saveContext(viewContext)
            }
        }
    }
}

//struct CheckBoxView_Previews: PreviewProvider {
//    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var dateHolder: DateHolder
//    @ObservedObject var passedTaskItem: TaskItem
//    static var previews: some View {
//        CheckBoxView(passedTaskItem: TaskItem())
//    }
//}
