//
//  ScheduleListViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import Firebase
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class ScheduleTableViewController: BaseTableViewController, UIViewControllerPreviewingDelegate {
    
    @IBOutlet var ScheduleListTableView: UITableView!
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerForPreviewing(with: self, sourceView: ScheduleListTableView)
        navBar.topItem?.title = "Schedules"
    }

    override func viewDidAppear(_ animated: Bool) {
        
        MSAnalytics.trackEvent("Schedule List Viewed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        SelectedRows.selectedSchedule = IndexPath()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return Constants.regularSchedules.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SelectedRows.selectedSchedule = indexPath
        
        var scheduleTitle: String!
        
        scheduleTitle = Constants.regularSchedules[indexPath.row].title

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: scheduleTitle as NSObject,
            AnalyticsParameterContentType: Constants.EventTypes.ScheduleSelected as NSObject
            ])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.MapNameLabel.text = Constants.regularSchedules[indexPath.row].title

        if indexPath == SelectedRows.selectedRoute {
            cell.MapNameLabel.font = UIFont.boldSystemFont(ofSize: Constants.cellFontSize)
        }
        else {
            cell.MapNameLabel.font = UIFont.systemFont(ofSize: Constants.cellFontSize)
        }
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
   
    // MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as? ScheduleViewController
        
        guard let row: Int = tableView.indexPathForSelectedRow?.row else {
            return
        }

        destination?.filename = Constants.regularSchedules[row].fileName
        destination?.name = Constants.regularSchedules[row].title
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = ScheduleListTableView.indexPathForRow(at: location) else {
            return UIViewController()
        }
        
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "ScheduleView") as? ScheduleViewController else {
            return UIViewController()
        }
        
        selectedIndexPath = indexPath
        
        destination.filename = Constants.regularSchedules[indexPath.row].fileName
        destination.name = Constants.regularSchedules[indexPath.row].title
 
        return destination
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        SelectedRows.selectedSchedule = selectedIndexPath
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
