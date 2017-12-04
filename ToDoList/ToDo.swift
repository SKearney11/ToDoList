//
//  ToDo.swift
//  ToDoList
//
//  Created by Sean Kearney on 24/11/2017.
//  Copyright © 2017 Sean Kearney. All rights reserved.
//

import Foundation


struct ToDo: Codable{
    //set up location to store data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("todos") .appendingPathExtension("plist")
    
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    //load todos from disk
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveUrl)
            else{return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    //save todos to disk
    static func saveToDos(_ todos: [ToDo]){
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveUrl, options: .noFileProtection)
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func loadSampleToDos() -> [ToDo]{
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return[todo1,todo2,todo3]
    }
}
