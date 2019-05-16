//
//  Stop.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/30/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//
/*
import Foundation
import GoogleMaps
import Alamofire

class Stop {
    
    var id: String!
    var name: String!
    var latitude: String!
    var longitude: String!
    var nextArrival: String!
    var image: UIImage!
    
    init(id: String, name: String, latitude: String, longitude: String, nextArrival: String = "") {
        self.id =  id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.nextArrival = nextArrival
    }
    
    func getURL(id: String, routeIDs: [String]) -> URL {
        
        var urlString = "https://campusdata.uark.edu/api/stopimages?stopId=" + id + "&routeIds=undefined"
        
        for id in routeIDs {
            
            urlString.append("-" + id)
        }
 
        return URL(string: urlString)!
    }
    
    func getCoordinates() -> CLLocationCoordinate2D {
        
        guard let latitude = Double(latitude), let longitude = Double(longitude) else {
            return CLLocationCoordinate2D();
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
*/
