//
//  ParkingMapViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit
import StoreKit

class ParkingMapViewController: BaseViewController {

    @IBOutlet weak var ParkingMapWebView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let width = screenSize.width
        let height = screenSize.height - 69
        var frame = CGRect(x: 0, y: 0, width: width, height: height)
        if #available(iOS 11.0, *) {
            frame = CGRect(x: 0.0, y: view.safeAreaInsets.top , width: width, height: height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        }
        
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self

        ParkingMapWebView.addSubview(webView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fileName = Constants.parkingMap.fileName
        guard let pdf = Bundle.main.url(forResource: fileName , withExtension: "pdf") else {
            return
        }
        
        let request = URLRequest(url: pdf)
        webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
