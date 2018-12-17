//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Sterre Smit on 28/11/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit
class ToDoViewController: UITableViewController {
    
    // Outlets for objects
    @IBOutlet weak var titleItem: UITextField!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesView: UITextView!
    
    @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            // set navigation details
            navigationItem.title = "To-Do"
            titleItem.text = todo.title
            // Checked or not
            completedButton.isSelected = todo.completed
            // set according to date and details
            datePicker.date = todo.dueDate
            notesView.text = todo.notes
        } else {
            // begin date at day from current date
            datePicker.date = Date().addingTimeInterval(24*60*60)
        }
        updateSaveButtonState()
        updateDueDateLabel(date: datePicker.date)
        
    }
    
    var isPickerHidden = true
    
    // changing label with data corresponding to picker
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    var todo: ToDo?
    
    // save button disabled until text is changed
    func updateSaveButtonState() {
        let text = titleItem.text ?? ""
        saveButtonItem.isEnabled = !text.isEmpty
    }
    // save button enabled when text changed
    @IBAction func textEditingChange(_ sender: Any) {
        updateSaveButtonState()
    }
    // back to list
    @IBAction func returnTapped(_ sender: Any) {
        titleItem.resignFirstResponder()
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        completedButton.isSelected = !completedButton.isSelected
    }
    
    // outlet due date picker combinated with changing label
    @IBAction func datePickerEdited(_ sender: UIDatePicker) {
        updateDueDateLabel(date: datePicker.date)}
    
    // set height for different cell types
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
    // fit table when date picker is not selected
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
    
    // prepare for segue setting correct title and details according to filled in data
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
