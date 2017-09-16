//
//  RouteMapWebViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class RouteMapWebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {
    

    @IBOutlet weak var RouteMapWebView: UIView!
    
    var webView: WKWebView!
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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let webViewSubviews = self.getSubviewsOfView(v: self.webView)
        for v in webViewSubviews {
            if v.description.range(of:"WKPDFPageNumberIndicator") != nil {
                v.isHidden = true // hide page indicator in upper left
            }
        }
    }
    
    func getSubviewsOfView(v:UIView) -> [UIView] {
        var viewArray = [UIView]()
        for subview in v.subviews {
            viewArray += getSubviewsOfView(v: subview)
            viewArray.append(subview)
        }
        return viewArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
