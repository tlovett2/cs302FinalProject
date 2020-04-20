
import UIKit

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}


struct aTask {
    init() {
        task = ""
        com_date = ""
        rem_date = ""
        completed = false
        com_percent = 0
        index = 0
        hidden = false
        seg = 0
        prevseg = 0
    }
    var task: String
    var com_date: String
    var rem_date: String
    var completed: Bool
    var com_percent: Int
    var index: Int
    
    var hidden: Bool
    var seg: Int
    var prevseg: Int
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
    var new_seg: String?
    
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
            
            if tsk.completed {
                t.seg = 1
                print("jobe")
                t.prevseg = tsk.prevseg
            }
            else if tsk.completed == false && tsk.segment != 1 {
                t.seg = tsk.segment
                print("mack")
                print(tsk.prevseg)
                if tsk.segment != tsk.prevseg {
                    t.prevseg = tsk.segment
                }
                
                print(tsk.prevseg)
                print("\n")
            }
            else {
                print("jimmy")
                t.seg = tsk.prevseg
                t.prevseg = tsk.prevseg
                print(tsk.prevseg)
                print("\n")
            }
            
            if tsk.cur_segment == t.seg {
                t.hidden = false
            }
            else {
                t.hidden = true
            }
            
            
            
            tasks[index] = t
            print(tasks[index].com_percent)
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
            
            t.hidden = false
            t.seg = Files.selectedSegmentIndex
            t.prevseg = Files.selectedSegmentIndex
            print("prevseg:")
            print(t.prevseg)
            
            
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
                tk = segue.destination as? ViewTask
                tk.cur_task = tasks[index].task
                tk.com_date = tasks[index].com_date
                tk.rem_date = tasks[index].rem_date
                tk.completed = tasks[index].completed
                tk.com_percent = tasks[index].com_percent
                print(index)
                tk.index = index
                visited = false
                
                tk.hidden = tasks[index].hidden
                tk.segment = tasks[index].seg
                
                tk.prevseg = tasks[index].prevseg
                print("prevseg in prep: \(tk.prevseg)")
                tk.cur_segment = selectedFile
                
                for i in Files.numberOfSegments {
                    tk.seg_sections.append(Files.titleForSegment(at: i)!)
                }
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Files.sizeToFit()
        
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
        
        
        tasks[indexPath.row].cell = cell
        TBV = tableView
        
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
            
        self.check_delete(self, index: indexPath)
        
      })

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
    
    @IBAction func check_delete(_ sender: Any, index: IndexPath) {
        if tasks[index.row].completed {
            let alert = UIAlertController(title: "Do you want to remove the task?", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                self.tasks[index.row].seg = 1
                self.tasks[index.row].hidden = true
                self.change_Tab(self)
            }))
            
            self.present(alert, animated: true)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                print("\(self.tasks[index.row].task) has been deleted")
                
                self.tasks.remove(at: index.row)
                self.TBV.cellForRow(at: index)?.backgroundColor = UIColor(named: "customControlColor")
                self.TBV.deleteRows(at: [index], with: .fade)
                
            }))
        }
        else {
            self.tasks[index.row].seg = self.tasks[index.row].prevseg
            self.tasks[index.row].hidden = true
            self.change_Tab(self)
            print("prevseg:")
            print(self.tasks[index.row].prevseg)
        }
    }
    
    
    
    
    @IBOutlet weak var alt: UIAlertController!
    
    @IBAction func alert (_ sender: Any) {
        let alert = UIAlertController(title: "Name New Section", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input section here..."
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = alert.textFields?.first?.text {
                print("Added section: \(name)")
                self.addSection(self, seg: name)
            }
        }))

        self.present(alert, animated: true)
        
    }
    
    @IBAction func addSection(_ sender: Any, seg: String) {
        Files.insertSegment(withTitle: seg, at: Files.numberOfSegments, animated: true)
        print(seg)
        
    }
    
    
    
}
