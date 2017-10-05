//
//  ViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/12/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import Alamofire
import SwiftyJSON

class LiveMapViewController: BaseViewController {
    
    var mapView: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 36.068, longitude: -94.1725, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        loadBuildings()
        loadRoutes()
        loadBusses()
    }
    
    func loadRoutes() {
        
        Alamofire.request(Constants.API.RouteURL).responseString { responseString in
            
            var routes: [Route] = []
            
            guard var data: String = responseString.value else {
                return
            }
            
            data = String(data.characters.dropFirst(7))
            data = String(data.characters.dropLast(2))
            
            let json = JSON.init(parseJSON: data)
            
            for (_, item) in json {
                
                let route = Route(name: item["name"].description, color: item["color"].description, shape: item["shape"].description, inService: item["inService"].description)
                
                routes.append(route)
            }
            
            for route in routes {
                
                if route.inService == "1" {
                    
                    let shape = GMSPolyline(path: route.getPath())
                    shape.strokeWidth = 5
                    shape.zIndex = 15
                    shape.strokeColor = route.getColor()
                    shape.map = self.mapView
                }
            }
        }
    }
    
    func loadBusses() {
        
        
        Alamofire.request(Constants.API.BusURL).responseString { responseString in
            
            var busses: [Bus] = []
            
            guard let data: String = responseString.value else {
                return
            }
            
            let json = JSON.init(parseJSON: data)
            
            for (_, item) in json["Messages"][0]["Args"][0] {
                
                let bus = Bus(latitude: item["latitude"].description, longitude: item["longitude"].description, heading: item["heading"].description, color: item["color"].description, routeName: item["routeName"].description, zonarId: item["zonarId"].description)
                busses.append(bus)
            }
            
            for bus in busses {
                
                let marker = GMSMarker(position: bus.getCoordinates())
                marker.icon = GMSMarker.markerImage(with: bus.getColor())
                marker.map = self.mapView
                
            }
        }
        
    }
    
    func loadBuildings() {
        
        Alamofire.request(Constants.API.BuildingURL).responseString { responseString in
            
            var buildings: [Building] = []
            
            guard var data: String = responseString.value else {
                return
            }
            
            data = String(data.characters.dropFirst(10))
            data = String(data.characters.dropLast(2))
            
            let json = JSON.init(parseJSON: data)
            
            for (_, item) in json {
                
                let building = Building(code: item["code"].description , address: item["address"].description, latitude: item["latitude"].description, longitude: item["longitude"].description, name: item["name"].description, shape: item["shape"].description)
                
                buildings.append(building)
            }
            
            for building in buildings {
                
                let shape = GMSPolygon(path: building.getPath())
                shape.strokeColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                shape.fillColor = UIColor(red: 247/255, green: 243/255, blue: 231/255, alpha: 1)
                shape.zIndex = 5
                shape.map = self.mapView
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

