//
//  PassiogoLiveMapViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 5/16/19.
//  Copyright © 2019 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class PassiogoLiveMapViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://uark.passiogo.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
