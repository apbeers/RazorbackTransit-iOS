//
//  RequestUserReview.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/18/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import StoreKit

let runIncrementerSetting = Constants.keyNames.numberOfRunsForReviewPrompt  // UserDefauls dictionary key where we store number of runs

func incrementAppRuns() {      // counter for number of runs for the app. You can call this from App Delegate
    
    DispatchQueue.global().async {
        
        let usD = UserDefaults.standard
        let runs = getRunCounts() + 1
        usD.setValuesForKeys([runIncrementerSetting: runs])
        usD.synchronize()
    }
}

func getRunCounts () -> Int {   // Reads number of runs from UserDefaults and returns it.
    
    let usD = UserDefaults.standard
    let savedRuns = usD.value(forKey: runIncrementerSetting)
    
    var runs = 0
    if (savedRuns != nil) {
        
        runs = savedRuns as! Int
    }
    
    return runs
}

func showReview() {
    
    let runs = getRunCounts()
    
    if (runs == Constants.runsBeforeReviewPrompt) {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            
        }
    }
}
