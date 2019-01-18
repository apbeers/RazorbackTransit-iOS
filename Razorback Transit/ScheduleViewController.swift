//
//  ScheduleWebViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit
import Firebase
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class ScheduleViewController: BaseViewController, WKUIDelegate, UIScrollViewDelegate {

    @IBOutlet weak var ScheduleWebView: WKWebView!
    
    var filename: String!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = name
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let pdf = Bundle.main.url(forResource: filename, withExtension: "pdf") else {
            return
        }
        
        let request = URLRequest(url: pdf)
        ScheduleWebView.load(request)
        
        MSAnalytics.trackEvent("Schedule Viewed", withProperties: ["name": filename])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}
