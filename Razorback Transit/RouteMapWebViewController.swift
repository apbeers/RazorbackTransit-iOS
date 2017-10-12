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

        let width = screenSize.width
        let height = screenSize.height - 113
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
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
    }
}
