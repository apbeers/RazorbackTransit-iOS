//
//  Building.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/28/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import GoogleMaps

class Building {
    
    var code: String!
    var address: String!
    var latitude: String!
    var longitude: String!
    var name: String!
    var shape: String!
    
    private var path = GMSMutablePath()
    
    init(code: String, address: String, latitude: String, longitude: String, name: String, shape: String) {
        self.code = code
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.shape = shape
        
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
    
    func getCoordinates() -> CLLocationCoordinate2D {
        
        return CLLocationCoordinate2D(latitude: Double(self.latitude)!, longitude: Double(self.longitude)!)
    }
}
