
import UIKit

struct aTask {
    init() {
        task = ""
        com_date = ""
        rem_date = ""
        completed = false
        com_percent = 0
        index = 0
    
        //new
        hidden = false
        seg = 0
    }
    var task: String
    var com_date: String
    var rem_date: String
    var completed: Bool
    var com_percent: Int
    var index: Int
    
    //new
    var hidden: Bool
    var seg: Int
    var cell: UITableViewCell?
}

class TaskListViewController: UITableViewController {
    var newTask: String = ""
    var index: Int = 0
    var tasks = [aTask]()
    var tk: ViewTask!
    var seg: UIStoryboardSegue?
    var tvc: Any?
    var visited = false
    var ixdp = IndexPath()
    
    var selectedFile = 0
    var TBV = UITableView()
    
    //New Stuff with segment
    
    @IBOutlet weak var Files: UISegmentedControl!
    @IBAction func change_Tab(_ sender: Any) {
        var i = 0
        
        selectedFile = Files.selectedSegmentIndex
        
        while i < tasks.count {
            if tasks[i].seg == selectedFile {
                tasks[i].hidden = false
                tasks[i].cell?.isHidden = false
            }
            else {
                tasks[i].hidden = true
                tasks[i].cell?.isHidden = true
            }
            i += 1
        }
        TBV.reloadData()
        
    }
    
    //--------------
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0;
        if (tasks[indexPath.row].hidden) {
            height = 0.0;
        } else {
            height = 44.0;
        }
        return height;
    }
    
    
    
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
            
            //new-------
            t.seg = tsk.segment
            t.hidden = tsk.hidden
            print("hidden at \(index):")
            print(t.hidden)
            print("segment at \(index):")
            print(t.seg)
            //------
            
            tasks[index] = t
            
            tableView.cellForRow(at: ixdp)?.backgroundColor = (self.tasks[ixdp.row].completed) ? UIColor.systemGreen : UIColor(named: "customControlColor")
            
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
            
            //new------
            
            t.hidden = false
            t.seg = selectedFile
            print(t.hidden)
            print(t.seg)
            
            //------------
            tasks.append(t)
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        index = indexPath.row
        ixdp = indexPath
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
                
                //new-----
                tk.hidden = tasks[index].hidden
                tk.segment = tasks[index].seg
                //--------
                
                
            }
        }
        else {
            if tasks.count == 15 {
                print("Get to working on finishing some of your current tasks.\n")
                
                //maybe put a pop up
                //uialert
            
            
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row].task
        
        //new----
        tasks[indexPath.row].cell = cell
        TBV = tableView
        //-----
        return cell
    }
    

   
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView,
      leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      ->   UISwipeActionsConfiguration? {

      // Get current state from data source
        let favorite = tasks[indexPath.row].completed

      let title = favorite ?
        NSLocalizedString("Mark Imcomplete", comment: "Mark Imcomplete") :
        NSLocalizedString("Mark Complete", comment: "Mark Complete")

      let action = UIContextualAction(style: .normal, title: title,
        handler: { (action, view, completionHandler) in
        // Update data source when user taps action
        self.tasks[indexPath.row].completed = !favorite
        completionHandler(true)
        
          if(self.tasks[indexPath.row].completed) {
            self.tasks[indexPath.row].com_percent = 100
          }
          else {
            self.tasks[indexPath.row].com_percent = 0
          }
            
        self.ixdp = indexPath
            
        tableView.cellForRow(at: indexPath)?.backgroundColor = (self.tasks[indexPath.row].completed) ? UIColor.systemGreen : UIColor(named: "customControlColor")
        
      })

      action.image = UIImage(named: "heart")
      action.backgroundColor = favorite ? .red : .green
      let configuration = UISwipeActionsConfiguration(actions: [action])

        
      return configuration
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            tasks.remove(at: indexPath.row)
            
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(named: "customControlColor")
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
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

}
