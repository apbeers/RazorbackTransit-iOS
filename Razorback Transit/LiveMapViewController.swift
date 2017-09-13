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
        
        webView = WKWebView(frame: LiveWebView.bounds, configuration: WKWebViewConfiguration())
        LiveWebView.addSubview(webView)
        guard let url = URL(string: "http://campusmaps.uark.edu/embed/routes") else {
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

