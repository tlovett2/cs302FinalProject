//
//  ViewTask.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/5/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import UIKit


class ViewTask: UIViewController {
    var edit: EditTask!
    var cur_task = ""
    var com_date = ""
    var rem_date = ""
    
    func printtsk(string: String) {
        print("\(cur_task)\n")
       
    }
    
    
    @IBOutlet weak var thetask: UILabel!
    @IBOutlet weak var doc: UILabel!
    @IBOutlet weak var rem: UILabel!
    @IBOutlet weak var rd: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        thetask.text = cur_task
        thetask.sizeToFit();
        thetask.frame.origin = CGPoint(x: screenWidth/2 - (thetask.bounds.size.width / 2), y: screenHeight/8)
        doc.text = com_date
        doc.sizeToFit();
        doc.frame.origin = CGPoint(x: screenWidth/2 - (doc.bounds.size.width / 2), y: screenHeight/3)
        
        if rem_date == "" {
            rem.isHidden = true;
            rd.isHidden = true;
        }
        else {
            rem.text = "Reminder Date:"
            rem.sizeToFit();
            rd.text = rem_date
            rd.sizeToFit();
            rd.frame.origin = CGPoint(x: screenWidth/2 - (rd.bounds.size.width / 2), y: screenHeight/1.75)
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Editor") {
            edit = segue.destination as! EditTask
            
            edit.newcomDate = com_date
            edit.rem_date = rem_date
            edit.task = cur_task
            
        }
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
       
    }

    @IBAction func done(segue:UIStoryboardSegue) {
        let taskDetailVC = segue.source as! EditTask
        cur_task = taskDetailVC.newTask
        com_date = taskDetailVC.newcomDate
        if taskDetailVC.rem_date != "" {
            rem_date = taskDetailVC.rem_date
        }
        print(taskDetailVC.newTask);
        thetask.text = cur_task
        recent(lb: thetask, height: 8)
        doc.text = com_date
        recent(lb: doc, height: 2)
        
        if rem_date == "" {
            rem.isHidden = true;
            rd.isHidden = true;
        }
        else {
            rem.text = "Reminder Date:"
            rem.sizeToFit();
            rd.text = rem_date
            recent(lb: rd, height: 1.75)
        }
        
    }
    
    func recent(lb: UILabel, height: CGFloat) {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        lb.sizeToFit();
        lb.frame.origin = CGPoint(x: screenWidth/2 - (lb.bounds.size.width / 2), y: screenHeight/height)
        
    }
    
    
    
}

