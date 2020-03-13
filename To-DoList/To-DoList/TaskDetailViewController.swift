
import UIKit

class TaskDetailViewController: UIViewController {
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
