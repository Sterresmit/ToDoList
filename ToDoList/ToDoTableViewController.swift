//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Sterre Smit on 28/11/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    // function definition when tapping check
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.completed = !todo.completed
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    var todos = [ToDo]()
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem
        super.viewDidLoad()
        
        // load to dos, when none found, load samples
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
    }
    // fill rows according to number of objects
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        cell.delegate = self
        // set cell with title and details according to data
        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.completedButton.isSelected = todo.completed
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // possibility of removing and saving after
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        }
        
    }
    
    // unwind to home segue function
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
        ToDoViewController
        
        // fill table with to do items
        if let todo = sourceViewController.todo {
            if let selectedIndexPAth = tableView.indexPathForSelectedRow {
                todos[selectedIndexPAth.row] = todo
                tableView.reloadRows(at: [selectedIndexPAth], with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count,
                                             section: 0)
                
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
    // show details like notes when cell is tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination
                as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
    
    
    
}


