//
//  ParkingMapViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class ParkingMapViewController: BaseViewController {

    @IBOutlet weak var ParkingMapWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        let fileName = Constants.parkingMap.fileName
        guard let pdf = Bundle.main.url(forResource: fileName , withExtension: "pdf") else {
            return
        }
        
        let request = URLRequest(url: pdf)
        ParkingMapWebView.load(request)
        
        MSAnalytics.trackEvent("Parking Map Viewed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
