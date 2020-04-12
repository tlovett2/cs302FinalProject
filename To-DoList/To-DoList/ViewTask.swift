//
//  ViewTask.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/5/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import UIKit


class ViewTask: UIViewController {
    
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
   
    
    
}

