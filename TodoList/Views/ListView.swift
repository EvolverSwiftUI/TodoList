//
//  ListView.swift
//  TodoList
//
//  Created by Sivaram Yadav on 11/10/21.
//

import SwiftUI

/*
 
 
 List of tutorials
 
 0. Build Todo List in SwiftUI with MVVM architecture | Todo List #0
 1. Create a List of Todo items in SwiftUI | Todo List #1
 2. Create a custom data model for Todo items in SwiftUI | Todo List #2
 3. Add a ViewModel with @EnvironmentObject in SwiftUI | Todo List #3
 4. Save and persist data with UserDefaults | Todo List #4
 5. User Experience and Animations in SwiftUI app | Todo List #5
 6. Adapt SwiftUI app for iPad, Landscape, and Dark Mode | Todo List #6
 7. Adding an App Icon and Launch Screen to SwiftUI | Todo List #7

 */

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
        
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        RowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

struct RowView: View {
    let item: ItemModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title3)
        .padding(.vertical, 8)
    }
}

