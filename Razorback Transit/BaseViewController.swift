//
//  BaseViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class BaseViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}


