//
//  RouteMapWebViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class RouteMapWebViewController: BaseViewController, WKUIDelegate {

    @IBOutlet weak var RouteMapWebView: WKWebView!
    
    var filename: String!
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = name
    }

    override func viewDidAppear(_ animated: Bool) {
        
        guard let pdf = Bundle.main.url(forResource: filename, withExtension: "pdf") else {
            return
        }
        
        let request = URLRequest(url: pdf)
        RouteMapWebView.load(request)
        
        MSAnalytics.trackEvent("Route Map Viewed", withProperties: ["name": filename])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
