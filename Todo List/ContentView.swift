//
//  ContentView.swift
//  Todo List
//
//  Created by Александр Соболев on 26.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentTodo = ""
    @State private var todos: [Item] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New todo...", text: $currentTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        guard !self.currentTodo.isEmpty else { return }
                        self.todos.append(Item(todo: self.currentTodo))
                        self.currentTodo = ""
                        self.save()
                    }) {
                        Image(systemName: "text.badge.plus")
                    }
                    .padding(.leading, 5)
                } .padding()
            }
            
            List {
                ForEach(todos) { todoEntry in
                    Text(todoEntry.todo)
                } .onDelete(perform: delete)
            }
        .navigationTitle("Todo List")
        } .onAppear(perform:
            load)
}
    
    private func save() {
        UserDefaults.standard.set (
            try? PropertyListEncoder().encode(self.todos), forKey: "myTodosKey")
    }
    
    private func load() {
        if let todosData = UserDefaults.standard.value(forKey: "myTodosKey") as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<Item>.self, from: todosData) {
                self.todos = todosList
            }
        }
    }
    
    private func delete(at offset: IndexSet) {
        self.todos.remove(atOffsets: offset)
        save()
    }
}


#Preview {
    ContentView()
}
