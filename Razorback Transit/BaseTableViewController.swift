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
        navigationController?.navigationBar.barTintColor = Constants.Colors.razorbackRedBarColor
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}

