//
//  ViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/12/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class LiveMapViewController: BaseViewController, WKUIDelegate {

    @IBOutlet weak var LiveWebView: UIView!
    @IBOutlet weak var OfflineView: UIView!

    let defaults = UserDefaults.standard
    var needsUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        webView = WKWebView(frame: LiveWebView.bounds, configuration: WKWebViewConfiguration())
        LiveWebView.addSubview(webView)
        webView.scrollView.isScrollEnabled = false
        
        webView.navigationDelegate = self
        
        guard let url = URL(string: Constants.liveMapURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
    }
    
    func willEnterForeground() {
        
        let networkStatus = Reachability().connectionStatus()
        switch networkStatus {
        case .Unknown, .Offline:
            self.LiveWebView.isHidden = true
            self.OfflineView.isHidden = false
        default:
            self.LiveWebView.isHidden = false
            self.OfflineView.isHidden = true
        }
        
        DispatchQueue.global().async {
            
            guard let lastLoaded = self.defaults.value(forKey: "date") as? Date else {
                return
            }
            
            guard let timeInterval = TimeInterval(exactly: -120) else {
                return
            }
            
            if lastLoaded.timeIntervalSince(Date()) < timeInterval && self.webView != nil {
                
                self.webView.reload()
            }
        }
    }
    
    func didEnterBackground() {
        
        DispatchQueue.global().async {
            
            self.defaults.set(Date(), forKey: "date")
            self.defaults.synchronize()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        webView.reload()
    }
}

