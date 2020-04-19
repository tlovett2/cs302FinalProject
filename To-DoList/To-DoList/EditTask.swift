//
//  EditTask.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/5/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//
import UIKit


//if date is changed it will be newcomDate


class EditTask: UIViewController {
    var rem_date = ""
    var task = ""
    var newcomDate = ""
    var newTask = ""
    
    
    
    @IBOutlet weak var Reminder_Date2: UIDatePicker!
        
    @IBAction func hideReminderDate2(_ sender: UIDatePicker) {
        Reminder_Date2.datePickerMode = UIDatePicker.Mode.dateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy h:mm a"
        rem_date = String(dateFormatter.string(from: Reminder_Date2.date))
        print(rem_date)
    }
    
    @IBOutlet weak var Reminder_Outlet2: UISwitch!
    
    @IBAction func switch_Remider2(_ sender: UISwitch) {
       
        if Reminder_Outlet2.isOn {
            Reminder_Date2.isHidden = false;
            hideReminderDate2(Reminder_Date2)
        }
        else {
            Reminder_Date2.isHidden = true;
        }
    }
    
    @IBOutlet weak var Completion_Date2: UIDatePicker!
    @IBAction func Date_Picker2(_ sender: UIDatePicker) {
        
        Completion_Date2.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        newcomDate = String(dateFormatter.string(from: Completion_Date2.date))

        print(newcomDate)
    }
    
    @IBOutlet weak var taskName2: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneEdit" {
            print(taskName2.text!)
            newTask = taskName2.text!
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskName2.text = task
        
        Completion_Date2.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        Reminder_Date2.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        
        let Form = DateFormatter()
        Form.dateFormat =  "dd MMMM yyyy"
        var date = Form.date(from: newcomDate)
        Completion_Date2.setDate(date!, animated: true)
        
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
    
}
