//
//  InfoWindowData.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 10/9/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import UIKit

class InfoWindowData {
    
    var stopName: String
    var stopDetails: [[String]]! = []
    var numberOfRoutes: Int = 0
    
    init(stopName: String) {
        self.stopName = stopName
    }
    
    func addRoute(color: String, name: String, nextArrival: String) {
        
        var details: [String] = []
        details.append(color)
        details.append(name)
        details.append(nextArrival)
        stopDetails.append(details)
        numberOfRoutes += 1
    }
    
    func getNumberOfRoutes() -> Int {
        return numberOfRoutes
    }
}
