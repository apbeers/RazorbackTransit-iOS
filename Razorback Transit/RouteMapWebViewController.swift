//
//  RouteMapWebViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class RouteMapWebViewController: BaseViewController, WKUIDelegate {

    @IBOutlet weak var RouteMapWebView: UIView!
    
    var mapName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: RouteMapWebView.bounds, configuration: WKWebViewConfiguration())
        RouteMapWebView.addSubview(webView)
        webView.navigationDelegate = self
        
        guard let pdf = Bundle.main.url(forResource: mapName, withExtension: "pdf") else {
            return
        }
        
        let request = URLRequest(url: pdf)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
