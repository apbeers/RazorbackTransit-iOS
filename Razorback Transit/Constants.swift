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
        
        static let schedule11 = PDFFile(filename: "schedule11", title: "Schedule 11")
        static let schedule13 = PDFFile(filename: "schedule13", title: "Schedule 13")
        static let schedule17 = PDFFile(filename: "schedule17", title: "Schedule 17")
        static let schedule21 = PDFFile(filename: "schedule21", title: "Schedule 21")
        static let schedule26 = PDFFile(filename: "schedule26", title: "Schedule 26")
        static let schedule33 = PDFFile(filename: "schedule33", title: "Schedule 33")
        static let schedule35 = PDFFile(filename: "schedule35", title: "Schedule 35")
        static let schedule44 = PDFFile(filename: "schedule44", title: "Schedule 44")
        static let schedule48 = PDFFile(filename: "schedule48", title: "Schedule 48")
    
    }
    
    struct RouteFiles {
        
        static let route11 = PDFFile(filename: "route11", title: "Route 11")
        static let route13 = PDFFile(filename: "route13", title: "Route 13")
        static let route17 = PDFFile(filename: "route17", title: "Route 17")
        static let route21 = PDFFile(filename: "route21", title: "Route 21")
        static let route26 = PDFFile(filename: "route26", title: "Route 26")
        static let route33 = PDFFile(filename: "route33", title: "Route 33")
        static let route35 = PDFFile(filename: "route35", title: "Route 35")
        static let route44 = PDFFile(filename: "route44", title: "Route 44")
        static let route48 = PDFFile(filename: "route48", title: "Route 48")
    }
    
    static let parkingMap: PDFFile = PDFFile(filename: "parkmap", title: "Parking Map")
    
    struct keyNames {
        static let timeOfLastLiveMapReload = "date"
        static let numberOfRunsForReviewPrompt = "runs"
    }
    
    static let regularSchedules: [PDFFile] = [ScheduleFiles.schedule11, ScheduleFiles.schedule13, ScheduleFiles.schedule17, ScheduleFiles.schedule21, ScheduleFiles.schedule26, ScheduleFiles.schedule33, ScheduleFiles.schedule35, ScheduleFiles.schedule44, ScheduleFiles.schedule48]
    
    static let regularRoutes: [PDFFile] = [RouteFiles.route11, RouteFiles.route13, RouteFiles.route17, RouteFiles.route21, RouteFiles.route26, RouteFiles.route33, RouteFiles.route35, RouteFiles.route44, RouteFiles.route48]
    
    static let cellFontSize: CGFloat = 17.0
    
    static let runsBeforeReviewPrompt: Int = 15
}

