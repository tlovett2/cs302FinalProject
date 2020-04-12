
import UIKit

struct aTask {
    init() {
        task = ""
        com_date = ""
        rem_date = ""
    }
    var task: String
    var com_date: String
    var rem_date: String
}

class TaskListViewController: UITableViewController {
    var newTask: String = ""
    var index: Int = 0
    var tasks = [aTask]()
    var tk: ViewTask!
    
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
       
    }

    @IBAction func done(segue:UIStoryboardSegue) {
        var t = aTask()
        let taskDetailVC = segue.source as! AddTask
        t.task = taskDetailVC.name
        t.com_date = taskDetailVC.com_date
        if taskDetailVC.rem_date != nil {
            t.rem_date = taskDetailVC.rem_date
        }
        
        tasks.append(t)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        index = indexPath.row;
        
        tk.cur_task = tasks[index].task
        tk.com_date = tasks[index].com_date
        tk.rem_date = tasks[index].rem_date
        print("index: \(index)\ntk: \(tk.cur_task)\n")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Viewer") {
            tk = segue.destination as! ViewTask
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
