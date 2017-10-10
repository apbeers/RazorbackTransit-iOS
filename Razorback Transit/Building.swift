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
        
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            return
        }
        
        path.add(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
    
    func getPath() -> GMSMutablePath {
        return path
    }
    
    func getCoordinates() -> CLLocationCoordinate2D {
        
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
