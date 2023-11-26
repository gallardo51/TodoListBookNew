//
//  Item.swift
//  Todo List
//
//  Created by Александр Соболев on 26.11.2023.
//

import Foundation

struct Item: Identifiable, Codable {
    let id = UUID()
    var todo: String
}
