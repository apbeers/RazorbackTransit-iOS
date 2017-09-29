//
//  Route.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/28/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import GoogleMaps

class Route {
    
    var name: String!
    var color: String!
    var shape: String!
    var inService: String!
    
    private var path = GMSMutablePath()
    
    init(name: String, color: String, shape: String, inService: String) {
        self.name = name
        self.color = color
        self.shape = shape
        self.inService = inService
        
        let coordinates = shape.components(separatedBy: ",")
        
        for coordinate in coordinates {
            
            if coordinates.count > 1 {
                let latlong = coordinate.components(separatedBy: " ")
                addPathCoordinate(latitude: latlong[0], longitude: latlong[1])
            }
        }
    }
    
    private func addPathCoordinate(latitude: String, longitude: String) {
        
        path.add(CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!))
    }
    
    func getPath() -> GMSMutablePath {
        return path
    }
    
    func getColor() -> UIColor {
        return UIColor(hexString: color + "99")!
    }
    
}
