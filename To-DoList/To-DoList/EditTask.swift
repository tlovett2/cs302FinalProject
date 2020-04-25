//
//  EditTask.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/5/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//
import UIKit


//if date is changed it will be newcomDate


//This class is the entirety of the edit task page
class EditTask: UIViewController, UITextFieldDelegate {
    //Reminder date
    var rem_date = ""
    //Task name
    var task = ""
    //New completion date
    var newcomDate = ""
    //New task name
    var newTask = ""
    
    
    
    @IBOutlet weak var Reminder_Date2: UIDatePicker!
        //Allows to read from the reminder date picker
    @IBAction func hideReminderDate2(_ sender: UIDatePicker) {
        //Allow the datepicker to get both time and date
        Reminder_Date2.datePickerMode = UIDatePicker.Mode.dateAndTime
        //Initializes and sets the date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy h:mm a"
        //Gets the reminder date from the date picker
        rem_date = String(dateFormatter.string(from: Reminder_Date2.date))
    }
    
    @IBOutlet weak var Reminder_Outlet2: UISwitch!
    //Allows us to toggle the reminder date picker in case the user does not want to be reminded
    @IBAction func switch_Remider2(_ sender: UISwitch) {
       
        //Unhifes the date picker and gets the date
        if Reminder_Outlet2.isOn {
            Reminder_Date2.isHidden = false;
            hideReminderDate2(Reminder_Date2)
        }
        else {
            //Hides the date
            Reminder_Date2.isHidden = true;
        }
    }
    
    //Initializes the completion date picker
    @IBOutlet weak var Completion_Date2: UIDatePicker!
    @IBAction func Date_Picker2(_ sender: UIDatePicker) {
        //Allows the date picker to get both time and date
        Completion_Date2.datePickerMode = UIDatePicker.Mode.date
        //Initializes the date formatter and sets the string format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        //gets the date from the date picker
        newcomDate = String(dateFormatter.string(from: Completion_Date2.date))

    }
    
    // Initializes the task name field
    @IBOutlet weak var taskName2: UITextField!
    //prepares to send all of the date back
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //checks if the done button was clicked
        if segue.identifier == "doneEdit" {
            //Sets the new task name
            newTask = taskName2.text!
        }
        
    }
    
    //This is called when the scene is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the text in the text field to the name of the task
        taskName2.text = task
        
        //Makes sure that the date is greater than the current date
        Completion_Date2.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        Reminder_Date2.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        
        //Initializes and sets the date format
        let Form = DateFormatter()
        Form.dateFormat =  "dd MMMM yyyy"
        
        //sets the date on the completion date picker
        var date = Form.date(from: newcomDate)
        Completion_Date2.setDate(date!, animated: true)
        
        //Checks if the reminder date exists and unhides the date picker
        if(rem_date != "") {
            Reminder_Date2.isHidden = false
            Reminder_Outlet2.isOn = true;
            Form.dateFormat = "dd MMMM yyyy h:mm a"
            date = Form.date(from: rem_date)
            Reminder_Date2.setDate(date!, animated: true)
        }
        else {
            Reminder_Date2.isHidden = true
            Reminder_Outlet2.isOn = false
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        taskName2.delegate = self
        taskName2.returnKeyType = .done
        
        
        self.view.addSubview(taskName2)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        taskName2.resignFirstResponder()
        
        return true
    }
    
}
