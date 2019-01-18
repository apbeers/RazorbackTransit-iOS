//
//  RouteMapTableViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import Firebase
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class RouteMapTableViewController: BaseTableViewController, UIViewControllerPreviewingDelegate {
    
    @IBOutlet var RouteMapTableView: UITableView!
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForPreviewing(with: self, sourceView: RouteMapTableView)
        navBar.topItem?.title = "Routes"
    }

    override func viewDidAppear(_ animated: Bool) {
        
        MSAnalytics.trackEvent("Route Map Viewed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        SelectedRows.selectedRoute = IndexPath()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Constants.regularRoutes.count

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SelectedRows.selectedRoute = indexPath
    
        var routeTitle: String!
        
        routeTitle = Constants.regularRoutes[indexPath.row].title

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: routeTitle as NSObject,
            AnalyticsParameterContentType: Constants.EventTypes.RouteSelected as NSObject
            ])
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        cell.MapNameLabel.text = Constants.regularRoutes[indexPath.row].title

        
        if indexPath == SelectedRows.selectedSchedule {
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
        
        let destination = segue.destination as? RouteMapWebViewController
        
        guard let row: Int = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        destination?.mapName = Constants.regularRoutes[row].fileName

    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = RouteMapTableView.indexPathForRow(at: location) else {
            return UIViewController()
        }
        
        selectedIndexPath = indexPath
        
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "RouteView") as? RouteMapWebViewController else {
            return UIViewController()
        }

        destination.mapName = Constants.regularRoutes[indexPath.row].fileName
        
        return destination
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        SelectedRows.selectedRoute = selectedIndexPath
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }

}
