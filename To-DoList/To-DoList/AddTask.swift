//This file controls the add task screen
import UIKit

//This class is the entirety of the add task screen
class AddTask: UIViewController {
    //The reminder date that will be given from the date picker
    var rem_date: String!
    // the completion date that will be given from the date picker
    var com_date: String!
    
    //Initializes the date picker for the reminder
    @IBOutlet weak var Reminder_Date: UIDatePicker!
        //Gets information from the date picker and stores it in the rem_date variable
    @IBAction func hideReminderDate(_ sender: UIDatePicker) {
        // Allows the datepicker to get both time and date
        Reminder_Date.datePickerMode = UIDatePicker.Mode.dateAndTime
        //initializes the date formatter when returning a string
        let dateFormatter = DateFormatter()
        //Sets the date format to this format
        dateFormatter.dateFormat = "dd MMMM yyyy h:mm a"
        //Gets the reminder date from the date picker
        rem_date = String(dateFormatter.string(from: Reminder_Date.date))
        
    }
    
    //Initializes the toggle for the reminder date
    @IBOutlet weak var Reminder_Outlet: UISwitch!
    @IBAction func switch_Remider(_ sender: UISwitch) {
       //Checks the state of the switch
        if Reminder_Outlet.isOn == false {
            //Hides the reminder date picker
            Reminder_Date.isHidden = true;
            rem_date = nil
        }
        else {
            //Otherwise gets the data from the picker
            Reminder_Date.isHidden = false;
            //Initializes to the date data type
            let date = Date()
            //initializes ot the dateformatter data type
            let Form = DateFormatter()
            //Sets the format of the date
            Form.dateFormat = "dd MMMM yyyy h:mm a"
            //Gets the date
            let result = Form.string(from: date)
            //Sets the date
            rem_date = result;
            hideReminderDate(Reminder_Date)
        }
    }
    
    //Initializes hte completion date picker
    @IBOutlet weak var Completion_Date: UIDatePicker!
    //this function gets the date from the datepicker
    @IBAction func Date_Picker(_ sender: UIDatePicker) {
        //Only allows the completion date to be a day
        Completion_Date.datePickerMode = UIDatePicker.Mode.date
        //Initializes the date formatter
        let dateFormatter = DateFormatter()
        //Sets the format of the date
        dateFormatter.dateFormat = "dd MMMM yyyy"
        //retrieves the date
        com_date = String(dateFormatter.string(from: Completion_Date.date))

        
    }
    
    //Initializes the task name field
    @IBOutlet weak var taskName: UITextField!
    //Name of the task
    var name:String = ""
    //this is called when the scene is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initalizes the date pickers to be the current date
        Completion_Date.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        Reminder_Date.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        //Initializes the date type
        let date = Date()
        //initializes the dateformatter type and sets the format
        let Form = DateFormatter()
        Form.dateFormat = "dd MMMM yyyy"
        let result = Form.string(from: date)
        com_date = result
        //Toggles the reminder date
        Reminder_Outlet.isOn = false;
        Reminder_Date.isHidden = true;
        
    }
    
    //This function is called whenever the scene leaves and is going back to the table view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //checks if the segue is sending to the task list view page from the done button
        if segue.identifier == "doneSegue" {
            name = taskName.text!
            
        }
    }
    
   
}
