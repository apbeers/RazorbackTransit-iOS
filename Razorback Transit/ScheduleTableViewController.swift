//
//  ScheduleListViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit

class ScheduleTableViewController: BaseTableViewController {

    @IBOutlet var ScheduleListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
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
        
        switch section {
        case 0:
            destination?.mapName = Constants.regularSchedules[(tableView.indexPathForSelectedRow?.row)!].fileName
        case 1:
            destination?.mapName = Constants.reducedSchedules[(tableView.indexPathForSelectedRow?.row)!].fileName
        default:
            destination?.mapName = ""
        }

    }
    

}
