//
//  ViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/12/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class LiveMapViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var LiveWebView: UIView!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Bust Routes"
        
        webView = WKWebView(frame: LiveWebView.bounds, configuration: WKWebViewConfiguration())
        LiveWebView.addSubview(webView)
        // "http://campusmaps.uark.edu/embed/routes"
        guard let url = URL(string: "https://www.apple.com") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

