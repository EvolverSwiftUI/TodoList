//
//  ItemModel.swift
//  TodoList
//
//  Created by Sivaram Yadav on 11/10/21.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    // props
    let id: String
    let title: String
    let isCompleted: Bool

    
    // Initializer
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
