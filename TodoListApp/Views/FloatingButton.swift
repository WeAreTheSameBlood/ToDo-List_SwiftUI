//
//  FloatingButton.swift
//  TodoListApp
//
//  Created by Andrii Hlybchenko on 26.04.2023.
//

import SwiftUI

struct FloatingButton: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        HStack {
            NavigationLink(destination: TaskEditView(passedTaskItem: nil, initialDate: Date())
                .environmentObject(dateHolder)) {
                Text("+ New Task")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3)
        }
    }
}

//struct FloatingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingButton()
//    }
//}
