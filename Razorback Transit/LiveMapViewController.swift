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
    var refreshTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        let width = screenSize.width
        let height = screenSize.height - 69
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        LiveWebView.addSubview(webView)
        webView.scrollView.isScrollEnabled = false
        
        webView.navigationDelegate = self
        
        guard let url = URL(string: Constants.liveMapURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func didBecomeActive() {
        
        let networkStatus = Reachability().connectionStatus()
        switch networkStatus {
        case .Unknown, .Offline:
            self.LiveWebView.isHidden = true
            self.OfflineView.isHidden = false
        default:
            self.LiveWebView.isHidden = false
            self.OfflineView.isHidden = true
        }
        
        refreshTimer = Timer.scheduledTimer(withTimeInterval: Constants.secondsBetweenAutoRefresh, repeats: true) { _ in
            self.webView.reload()
        }
        
        DispatchQueue.global().async {
            
            guard let lastLoaded = self.defaults.value(forKey: Constants.keyNames.timeOfLastLiveMapReload) as? Date else {
                return
            }
            
            guard let timeInterval = TimeInterval(exactly: Constants.secondsBetweenLiveMapReload) else {
                return
            }
            
            if lastLoaded.timeIntervalSince(Date()) < timeInterval && self.webView != nil {
                
                self.webView.reload()
            }
        }
    }
    
    func didEnterBackground() {
        
        DispatchQueue.global().async {
            
            self.defaults.set(Date(), forKey: Constants.keyNames.timeOfLastLiveMapReload)
            self.defaults.synchronize()
        }
        
        guard let timer = self.refreshTimer else {
            return
        }
        
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        webView.reload()
    }
}

