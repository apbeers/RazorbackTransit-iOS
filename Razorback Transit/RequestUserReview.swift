//
//  RequestUserReview.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/18/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import StoreKit

let userDefaults = UserDefaults.standard

func incrementAppRuns() {
    
        let runs = getRunCounts() + 1
        userDefaults.set(runs, forKey: Constants.keyNames.numberOfRunsForReviewPrompt)
        userDefaults.synchronize()
}

func getRunCounts() -> Int {
    
    guard var savedRuns = userDefaults.value(forKey: Constants.keyNames.numberOfRunsForReviewPrompt) as? Int else {
        return 0
    }
    
    if savedRuns > Constants.runsBeforeReviewPrompt {
        
        savedRuns = Constants.runsBeforeReviewPrompt + 1
    }
    
    return savedRuns
}

func showReview() {
    
    let runs = getRunCounts()
    
    if runs == Constants.runsBeforeReviewPrompt {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            
        }
    }
}
