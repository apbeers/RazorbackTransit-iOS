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
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        right.direction = .right
        self.view.addGestureRecognizer(right)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: item.title! as NSObject,
            AnalyticsParameterContentType: Constants.EventTypes.TabSelected as NSObject
            ])
    }
    
    @objc func swipeLeft() {
        
        guard let total = viewControllers?.count else {
            return
        }
        
        selectedIndex = min(total - 1, selectedIndex + 1)
    }
    
    @objc func swipeRight() {
        
        selectedIndex = max(0, selectedIndex - 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
