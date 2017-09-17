//
//  ParkingMapViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class ParkingMapViewController: BaseViewController {

    @IBOutlet weak var ParkingMapWebView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: ParkingMapWebView.bounds, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self

        ParkingMapWebView.addSubview(webView)
        
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
