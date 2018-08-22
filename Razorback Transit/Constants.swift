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
    
    struct ScheduleFiles {
        
        static let blue = PDFFile(filename: "BLUE_22_SCHEDULE", title: "Blue 22")
        static let tan = PDFFile(filename: "TAN_35_SCHEDULE", title: "Tan 35")
        static let route13 = PDFFile(filename: "ROUTE_13_SCHEDULE", title: "Route 13")
        static let remoteexpress = PDFFile(filename: "REMOTEEXPRESS_48_SCHEDULE", title: "Remote Express 48")
        static let red = PDFFile(filename: "RED_26_SCHEDULE", title: "Red 26")
        static let purple = PDFFile(filename: "PURPLE_44_SCHEDULE", title: "Purple 44")
        static let orange = PDFFile(filename: "ORANGE_33_SCHEDULE", title: "Orange 33")
        static let green = PDFFile(filename: "GREEN_11_SCHEDULE", title: "Green 11")
        static let brown = PDFFile(filename: "BROWN_17_SCHEDULE", title: "Brown 17")
        static let yellow = PDFFile(filename: "YELLOW_12_SCHEDULE", title: "Yellow 12")
        static let gray = PDFFile(filename: "GRAY_21_SCHEDULE", title: "Gray 21")
        static let blueReduced = PDFFile(filename: "BLUEREDUCED_02_SCHEDULE", title: "Blue Reduced 02")
        static let greenReduced = PDFFile(filename: "GREENREDUCED_01_SCHEDULE", title: "Green Reduced 01")
        static let orangeReduced = PDFFile(filename: "ORANGEREDUCED_03_SCHEDULE", title: "Orange Reduced 03")
        static let purpleReduced = PDFFile(filename: "PURPLEREDUCED_04_SCHEDULE", title: "Purple Reduced 04")
        static let redReduced = PDFFile(filename: "REDREDUCED_06_SCHEDULE", title: "Red Reduced 06")
        static let tanReduced = PDFFile(filename: "TANREDUCED_05_SCHEDULE", title: "Tan Reduced 05")
        static let brownReduced = PDFFile(filename: "BROWNREDUCED_07_SCHEDULE", title: "Brown Reduced 07")
    }
    
    struct RouteFiles {
        
        static let blue = PDFFile(filename: "BLUE_22_ROUTE", title: "Blue 22")
        static let tan = PDFFile(filename: "TAN_35_ROUTE", title: "Tan 35")
        static let route13 = PDFFile(filename: "ROUTE_13_ROUTE", title: "Route 13")
        static let remoteexpress = PDFFile(filename: "REMOTEEXPRESS_48_ROUTE", title: "Remote Express 48")
        static let red = PDFFile(filename: "RED_26_ROUTE", title: "Red 26")
        static let purple = PDFFile(filename: "PURPLE_44_ROUTE", title: "Purple 44")
        static let orange = PDFFile(filename: "ORANGE_33_ROUTE", title: "Orange 33")
        static let green = PDFFile(filename: "GREEN_11_ROUTE", title: "Green 11")
        static let brown = PDFFile(filename: "BROWN_17_ROUTE", title: "Brown 17")
        static let gray = PDFFile(filename: "GRAY_21_ROUTE", title: "Gray 21")
        static let yellow = PDFFile(filename: "YELLOW_12_ROUTE", title: "Yellow 12")
        static let blueReduced = PDFFile(filename: "BLUEREDUCED_02_ROUTE", title: "Blue Reduced 02")
        static let greenReduced = PDFFile(filename: "GREENREDUCED_01_ROUTE", title: "Green Reduced 01")
        static let orangeReduced = PDFFile(filename: "ORANGEREDUCED_03_ROUTE", title: "Orange Reduced 03")
        static let purpleReduced = PDFFile(filename: "PURPLEREDUCED_04_ROUTE", title: "Purple Reduced 04")
        static let redReduced = PDFFile(filename: "REDREDUCED_06_ROUTE", title: "Red Reduced 06")
        static let tanReduced = PDFFile(filename: "TANREDUCED_05_ROUTE", title: "Tan Reduced 05")
        static let brownReduced = PDFFile(filename: "BROWNREDUCED_07_ROUTE", title: "Brown Reduced 07")
    }
    
    static let parkingMap: PDFFile = PDFFile(filename: "parkmap", title: "Parking Map")
    
    struct keyNames {
        static let timeOfLastLiveMapReload = "date"
        static let numberOfRunsForReviewPrompt = "runs"
    }
    
    static let regularSchedules: [PDFFile] = [ScheduleFiles.green, ScheduleFiles.yellow, ScheduleFiles.route13, ScheduleFiles.brown, ScheduleFiles.gray, ScheduleFiles.blue, ScheduleFiles.red, ScheduleFiles.orange, ScheduleFiles.tan, ScheduleFiles.purple, ScheduleFiles.remoteexpress]
    
    static let reducedSchedules: [PDFFile] = [ScheduleFiles.greenReduced, ScheduleFiles.blueReduced, ScheduleFiles.orangeReduced, ScheduleFiles.purpleReduced, ScheduleFiles.tanReduced, ScheduleFiles.redReduced, ScheduleFiles.brownReduced]
    
    static let regularRoutes: [PDFFile] = [RouteFiles.green, RouteFiles.yellow, RouteFiles.route13, RouteFiles.brown, RouteFiles.gray, RouteFiles.blue, RouteFiles.red, RouteFiles.orange, RouteFiles.tan, RouteFiles.purple, RouteFiles.remoteexpress]
    
    static let reducedRoutes: [PDFFile] = [RouteFiles.greenReduced, RouteFiles.blueReduced, RouteFiles.orangeReduced, RouteFiles.purpleReduced, RouteFiles.tanReduced, RouteFiles.redReduced, RouteFiles.brownReduced]
    
    static let cellFontSize: CGFloat = 17.0
    
    static let runsBeforeReviewPrompt: Int = 15
}

