
import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var taskName: UITextField!
    
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneWithSegue:" {
            name = taskName.text!
        }
    }
    

   
}
