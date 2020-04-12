
import UIKit

class AddTask: UIViewController {
    var rem_date: String!
    var com_date: String!
    
    
    @IBOutlet weak var Reminder_Date: UIDatePicker!
        
    @IBAction func hideReminderDate(_ sender: UIDatePicker) {
        Reminder_Date.datePickerMode = UIDatePicker.Mode.dateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy h:mm a"
        rem_date = String(dateFormatter.string(from: Reminder_Date.date))
        print(rem_date!)
        
    }
    
    
    @IBOutlet weak var Reminder_Outlet: UISwitch!
    @IBAction func switch_Remider(_ sender: UISwitch) {
       
        if Reminder_Outlet.isOn == false {
            Reminder_Date.isHidden = true;
            rem_date = nil
        }
        else {
            Reminder_Date.isHidden = false;
            let date = Date()
            let Form = DateFormatter()
            Form.dateFormat = "dd MMMM yyyy"
            let result = Form.string(from: date)
            rem_date = result;
        }
    }
    
    @IBOutlet weak var Completion_Date: UIDatePicker!
    @IBAction func Date_Picker(_ sender: UIDatePicker) {
        
        Completion_Date.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        com_date = String(dateFormatter.string(from: Completion_Date.date))

        print(com_date!)
        
    }
    
    @IBOutlet weak var taskName: UITextField!
    
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Completion_Date.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        Reminder_Date.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let date = Date()
        let Form = DateFormatter()
        Form.dateFormat = "dd MMMM yyyy"
        let result = Form.string(from: date)
        com_date = result
        Reminder_Outlet.isOn = false;
        Reminder_Date.isHidden = true;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            print(taskName.text!)
            name = taskName.text!
            
        }
    }
    
   
}
