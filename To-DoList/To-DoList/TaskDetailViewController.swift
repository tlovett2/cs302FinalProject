
import UIKit

class TaskDetailViewController: UIViewController {
   
    @IBOutlet weak var Reminder_Date: UIDatePicker!
        
    @IBAction func hideReminderDate(_ sender: UIDatePicker) {
        
    }
    
    
    @IBOutlet weak var Reminder_Outlet: UISwitch!
    @IBAction func switch_Remider(_ sender: UISwitch) {
       
        if Reminder_Outlet.isOn {
            Reminder_Date.isHidden = false;
        }
        else {
            Reminder_Date.isHidden = true;
        }
    }
    
    @IBOutlet weak var Completion_Date: UIDatePicker!
    @IBAction func Date_Picker(_ sender: UIDatePicker) {
        
        
    }
    
    @IBOutlet weak var taskName: UITextField!
    
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Hey")
        if segue.identifier == "doneSegue" {
            print(taskName.text!)
            print("Boss")
            name = taskName.text!
        }
    }
    
   
}
