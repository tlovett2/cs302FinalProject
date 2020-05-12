//
//  TodayViewController.swift
//  to-do-widget
//
//  Created by Braxton Haynie on 5/8/20.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UITableViewController, NCWidgetProviding {

    //var tasks = load data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //allows for exapanding widget
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        let tbv = UINib(nibName: "widgetcell", bundle: nil)
               tableView.register(tbv, forCellReuseIdentifier: cell.reuseIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        //load data from disk here
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
    
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            var height: CGFloat = 0/*
            for index in /*tasks.indeces*/ {
                    switch index {
                    case 0: height += cell.todayCellHeight
                    default: height += cell.standardCellHeight
                    }
                }*/
                preferredContentSize = CGSize(width: maxSize.width, height: min(height, maxSize.height))
            @unknown default:
                preconditionFailure("Unexpected value for activeDisplayMode.")
        }
        
    }
    
    
    // MARK: - Content container protocol

    /// - Tag: ViewWillTransitionToSizeWithCoordinator
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let updatedVisibleCellCount = numberOfTableRowsToDisplay()
        let currentVisibleCellCount = self.tableView.visibleCells.count
        let cellCountDifference = updatedVisibleCellCount - currentVisibleCellCount

        // If the number of visible cells has changed, animate them in/out along with the resize animation.
        if cellCountDifference != 0 {
            coordinator.animate(alongsideTransition: { [unowned self] (UIViewControllerTransitionCoordinatorContext) in
                self.tableView.performBatchUpdates({ [unowned self] in
                    // Build an array of IndexPath objects representing the rows to be inserted or deleted.
                    let range = (1...abs(cellCountDifference))
                    let indexPaths = range.map({ (index) -> IndexPath in
                        return IndexPath(row: index, section: 0)
                    })

                    // Animate the insertion or deletion of the rows.
                    if cellCountDifference > 0 {
                        self.tableView.insertRows(at: indexPaths, with: .fade)
                    } else {
                        self.tableView.deleteRows(at: indexPaths, with: .fade)
                    }
                }, completion: nil)
            }, completion: nil)
        }
    }
    
    
    // MARK: - Table view data source

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return numberOfTableRowsToDisplay()
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier,
                                                          for: indexPath) as? ForecastTableViewCell
           else { preconditionFailure("Expected to dequeue a ForecastWidgetCell") }

           let weatherForecast = weatherForecastData[indexPath.row]
           cell.dateLabel.text = weatherForecast.daysFromNowDescription
           cell.forecastImageView.image = weatherForecast.forecast.imageAsset
           cell.forecastLabel.text = weatherForecast.forecast.description
           return cell
       }
    
    
    /// - Tag: OpenMainApp
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open the main app at the correct page for the day tapped in the widget.
        let weatherForecast = weatherForecastData[indexPath.row]
        if let appURL = URL(string: "weatherwidget://?daysFromNow=\(weatherForecast.daysFromNow)") {
            extensionContext?.open(appURL, completionHandler: nil)
        }

        // Don't leave the today extension with a selected row.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Helpers
       func numberOfTableRowsToDisplay() -> Int {
           if extensionContext?.widgetActiveDisplayMode == NCWidgetDisplayMode.compact {
               return 1
           } else {
               return weatherForecastData.count
           }
       }
    
}
