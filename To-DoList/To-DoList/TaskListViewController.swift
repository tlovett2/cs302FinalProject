
import UIKit


//This is an extension to the built in swift class that allows us to use it in a for..in loop
//All it does is return an iterator for the loop to iterate over
extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}

//------- Struct for saving data --------
struct save_task : Codable {
    var task = ""
    var com_date = ""
    var rem_date = ""
    var completed = false
    var com_percent = 0
    var index = 0
    var hidden = false
    var seg = 0
    var prevseg = 0
}


//This is our main task class for this screen view
struct aTask {
    //Our contructor sets all of the values to a default value
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
    //This is the name of the task
    var task: String
    //This is the completion date, using the ISO date format provided by the date picker
    var com_date: String
    //This is the reminder date, using the ISO date format provided by the date picker
    var rem_date: String
    //This is the boolean determining whether or not the user ha finished the task
    var completed: Bool
    //This is an int 0 through 100 for how much progress has been done on the task
    var com_percent: Int
    //This is the index in the array
    var index: Int
    //This determines whethere or not to show the task based on the current list view
    var hidden: Bool
    //This determines which list the task is in
    var seg: Int
    //This determines the old list so that we can move it back if we mark it as incomplete
    var prevseg: Int
    //This is the cell from the table that contains the data for the
    var cell: UITableViewCell?
}

//global variables that help with saving state
var tasks_global = [aTask]()
var tasks_save_global = [save_task]()
var name_segs = [String]()
var cur_seg = 0


//This is the main page that you enter when the app starts up
//This class contains everything that happens in this scene including transitions to/from this scene as well as changing the list that the task is on
class TaskListViewController: UITableViewController {
    //This is the task that we are going to pass in from another scene
    var newTask: String = ""
    //This is the index
    var index: Int = 0
    //Our array of tasks that we use
    var tasks = [aTask]()
    //This is the view controller
    //This is used for passing data from one screen to the other
    var tk: ViewTask!
    //This is the segue that we send the data with
    var seg: UIStoryboardSegue?
    //This is our table view controller, which displays all of the tasks
    var tvc: Any?
    //This is used in an if statement so we can get the data from the segue if we havent already
    var visited = false
    //This is the index path of the row of the table so we can link the data to the table
    var ixdp = IndexPath()
    //This is the selected portion of the segmented controller
    var selectedFile = 0
    //THis is our instance of the table view so we can manipulate the properties
    var TBV = UITableView()
    //This is the name of the new task list when adding a new section
    var new_seg: String?
    
    var first_time = true
    
    //Allows for segments to be added
    
    @IBOutlet weak var Files: UISegmentedControl!
    @IBAction func change_Tab(_ sender: Any) {
        //This is to create a c++ for loop since swift only allows for-in loops
        var i = 0
        //Determines which task list we are on
        selectedFile = Files.selectedSegmentIndex
        //This loops through every task and checks to see if it is part of the current list
        while i < tasks.count {
            if tasks[i].seg == selectedFile {
                //Unhides the cell if it is in the list
                tasks[i].hidden = false
                tasks[i].cell?.isHidden = false
            }
            else {
                //Otherwise it hides the cell
                tasks[i].hidden = true
                tasks[i].cell?.isHidden = true
            }
            i += 1
        }
        //Reloads the table so that it removes the cells we just marked as hidden
        TBV.reloadData()
        cur_seg = Files.selectedSegmentIndex
    }
    
    
    //This method hides the cells by setting their heights to zero
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0;
        if (tasks[indexPath.row].hidden) {
            height = 0.0;   //"Hidden"
        } else {
            height = 44.0;  //Full size
        }
        return height;
    }
    
    
    //This function was automatically generated by XCode but we had no use for it
    @IBAction func cancel(segue:UIStoryboardSegue) {
       
    }
    
    //This function is called when we are leaving another scene
    //This checks the segue that was used and transfers the data from the other controller to this one
    @IBAction func done(segue:UIStoryboardSegue) {
        
        //this segue comes from the task view page where you view the details of one task
        if segue.identifier == "donewithView" {
            //This creates an instance of our task that we will update with the incoming data
            var t = aTask()
            //Copies the instance of the scene that is sending data to this scene
            let tsk = segue.source as! ViewTask
            
            //Copies every element being received to this scene
            index = tsk.index
            t.task = tsk.cur_task
            t.com_date = tsk.com_date
            t.rem_date = tsk.rem_date
            t.completed = tsk.completed
            t.com_percent = tsk.com_percent
            
            //if the task is completed, this updates the segment to 1 (completed list)
            if tsk.completed {
                t.seg = 1
                t.prevseg = tsk.prevseg
            }
            //Otherwise it moveds it to the correct segment if it isnt completed
            else if tsk.completed == false && tsk.segment != 1 {
                t.seg = tsk.segment
                if tsk.segment != tsk.prevseg {
                    t.prevseg = tsk.segment
                }
                
            }
                //Otherwise just copies over the segments
            else {
                t.seg = tsk.prevseg
                t.prevseg = tsk.prevseg
            }
            //If the currently shown segment is the same as the tasks segment, unhide
            if tsk.cur_segment == t.seg {
                t.hidden = false
            }
            else {
                t.hidden = true
            }
            
            
            //Sets the array at the task index to the new data that was just received
            tasks[index] = t
            //Colors the cell based on the completion bool
            tableView.cellForRow(at: ixdp)?.backgroundColor = (self.tasks[ixdp.row].completed) ? UIColor.systemGreen : UIColor(named: "customControlColor")
            //refreshes the view
            tableView.reloadData()
        }
            //this comes from the create a task scene
        else {
            //Creates an instance of the task class
            var t = aTask()
            //Creates an instance of the add task scene to copy the data over
            let taskDetailVC = segue.source as! AddTask
            t.task = taskDetailVC.name
            t.com_date = taskDetailVC.com_date
            //Error checking the reminder date
            if taskDetailVC.rem_date != nil {
                t.rem_date = taskDetailVC.rem_date
            }
            t.completed = false
            t.com_percent = 0
            
            t.index = tasks.count
            
            t.hidden = false
            t.seg = Files.selectedSegmentIndex
            t.prevseg = Files.selectedSegmentIndex

            
            //Adds the task to the end of the list
            tasks.append(t)
            tableView.reloadData()
        }
        tasks_global = tasks
    }
    
    //Gets the indexPath so we can use it in the prepare function and access elements in the table
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        index = indexPath.row
        ixdp = indexPath
        prepare(for: seg!, sender: tvc!)
    }
    
    //This function prepares all of the data for sending it to the other scenes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If we are going to send it to the view task pages
        if (segue.identifier == "view") {
            //Checks if we have already visited it
            if visited == false {
                seg = segue
                tvc = sender
                visited = true
            }
                //if we have, it copies all of the information into a new task
            else {
                tk = segue.destination as? ViewTask
                tk.cur_task = tasks[index].task
                tk.com_date = tasks[index].com_date
                tk.rem_date = tasks[index].rem_date
                tk.completed = tasks[index].completed
                tk.com_percent = tasks[index].com_percent
                tk.index = index
                visited = false
                
                tk.hidden = tasks[index].hidden
                tk.segment = tasks[index].seg
                
                tk.prevseg = tasks[index].prevseg
                tk.cur_segment = selectedFile
                
                //this passes the segments from the segmented controller
                for i in Files.numberOfSegments {
                    tk.seg_sections.append(Files.titleForSegment(at: i)!)
                }
                
            }
        }
        
    }
    
    @IBAction func cant_do_that(_ sender: Any) {
        let alert = UIAlertController(title: "Can't add a task to completed section.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
         self.present(alert, animated: true)
        
    }
    
    //can cancel segue calls by returning false
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Adder" && Files.selectedSegmentIndex == 1 {
            cant_do_that(self)
            return false
        }
        else {
            return true
        }
    }
    
    //This is called everytime the table loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if there has been data saved reload it by checking global variables
        if tasks_save_global.count > 0 && first_time == true {
            
            var tsk = aTask();
            for i in tasks_save_global.count {
                tsk.task = tasks_save_global[i].task
                tsk.com_date = tasks_save_global[i].com_date
                tsk.rem_date = tasks_save_global[i].rem_date
                tsk.com_percent = tasks_save_global[i].com_percent
                tsk.completed = tasks_save_global[i].completed
                tsk.index = tasks_save_global[i].index
                tsk.seg = tasks_save_global[i].seg
                
                if tsk.seg == 0 {
                    tsk.hidden = false
                }
                else {
                    tsk.hidden = true
                }
                tsk.prevseg = tasks_save_global[i].prevseg
                tasks.append(tsk)
            }
            first_time = false
            tasks_save_global.removeAll()
        }
        else {
            tasks = []
        }
        
        //if segs are in memory recreate them
        if name_segs.count > 0 {
            Files.removeAllSegments()
            Files.insertSegment(withTitle: "Tasks", at: 0, animated: true)
            Files.insertSegment(withTitle: "Completed", at: 1, animated: true)
            for i in  name_segs.count {
                Files.insertSegment(withTitle: name_segs[i], at: i + 2, animated: true)
            }
            Files.selectedSegmentIndex = 0
            Files.sizeToFit()
        }
        else {
            Files.sizeToFit()
        }
        

        let lswipe = UISwipeGestureRecognizer(target: self, action: #selector(filechange(theswipe:)))
        lswipe.direction = UISwipeGestureRecognizer.Direction.left
        lswipe.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(lswipe)
        lswipe.name = "left"

        let rswipe = UISwipeGestureRecognizer(target: self, action: #selector(filechange(theswipe:)))
        rswipe.direction = UISwipeGestureRecognizer.Direction.right
        rswipe.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(rswipe)
        rswipe.name = "right"

    }
    
    
    //This is the number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }

    //This is just the size of the array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return tasks.count
    }
    
    //This creates a cell and adds a title to it
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initializes the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        //Sets the cell's text to the tasks title
        cell.textLabel?.text = tasks[indexPath.row].task
        //This links the cell to the task's cell member variable
        tasks[indexPath.row].cell = cell
        TBV = tableView
        
        tasks_global = tasks
        
        cell.backgroundColor = (tasks[indexPath.row].completed) ? UIColor.systemGreen : UIColor(named: "customControlColor")
        
        //returns the cell to the table
        return cell
    }
    
    //this function controls the swiping actions for each cell
    override func tableView(_ tableView: UITableView,
      leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      ->   UISwipeActionsConfiguration? {

      // Get current state from data source
        let favorite = tasks[indexPath.row].completed
        
        //Sets the title based on if the task is already completed or not
      let title = favorite ?
        NSLocalizedString("Mark Incomplete", comment: "Mark Incomplete") :
        NSLocalizedString("Mark Complete", comment: "Mark Complete")

        //Initializes the actions
      let action = UIContextualAction(style: .normal, title: title,
        handler: { (action, view, completionHandler) in
        // Update data source when user taps action
        self.tasks[indexPath.row].completed = !favorite
        completionHandler(true)
        
            //Changes the completon percentage based on if the task is completed or not
          if(self.tasks[indexPath.row].completed) {
            self.tasks[indexPath.row].com_percent = 100
          }
          else {
            self.tasks[indexPath.row].com_percent = 0
          }
        
            //Sets the index path to a glpbal variable for use in other functions
        self.ixdp = indexPath
            //Changes the background color of the cell
        tableView.cellForRow(at: indexPath)?.backgroundColor = (self.tasks[indexPath.row].completed) ? UIColor.systemGreen : UIColor(named: "customControlColor")
            //Deletes the cell
        self.check_delete(self, index: indexPath)
        
      })

        //Sets the background color of the swipe actions
      action.backgroundColor = favorite ? .red : .green
      let configuration = UISwipeActionsConfiguration(actions: [action])

        //returns the actions to the cell data structure
      return configuration
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //Deletes from the tasks array
            tasks.remove(at: indexPath.row)
            //Removes the cell
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(named: "customControlColor")
            //Deletes the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tasks_global = tasks
            
        } else if editingStyle == .insert {
            //We inserted in another place
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


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
                
                tasks_global = self.tasks
                
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
    
    
    
    //Initializes the alert popup when adding a section
    @IBOutlet weak var alt: UIAlertController!
    //This function call whenever the new section button is clicked
    @IBAction func alert (_ sender: Any) {

        let alert = UIAlertController(title: "Would you like to add or delete a section?", message: "Enter into the box the section you would like to add or delete.", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input section here"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            //Gets the name and adds the section to the segmented controller
            if let name = alert.textFields?.first?.text {
                self.addSection(self, seg: name)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                self.deleteSection(self, seg: name)
            }
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    //Adds a section to the segmented controller
    @IBAction func addSection(_ sender: Any, seg: String) {
        Files.insertSegment(withTitle: seg, at: Files.numberOfSegments, animated: true)
        name_segs.append(seg)
    }
    
    @IBAction func deleteSection(_ sender: Any, seg: String) {
        var seg_index = -1
        for i in Files.numberOfSegments {
            let s = Files.titleForSegment(at: i)
            if s == seg {
                seg_index = i
                name_segs.remove(at: i - 2)
                break
            }
        }
        if seg_index > 1 {
            print("file found")
            var i = 0
            //find tasks that are in deleted segment
            while i < tasks.count {
                if tasks[i].seg == seg_index {
                    tasks.remove(at: i)
                    tasks.reserveCapacity(tasks.count)
                }
                else {
                    i += 1
                }
            }
            Files.removeSegment(at: seg_index, animated: true)
            print("section removed")
            TBV.reloadData()
            Files.selectedSegmentIndex = seg_index - 1
            cur_seg = Files.selectedSegmentIndex
            tasks_global = tasks
        }
        
    }

    @objc func filechange(theswipe: UISwipeGestureRecognizer) {
        if theswipe.name == "left" {
            if Files.selectedSegmentIndex < Files.numberOfSegments - 1 {
                Files.selectedSegmentIndex = Files.selectedSegmentIndex + 1;
            }
        }
        if theswipe.name == "right" {
            if Files.selectedSegmentIndex > 0 {
                Files.selectedSegmentIndex = Files.selectedSegmentIndex - 1
            }
        }
        change_Tab(self)
    }
    
}
