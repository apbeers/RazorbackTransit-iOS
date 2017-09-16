//
//  ViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/12/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class LiveMapViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var LiveWebView: UIView!
    
    var webView: WKWebView!
    let defaults = UserDefaults.standard
    var needsUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.checkIfNeedsReload), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.storeLastLoadedTime), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        webView = WKWebView(frame: LiveWebView.bounds, configuration: WKWebViewConfiguration())
        LiveWebView.addSubview(webView)
        webView.scrollView.isScrollEnabled = false
        
        webView.navigationDelegate = self
        
        guard let url = URL(string: "http://campusmaps.uark.edu/embed/routes") else {
            return
        }
        let request = URLRequest(url: url)
        
        webView.load(request)
        
    }
    
    func checkIfNeedsReload() {
        
        DispatchQueue.global().async {
            
            guard let lastLoaded = self.defaults.value(forKey: "date") as? Date else {
                return
            }
            
            guard let timeInterval = TimeInterval(exactly: -300) else {
                return
            }
            
            if lastLoaded.timeIntervalSince(Date()) < timeInterval && self.webView != nil {
                
                self.webView.reload()
            }
        }
    }
    
    func storeLastLoadedTime() {
        
        DispatchQueue.global().async {
            
            self.defaults.set(Date(), forKey: "date")
            self.defaults.synchronize()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

