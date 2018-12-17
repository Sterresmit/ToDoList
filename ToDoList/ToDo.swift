//
//  ToDo.swift
//  ToDoList
//
//  Created by Sterre Smit on 28/11/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import Foundation
// To do item struct
struct ToDo: Codable {
    var title: String
    var dueDate: Date
    var completed: Bool
    var notes: String?
    
    //     get To Do items from archive
    static func loadToDos() -> [ToDo]?  {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL)
            else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
                                               from: codedToDos)
    }
    // save new added to do items
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL,
                               options: .noFileProtection)
    }
    
    // get to do samples
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", dueDate: Date(),completed: false, notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", dueDate: Date(), completed: false, notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", dueDate: Date(), completed: false, notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
    // due date formatter constant
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    // source
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // url declaration url's
    static let ArchiveURL =
        DocumentsDirectory.appendingPathComponent("todos")
            .appendingPathExtension("plist")
    
}
