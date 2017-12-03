//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Sean Kearney on 24/11/2017.
//  Copyright © 2017 Sean Kearney. All rights reserved.
//

import Foundation
import UIKit

class ToDoTableViewController: UITableViewController{
    var todos = [ToDo]()
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at:[indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") else {
            fatalError("Could not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as!
        ToDoViewController
        
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
            tableView.reloadRows(at: [selectedIndexPath],with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at:[newIndexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetails"{
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
}


