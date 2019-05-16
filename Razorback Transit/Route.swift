//
//  Route.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/28/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//
/*
import GoogleMaps

class Route {
    
    var id: String!
    var name: String!
    var color: String!
    var shape: String!
    var inService: String!
    
    private var path = GMSMutablePath()
    
    init(id: String, name: String, color: String, shape: String, inService: String) {
        self.id = id
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
        
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            return
        }
        
        path.add(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
    
    func getPath() -> GMSMutablePath {
        return path
    }
    
    func getColor() -> UIColor {
        return UIColor(hexString: color + "99")!
    }
    
}
*/
