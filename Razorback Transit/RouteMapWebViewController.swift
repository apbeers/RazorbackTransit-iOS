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

    @IBOutlet weak var RouteMapWebView: UIView!
    
    var filename: String!
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = name
        
        let width = screenSize.width
        let height = screenSize.height - 113
        var frame = CGRect(x: 0, y: 0, width: width, height: height)
        if #available(iOS 11.0, *) {
            frame = CGRect(x: 0.0, y: view.safeAreaInsets.top , width: width, height: height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        }
        
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        RouteMapWebView.addSubview(webView)
        webView.navigationDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        
        guard let pdf = Bundle.main.url(forResource: filename, withExtension: "pdf") else {
            return
        }
        
        let request = URLRequest(url: pdf)
        webView.load(request)
        
        MSAnalytics.trackEvent("Route Map Viewed", withProperties: ["name": filename])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
