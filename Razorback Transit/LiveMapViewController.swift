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
import CoreData

class LiveMapViewController: BaseViewController {
    
    var mapView: GMSMapView!
    var timer: Timer!
    var markers: [GMSMarker] = []
    var tappedMarker: GMSMarker!
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 36.068, longitude: -94.1725, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.rotateGestures = false
        view = mapView
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { _ in
                
                self.loadBusses()
            }
        }

        loadRoutes()
        loadBusses()
        loadStops()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        guard let timer = timer else {
            return
        }
        
        timer.invalidate()
    }
    
    func loadStops() {
        
        Alamofire.request(Constants.API.StopURL).responseString { responseString in
            
            var stops: [Stop] = []
            
            guard var data: String = responseString.value else {
                return
            }
            
            data = String(data.characters.dropFirst(10))
            data = String(data.characters.dropLast(2))
            
            let json = JSON.init(parseJSON: data)
            
            for (_, item) in json {
                
                let stop = Stop(id: item["id"].description, name: item["name"].description, latitude: item["latitude"].description, longitude: item["longitude"].description)
                
                stops.append(stop)
            }
            
            for stop in stops {
                
                let marker = GMSMarker(position: stop.getCoordinates())
                marker.icon = UIImage()
                marker.title = "This \n Some \n Text \n Text"
                marker.isFlat = true
                marker.map = self.mapView
                
                if let imageData = self.userDefaults.value(forKey: stop.id) as? Data {
                    
                    if let image = UIImage.init(data: imageData) {
                        
                        marker.icon = image
                    }
                } else {
                    
                    URLSession.shared.dataTask(with: stop.getURL(id: stop.id)) { data, response, error in
                        guard
                            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                            let data = data, error == nil,
                            let image = UIImage(data: data)
                            else { return }
                        DispatchQueue.main.async() {
                            
                            self.userDefaults.set(UIImagePNGRepresentation(image), forKey: stop.id)
                            marker.icon = image
                        }
                    }.resume()
                }
            }
        }
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
            
            for marker in self.markers {
                marker.map = nil
            }
            
            self.markers = []
            
            let json = JSON.init(parseJSON: data)
            
            var i = 0
            for (_, item) in json["Messages"][0]["Args"][0] {
                
                let bus = Bus(latitude: item["latitude"].description, longitude: item["longitude"].description, heading: item["heading"].description, color: item["color"].description, routeName: item["routeName"].description, zonarId: item["zonarId"].description)
                
                let marker = GMSMarker(position: bus.getCoordinates())
                marker.icon = UIImage()
                marker.zIndex = 5
                
                marker.map = self.mapView
                
                URLSession.shared.dataTask(with: bus.getImageURL()) { data, response, error in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                        else { return }
                    DispatchQueue.main.async() {
                        
                        marker.icon = image
                    }
                }.resume()
                i += 1
                self.markers.append(marker)
                
                busses.append(bus)
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
