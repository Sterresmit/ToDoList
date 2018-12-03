//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Sterre Smit on 28/11/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit
class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var titleItem: UITextField!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesView: UITextView!

    @IBOutlet weak var saveButtonItem: UIBarButtonItem!
 
    override func viewDidLoad() {
    super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleItem.text = todo.title
            completedButton.isSelected = todo.completed
            datePicker.date = todo.dueDate
            notesView.text = todo.notes
        } else {
            datePicker.date = Date().addingTimeInterval(24*60*60)
        }
            updateSaveButtonState()
            updateDueDateLabel(date: datePicker.date)
            
        }
    
    var isPickerHidden = true

    func updateDueDateLabel(date: Date) {
    dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    var todo: ToDo?
    
    
    
    func updateSaveButtonState() {
    let text = titleItem.text ?? ""
    saveButtonItem.isEnabled = !text.isEmpty
    }
    
    @IBAction func textEditingChange(_ sender: Any) {
        updateSaveButtonState()
    }
    @IBAction func returnTapped(_ sender: Any) {
        titleItem.resignFirstResponder()
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        completedButton.isSelected = !completedButton.isSelected
    }
 
    @IBAction func datePickerEdited(_ sender: UIDatePicker) {
    updateDueDateLabel(date: datePicker.date)}
    
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [1,1]: //Due Date Cell
        return isPickerHidden ? normalCellHeight :
        largeCellHeight
        
        case [2,0]: //Notes Cell
        return largeCellHeight
        
        default: return normalCellHeight
    }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            isPickerHidden = !isPickerHidden
            
            dueDateLabel.textColor =
                isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
            
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    
        guard segue.identifier == "saveUnwind" else { return }
    
        let title = titleItem.text!
        let isComplete = completedButton.isSelected
        let dueDate = datePicker.date
        let notes = notesView.text
        
        
        todo = ToDo(title: title, dueDate:
            dueDate, completed: isComplete, notes: notes)
    }
    
}
