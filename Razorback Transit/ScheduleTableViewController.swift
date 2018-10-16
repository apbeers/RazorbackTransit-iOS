//
//  ScheduleListViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import Firebase

class ScheduleTableViewController: BaseTableViewController, UIViewControllerPreviewingDelegate {
    
    @IBOutlet var ScheduleListTableView: UITableView!
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerForPreviewing(with: self, sourceView: ScheduleListTableView)
        navBar.topItem?.title = "Schedules"
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

        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return Constants.regularSchedules.count
        case 1:
            return Constants.reducedSchedules.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SelectedRows.selectedSchedule = indexPath
        
        var scheduleTitle: String!
        
        switch indexPath.section {
        case 0:
            scheduleTitle = Constants.regularSchedules[indexPath.row].title
        case 1:
            scheduleTitle = Constants.reducedSchedules[indexPath.row].title
        default:
            break;
        }
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: scheduleTitle as NSObject,
            AnalyticsParameterContentType: Constants.EventTypes.ScheduleSelected as NSObject
            ])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.MapNameLabel.text = Constants.regularSchedules[indexPath.row].title
        case 1:
            cell.MapNameLabel.text = Constants.reducedSchedules[indexPath.row].title
        default:
            break
        }
        
        if indexPath == SelectedRows.selectedRoute {
            cell.MapNameLabel.font = UIFont.boldSystemFont(ofSize: Constants.cellFontSize)
        }
        else {
            cell.MapNameLabel.font = UIFont.systemFont(ofSize: Constants.cellFontSize)
        }
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Regular Service"
        case 1:
            return "Reduced Service"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
   
    // MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as? ScheduleViewController
        
        guard let section = tableView.indexPathForSelectedRow?.section else {
            return
        }
        
        guard let row: Int = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        switch section {
        case 0:
            destination?.mapName = Constants.regularSchedules[row].fileName
        case 1:
            destination?.mapName = Constants.reducedSchedules[row].fileName
        default:
            destination?.mapName = ""
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = ScheduleListTableView.indexPathForRow(at: location) else {
            return UIViewController()
        }
        
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "ScheduleView") as? ScheduleViewController else {
            return UIViewController()
        }
        
        selectedIndexPath = indexPath
        
        switch indexPath.section {
        case 0:
            destination.mapName = Constants.regularSchedules[indexPath.row].fileName
        case 1:
            destination.mapName = Constants.reducedSchedules[indexPath.row].fileName
        default:
            destination.mapName = ""
        }
        
        return destination
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        SelectedRows.selectedSchedule = selectedIndexPath
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
