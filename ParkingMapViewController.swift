//
//  ParkingMapViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/13/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import WebKit

class ParkingMapViewController: UIViewController {

    
    @IBOutlet weak var ParkingMapWebView: UIView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: ParkingMapWebView.bounds, configuration: WKWebViewConfiguration())
        ParkingMapWebView.addSubview(webView)
        
        guard let pdf = Bundle.main.url(forResource: "parkmap", withExtension: "pdf") else {
            return
        }

        let request = URLRequest(url: pdf)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
