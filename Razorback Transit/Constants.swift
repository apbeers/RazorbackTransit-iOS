//
//  Constants.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

    struct Colors {
        
        static let razorbackRed = UIColor(colorLiteralRed: 157/255, green: 34/255, blue: 53/255, alpha: 1)
        static let razorbackRedBarColor = UIColor(colorLiteralRed: 139/255, green: 0/255, blue: 15/255, alpha: 1)
    }
    
    struct ScheduleFiles {
        
        static let blue = PDFFile(filename: "BLUE-22", title: "Blue 22")
        static let tan = PDFFile(filename: "TAN-35", title: "Tan 35")
        static let route13 = PDFFile(filename: "ROUTE-13", title: "Route 13")
        static let remoteexpress = PDFFile(filename: "REMOTEEXPRESS-48", title: "Remote Express")
        static let red = PDFFile(filename: "RED-26", title: "Red 26")
        static let purple = PDFFile(filename: "PURPLE-44", title: "Purple 44")
        static let orange = PDFFile(filename: "ORANGE-33", title: "Orange 33")
        static let green = PDFFile(filename: "GREEN-11", title: "Green 11")
        static let dickson = PDFFile(filename: "DICKSONST-07", title: "Dickson St")
        static let brown = PDFFile(filename: "BROWN-17", title: "Brown 17")
        static let blueReduced = PDFFile(filename: "BLUEREDUCED-02", title: "Blue Reduced")
        static let greenReduced = PDFFile(filename: "GREENREDUCED-01", title: "Green Reduced")
        static let orangeReduced = PDFFile(filename: "ORANGEREDUCED-03", title: "Orange Reduced")
        static let purpleReduced = PDFFile(filename: "PURPLEREDUCED-04", title: "Purple Reduced")
        static let redReduced = PDFFile(filename: "REDREDUCED-06", title: "Red Reduced")
        static let tanReduced = PDFFile(filename: "TANREDUCED-05", title: "Tan Reduced")
    }
    
    struct RouteFiles {
        
        static let blue = PDFFile(filename: "BLUE-22-ROUTE", title: "Blue 22")
        static let tan = PDFFile(filename: "TAN-35-ROUTE", title: "Tan 35")
        static let route13 = PDFFile(filename: "ROUTE-13-ROUTE", title: "Route 13")
        static let remoteexpress = PDFFile(filename: "REMOTEEXPRESS-48-ROUTE", title: "Remote Express")
        static let red = PDFFile(filename: "RED-26-ROUTE", title: "Red 26")
        static let purple = PDFFile(filename: "PURPLE-44-ROUTE", title: "Purple 44")
        static let orange = PDFFile(filename: "ORANGE-33-ROUTE", title: "Orange 33")
        static let green = PDFFile(filename: "GREEN-11-ROUTE", title: "Green 11")
        static let dickson = PDFFile(filename: "DICKSONST-07-ROUTE", title: "Dickson St")
        static let brown = PDFFile(filename: "BROWN-17-ROUTE", title: "Brown 17")
        static let blueReduced = PDFFile(filename: "BLUEREDUCED-02-ROUTE", title: "Blue Reduced")
        static let greenReduced = PDFFile(filename: "GREENREDUCED-01-ROUTE", title: "Green Reduced")
        static let orangeReduced = PDFFile(filename: "ORANGEREDUCED-03-ROUTE", title: "Orange Reduced")
        static let purpleReduced = PDFFile(filename: "PURPLEREDUCED-04-ROUTE", title: "Purple Reduced")
                static let redReduced = PDFFile(filename: "REDREDUCED-06-ROUTE", title: "Red Reduced")
        static let tanReduced = PDFFile(filename: "TANREDUCED-05-ROUTE", title: "Tan Reduced")
    }
    
    static let parkingMap: PDFFile = PDFFile(filename: "parkmap", title: "Parking Map")
    
    struct keyNames {
        static let timeOfLastLiveMapReload = "date"
        static let numberOfRunsForReviewPrompt = "runs"
    }
    
    static let regularSchedules: [PDFFile] = [ScheduleFiles.blue, ScheduleFiles.brown, ScheduleFiles.dickson, ScheduleFiles.green, ScheduleFiles.orange, ScheduleFiles.purple, ScheduleFiles.red, ScheduleFiles.remoteexpress, ScheduleFiles.route13, ScheduleFiles.tan]
    
    static let reducedSchedules: [PDFFile] = [ScheduleFiles.blueReduced, ScheduleFiles.greenReduced, ScheduleFiles.orangeReduced, ScheduleFiles.purpleReduced, ScheduleFiles.redReduced, ScheduleFiles.tanReduced]
    
    static let regularRoutes: [PDFFile] = [RouteFiles.blue, RouteFiles.brown, RouteFiles.dickson, RouteFiles.green, RouteFiles.orange, RouteFiles.purple, RouteFiles.red, RouteFiles.remoteexpress, RouteFiles.route13, RouteFiles.tan]
    
    static let reducedRoutes: [PDFFile] = [RouteFiles.blueReduced, RouteFiles.greenReduced, RouteFiles.orangeReduced, RouteFiles.purpleReduced, RouteFiles.redReduced, RouteFiles.tanReduced]
    
    static let liveMapURL: String = "http://campusmaps.uark.edu/embed/routes"
    
    static let cellFontSize: CGFloat = 17.0
    
    static let runsBeforeReviewPrompt: Int = 20
    
    static let secondsBetweenLiveMapReload: Int = -120
}

