//
//  ViewTask.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/5/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import UIKit


//The class for the entire view task scene
class ViewTask: UIViewController {
    //Instance of the edit task page
    var edit: EditTask!
    //Current task
    var cur_task = ""
    //Completion date
    var com_date = ""
    //Reminder date
    var rem_date = ""
    //Is the task completed
    var completed = false
    //How completed is the task
    var com_percent = 0
    //What index in the table is the task
    var index: Int!
    //An instance of the task class
    var t = aTask()
    //Previous list before it was marked as completed
    var prevseg = 0
    //Is the task part of the current list
    var hidden = false
    //List that the task is part of
    var segment = 0
    //List that is currently being showns
    var cur_segment = 0
    //used to reconstruct the segments from the view task list page
    var seg_sections = [String]()
    
    //Initializes the slider
    @IBOutlet weak var percentage: UISlider!
    //This function updates when the slider is moved
    @IBAction func perChange(_ sender: Any) {
        //Initializes the percentage to what the task has
        com_percent = Int(percentage.value)
        //Checks to see if the task is completed based on if the completed percent is 100
        completed = (com_percent == 100) ? true : false;
        
        //Updates the text based on how complete the task is
        if com_percent == 100 {
            status.text = "Complete"
        }
        else if com_percent < 100 && com_percent > 60 {
            status.text = "Nearly Complete"
        }
        else if com_percent <= 60 && com_percent >= 40 {
            status.text = "Halfway Complete"
        }
        else if com_percent < 40 && com_percent > 0 {
            status.text = "Mostly Incomplete"
        }
        else {
            status.text = "Incomplete"
        }
        //adjusts the size of the "complete" text
        status.sizeToFit();
        
    }
    
    //Initializes the task title
    @IBOutlet weak var thetask: UILabel!
    //Initializes the status label
    @IBOutlet weak var status: UILabel!
    //Inializes the date of completion label
    @IBOutlet weak var doc: UILabel!
    //Initializes the reminder label
    @IBOutlet weak var rem: UILabel!
    //Initializes the reminder date label
    @IBOutlet weak var rd: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //gets the screen size and width
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        //Sets the task title and fixes the size
        thetask.text = cur_task
        thetask.sizeToFit();
        //Sets the position of the task title
        thetask.frame.origin = CGPoint(x: screenWidth/2 - (thetask.bounds.size.width / 2), y: thetask.frame.origin.y)
        //Sets the completed text based on if it is completed or not
        status.text = (completed ? "Completed" : "Incomplete")
        status.sizeToFit();
        // Sets the position of the completed text
        status.frame.origin = CGPoint(x: screenWidth/2 - (thetask.bounds.size.width / 2), y: status.frame.origin.y)
        
        //Sets the date of completion text and location
        doc.text = com_date
        doc.sizeToFit();
        doc.frame.origin = CGPoint(x: screenWidth/2 - (doc.bounds.size.width / 2), y: doc.frame.origin.y)
        
        //Checks if there is a reminder date and hides everything if not
        if rem_date == "" {
            rem.isHidden = true;
            rd.isHidden = true;
            rd.sizeToFit();
            rd.frame.origin = CGPoint(x: screenWidth/2 - (rd.bounds.size.width / 2), y: rd.frame.origin.y)
        }
        else {
            //Otherwise it shows the date selected and sets the position
            rem.text = "Reminder Date:"
            rem.sizeToFit();
            rd.text = rem_date
            rd.sizeToFit();
            rd.frame.origin = CGPoint(x: screenWidth/2 - (rd.bounds.size.width / 2), y: rd.frame.origin.y)
        }
        
        //Sets the percent slider to teh corrrect int
        percentage.value = Float(com_percent)
        //the left side of the slider is green
        percentage.minimumTrackTintColor = UIColor.systemGreen
        //the right side of the slider is red
        percentage.maximumTrackTintColor = UIColor.systemRed
        
        //this resets the segments to the new lsit of segmentes
        FileSelect.removeAllSegments()
        for i in seg_sections.count {
            FileSelect.insertSegment(withTitle: seg_sections[i], at: i, animated: true)
        }
        //Highlights the correct list and fixes the size
        FileSelect.selectedSegmentIndex = segment
        FileSelect.sizeToFit()
        //Sets the segment width to text width
        FileSelect.apportionsSegmentWidthsByContent = true
        //Positions the segmented controlelr
        FileSelect.frame.origin = CGPoint(x: screenWidth/2 - (FileSelect.bounds.size.width / 2), y: FileSelect.frame.origin.y)
        
        
        //allows for swiping back to main page
        let exitSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(theSwipe:)))
        exitSwipe.direction = UISwipeGestureRecognizer.Direction.right
        exitSwipe.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(exitSwipe)
    }
   
    //This is used to send data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //This sends data to edittask
        if segue.identifier == "Editor" {
            //sets the instance of the edit task page
            edit = (segue.destination as! EditTask)
            //Updates the variables
            edit.newcomDate = com_date
            edit.rem_date = rem_date
            edit.task = cur_task
            
        }
        //This is used for sending date ot the task list view
        if segue.identifier == "donewithView" {
            //if it is on the completed list and it is 100% completed
            if FileSelect.selectedSegmentIndex == 1 && com_percent == 100 {
                //Sets the segment to the completed list and updates the completed bool
                com_percent = 100
                completed = true
                segment = 1
            }
                //if it is completed but not in the completed list
            else if cur_segment == 1 && FileSelect.selectedSegmentIndex != 1 {
                //Uncompletes it
                com_percent = 0
                completed = false
                segment = FileSelect.selectedSegmentIndex

            }
            //moves it to completed list if 100% completed
            else if com_percent == 100 {
                com_percent = 100
                completed = true
                segment = 1
                FileSelect.selectedSegmentIndex = 1

                hidden = true
            }
                //otherwise copies over the data
            else {

                segment = FileSelect.selectedSegmentIndex
                completed = false
                perChange(percentage!)
            }

        }
        
        
    }
    
    //This was generated by xcode but we did not need to use it
    @IBAction func cancel(segue:UIStoryboardSegue) {
       
    }
    
    //this is for coming to this scene from the edit task page
    @IBAction func done(segue:UIStoryboardSegue) {
        //Initializes the edit task function
        let taskDetailVC = segue.source as! EditTask
        //Copies the data
        cur_task = taskDetailVC.newTask
        com_date = taskDetailVC.newcomDate
        //Checks if the reminder date was selected
        if taskDetailVC.rem_date != "" {
            rem_date = taskDetailVC.rem_date
        }
        //sets the task and date of completion text
        thetask.text = cur_task
        //Sets the position
        recent(lb: thetask)
        doc.text = com_date
        recent(lb: doc)
        
        //Cehcks if the reminder date exists
        if rem_date == "" {
            //Hides it if it doesnt
            rem.isHidden = true;
            rd.isHidden = true;
        }
        else if (taskDetailVC.Reminder_Outlet2.isOn == false) {
            rem.isHidden = true;
            rd.isHidden = true;
            rem_date = ""
        }
        else {
            //Otherwise unhides it and adds the data
            rem.isHidden = false;
            rd.isHidden = false;
            rem.text = "Reminder Date:"
            rem.sizeToFit();
            rd.text = rem_date
            recent(lb: rd)
        }
        
    }
    
    //This function sets the position of the label given
    func recent(lb: UILabel) {
        //Gets the screen size
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        //Centers the label
        lb.sizeToFit();
        lb.frame.origin = CGPoint(x: screenWidth/2 - (lb.bounds.size.width / 2), y: lb.frame.origin.y)
        
    }
    
    //Initializes the segmented controller for the lsits
    @IBOutlet weak var FileSelect: UISegmentedControl!
    @IBAction func Change_File(_ sender: Any) {
        
        //Sets the segment
        segment = FileSelect.selectedSegmentIndex
        //Determines whther or not to hide the current task based on the selected segmente\
        if segment == cur_segment {
            hidden = false
        }
        else {
            hidden = true
        }
    }
}

extension UIViewController {
    @objc func swipe(theSwipe: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "donewithView", sender: self)
    }
}
