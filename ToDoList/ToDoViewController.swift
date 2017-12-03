//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Sean Kearney on 30/11/2017.
//  Copyright © 2017 Sean Kearney. All rights reserved.
//

import UIKit



class ToDoViewController: UITableViewController {
    
    var todo: ToDo?
    
    var isPickerHidden = true
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    func updateSaveButtonState(){
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo{
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else{
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    func updateDueDateLabel(date: Date){
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    //Saving data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete,dueDate: dueDate, notes: notes)
    }
    

    //show/hide date picker on tap
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath){
        case[1,0]: //due date cell
            return isPickerHidden ? normalCellHeight : largeCellHeight
            
        case[2,0]: //notes cell
            return largeCellHeight
            
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath){
        case[1,0]:
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }
    
}
