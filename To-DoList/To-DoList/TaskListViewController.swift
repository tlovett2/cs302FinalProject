
import UIKit

struct aTask {
    init() {
        task = ""
        com_date = ""
        rem_date = ""
        completed = false
        com_percent = 0
        index = 0
    }
    var task: String
    var com_date: String
    var rem_date: String
    var completed: Bool
    var com_percent: Int
    var index: Int
}

class TaskListViewController: UITableViewController {
    var newTask: String = ""
    var index: Int = 0
    var tasks = [aTask]()
    var tk: ViewTask!
    var seg: UIStoryboardSegue?
    var tvc: Any?
    var visited = false
    
    
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
       
    }

    @IBAction func done(segue:UIStoryboardSegue) {
        
        if segue.identifier == "donewithView" {
            var t = aTask()
            let tsk = segue.source as! ViewTask
            index = tsk.index
            t.task = tsk.cur_task
            t.com_date = tsk.com_date
            t.rem_date = tsk.rem_date
            t.completed = tsk.completed
            t.com_percent = tsk.com_percent
            tasks[index] = t
            tableView.reloadData()
        }
        else {
            var t = aTask()
            let taskDetailVC = segue.source as! AddTask
            t.task = taskDetailVC.name
            t.com_date = taskDetailVC.com_date
            if taskDetailVC.rem_date != nil {
                t.rem_date = taskDetailVC.rem_date
            }
            t.completed = false
            t.com_percent = 0
            
            t.index = tasks.count
            
            tasks.append(t)
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        index = indexPath.row
        prepare(for: seg!, sender: tvc!)
        print(index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "view") {
            
            if visited == false {
                seg = segue
                tvc = sender
                visited = true
            }
            else {
                tk = segue.destination as! ViewTask
                tk.cur_task = tasks[index].task
                tk.com_date = tasks[index].com_date
                tk.rem_date = tasks[index].rem_date
                tk.completed = tasks[index].completed
                tk.com_percent = tasks[index].com_percent
                print(index)
                tk.index = index
                visited = false
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = []
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return tasks.count
    }

    @IBAction func Completion(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            sender.backgroundColor = UIColor.green
            
        }
        else {
            sender.backgroundColor = UIColor.red
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row].task
        
        return cell
    }
    

   
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            tasks.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData();
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
