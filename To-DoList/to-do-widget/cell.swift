//
//  cell.swift
//  to-do-widget
//
//  Created by Braxton Haynie on 5/8/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import UIKit

class cell: UITableViewCell {

    /// The reuse identifier for this table view cell.
    static let reuseIdentifier = "widgetcell"

    static let todayCellHeight: CGFloat = 110
    static let standardCellHeight: CGFloat = 55

    
    @IBOutlet var label: UILabel!
    
}
