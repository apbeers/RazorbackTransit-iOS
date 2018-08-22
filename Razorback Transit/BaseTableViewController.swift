//
//  BaseTableViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var navBar: UINavigationBar!
    var regularSchedules: [PDFFile]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar = navigationController?.navigationBar
        navBar.barTintColor = Constants.Colors.razorbackRed
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
    }
}


