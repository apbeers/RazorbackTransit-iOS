//
//  TabBarController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/28/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: item.title! as NSObject,
            AnalyticsParameterContentType: Constants.EventTypes.TabSelected as NSObject
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
