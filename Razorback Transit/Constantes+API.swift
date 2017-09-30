//
//  Constantes+APIURLs.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/28/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

extension Constants {
    
    struct API {
        
        static let BuildingURL = "http://campusdata.uark.edu/api/buildings?callback=Buildings"
        static let RouteURL = "http://campusdata.uark.edu/api/routes?callback=Routes"
        static let StopURL = "http://campusdata.uark.edu/api/stops?callback=Stopsnull&routeIds=undefined-214-215-217-218-219-220-235"
        static let BusURL = "https://campusdata.uark.edu/signalr?transport=longPolling&connectionId=79fa1891-1a55-499b-8e75-68a7c680d5df&connectionData=%5B%7B%22name%22%3A%22BusesHub%22%7D%5D&messageId=5580&tid=7"
    }
}
