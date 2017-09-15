//
//  ScheduleListViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit

enum RouteTypes: Int {
    case Regular
    case Reduced
}

class ScheduleTableViewController: BaseTableViewController {

    @IBOutlet var ScheduleListTableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.title = "Route Schedules"
        
       // self.navigationController?.navigationBar.topItem?.title = "Route Schedules"
       // self.navigationController?.navigationBar.barTintColor = Constants.Colors.razorbackRed
       // self.tabBarController?.tabBar.barTintColor = Constants.Colors.razorbackRed
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case 0:
            return Constants.regularSchedules.count
        case 1:
            return Constants.reducedSchedules.count
        default:
            return 0
        }
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
