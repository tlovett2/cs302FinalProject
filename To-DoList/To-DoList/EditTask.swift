//
//  EditTask.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/5/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//
import UIKit

class EditTask: UIViewController {

    
    @IBOutlet weak var Reminder_Date2: UIDatePicker!
        
    @IBAction func hideReminderDate2(_ sender: UIDatePicker) {
        
    }
    
    @IBOutlet weak var Reminder_Outlet2: UISwitch!
    
    @IBAction func switch_Remider2(_ sender: UISwitch) {
       
        if Reminder_Outlet2.isOn {
            Reminder_Date2.isHidden = false;
        }
        else {
            Reminder_Date2.isHidden = true;
        }
    }
    
    @IBOutlet weak var Completion_Date2: UIDatePicker!
    @IBAction func Date_Picker2(_ sender: UIDatePicker) {
        
        
    }
    
    @IBOutlet weak var taskName2: UITextField!
    
    var name:String = ""
    
    override func viewDidLoad() {
           super.viewDidLoad()
    }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           print("Hey")
           if segue.identifier == "doneSegue" {
               print(taskName2.text!)
               print("Boss")
               name = taskName2.text!
           }
       }
}
