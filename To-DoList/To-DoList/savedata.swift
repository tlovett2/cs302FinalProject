//
//  savedata.swift
//  To-DoList
//
//  Created by Braxton Haynie on 4/25/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import Foundation

func savedata (tasks: [aTask]) -> [save_task] {
    var ST = [save_task]()
    for i in tasks.count {
        var tsk = save_task()
        
        tsk.task = tasks[i].task
        tsk.com_date = tasks[i].com_date
        tsk.rem_date = tasks[i].rem_date
        tsk.com_percent = tasks[i].com_percent
        tsk.completed = tasks[i].completed
        tsk.hidden = tasks[i].hidden
        tsk.index = tasks[i].index
        tsk.seg = tasks[i].seg
        tsk.prevseg = tasks[i].prevseg
        ST.append(tsk)
    }
    
    return ST
}
