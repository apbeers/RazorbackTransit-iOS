//
//  Bus.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/30/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import GoogleMaps

class Bus {
    
    var latitude: String!
    var longitude: String!
    var heading: String!
    var color: String!
    var routeName: String!
    var zonarId: String!
    
    init(latitude: String, longitude: String, heading: String, color: String, routeName: String, zonarId: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.heading = heading
        self.color = color
        self.routeName = routeName
        self.zonarId = zonarId
    }
    
    func getImageURL() -> URL{
        
        let imageString = "https://campusdata.uark.edu/api/busimages?color=" + color.dropFirst() + "&heading=" + heading
        
        return URL(string: imageString)!
    }
    
    func getColor() -> UIColor {
        return UIColor(hexString: color + "99")!
    }
    
    func getCoordinates() -> CLLocationCoordinate2D {
        
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func getCachedImageKey() -> String {
        
        guard let heading = Double(heading) else {
            return ""
        }

        return color + String(roundHeading(x: heading))
    }
    
    func roundHeading(x : Double) -> Int {
        return 30 * Int(round(x / 30.0))
    }
}
