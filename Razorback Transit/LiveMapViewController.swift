//
//  ViewController.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/12/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//
/*
import UIKit
import GoogleMaps
import Firebase
import Alamofire
import SwiftyJSON
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class LiveMapViewController: BaseViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var busTimer: Timer!
    var busMarkers: [GMSMarker] = []
    var stopMarkers: [GMSMarker] = []
    var routePolyLines: [GMSPolyline] = []
    var userDefaults = UserDefaults.standard
    var routeIDs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 36.09, longitude: -94.1785, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.tiltGestures = false
        mapView.setMinZoom(10, maxZoom: mapView.maxZoom)
        mapView.delegate = self
        view = mapView
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: OperationQueue.main) { _ in

                self.loadBusses()
            
            self.busTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                
                DispatchQueue.global().async {
                    self.loadBusses()
                }
            }
            
            guard let lastLoaded = self.userDefaults.value(forKey: "date") as? Date else {
                
                self.loadRoutes()
                return
            }
            
            guard let timeInterval = TimeInterval(exactly: -900) else {
                return
            }
            
            if lastLoaded.timeIntervalSince(Date()) < timeInterval || self.busMarkers.count == 0 || self.stopMarkers.count == 0 || self.routePolyLines.count == 0 {
                
                DispatchQueue.global().async {
                    self.loadRoutes()
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: OperationQueue.main) { _ in
            
            self.userDefaults.set(Date(), forKey: "date")
            self.userDefaults.synchronize()
            
            guard let busTimer = self.busTimer else {
                return
            }
            busTimer.invalidate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        MSAnalytics.trackEvent("Live Map Viewed")
    }
    
    func buildStopURLString() -> String {
        var stopString = Constants.API.StopURL
        for id in routeIDs {
            stopString.append("-" + id)
        }
        return stopString
    }
    
    func loadStops() {
        
        Alamofire.request(buildStopURLString()).responseString { responseString in
            
            guard var data: String = responseString.value else {
                return
            }
            
            data = String(data.dropFirst(10))
            data = String(data.dropLast(2))
            
            let json = JSON(parseJSON: data)
            
            let oldStopMarkers = self.stopMarkers
            self.stopMarkers = []

            for (_, item) in json {
                
                let stop = Stop(id: item["id"].description, name: item["name"].description, latitude: item["latitude"].description, longitude: item["longitude"].description)
                
                let marker = GMSMarker(position: stop.getCoordinates())
                marker.icon = UIImage()
                marker.isFlat = true
                marker.snippet = stop.name
                marker.map = self.mapView
                marker.userData = stop.id
                self.stopMarkers.append(marker)
                
                if let imageData = self.userDefaults.value(forKey: stop.id) as? Data {
                    
                    if let image = UIImage(data: imageData) {
                        
                        marker.icon = image
                    }
                }
                
                URLSession.shared.dataTask(with: stop.getURL(id: stop.id, routeIDs: self.routeIDs)) { data, response, error in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                        else { return }
                    self.userDefaults.set(image.pngData(), forKey: stop.id)
                    DispatchQueue.main.async() {
                        marker.icon = image
                    }
                }.resume()
            }
            
            for stopMarker in oldStopMarkers {
                stopMarker.map = nil
            }
            
            self.focusMapToShowAllMarkers()
        }
    }
    
    func focusMapToShowAllMarkers() {
        
        guard let firstMarker = stopMarkers.first else {
            return
        }
        
        let firstLocation = firstMarker.position
        
        var bounds = GMSCoordinateBounds(coordinate: firstLocation, coordinate: firstLocation)

        for marker in stopMarkers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: CGFloat(40))
        mapView.animate(with: update)
    }
    
    func loadRoutes() {
        
        Alamofire.request(Constants.API.RouteURL).responseString { responseString in
            
            guard var data: String = responseString.value else {
                return
            }
            
            data = String(data.dropFirst(7))
            data = String(data.dropLast(2))
            
            let json = JSON(parseJSON: data)
            
            for shape in self.routePolyLines {
                shape.map = nil
            }
            
            let oldPolyLines = self.routePolyLines
            self.routePolyLines = []
            self.routeIDs = []
            
            for (_, item) in json {
                
                let route = Route(id: item["id"].description, name: item["name"].description, color: item["color"].description, shape: item["shape"].description, inService: item["inService"].description)
                
                if route.inService == "1" {
    
                    if !self.routeIDs.contains(route.id) {
                        self.routeIDs.append(route.id)
                    }
                    
                    let shape = GMSPolyline(path: route.getPath())
                    shape.strokeWidth = 5
                    shape.zIndex = 15
                    shape.strokeColor = route.getColor()
                    self.routePolyLines.append(shape)
                    shape.map = self.mapView
                }
            }
            
            for polyline in oldPolyLines {
                polyline.map = nil
            }
            
            self.loadStops()
            self.loadBusses()
        }
    }
    
    func buildBusURLString() -> String {
       // var busString = Constants.API.BusURL
        
        var part1 = "https://campusdata.uark.edu/api/buses?callback=jQuery18002674589609856972_1510069338014&routeIds=undefined"
        let part2 = "&_=1510069339459"
        
        for id in routeIDs {
            part1.append("-" + id)
        }
        part1.append(part2)
        return part1
    }
    
    func loadBusses() {
        
        Alamofire.request(buildBusURLString()).responseString { responseString in
            
            guard var data: String = responseString.value else {
                return
            }
            
            data = String(data.dropFirst(41))
            data = String(data.dropLast(2))
            
            for marker in self.busMarkers {
                marker.map = nil
            }
            
            self.busMarkers = []
            
            let json = JSON(parseJSON: data)
            
            for (_, item) in json {
                
                let bus = Bus(latitude: item["latitude"].description, longitude: item["longitude"].description, heading: item["heading"].description, color: item["color"].description, routeName: item["routeName"].description, zonarId: item["zonarId"].description)
                
                let marker = GMSMarker(position: bus.getCoordinates())
                marker.icon = UIImage()
                marker.title = bus.routeName
                marker.zIndex = 5
                marker.isFlat = true
                marker.map = self.mapView
                
                if let imageData = self.userDefaults.value(forKey: bus.getCachedImageKey()) as? Data {
                    
                    if let image = UIImage(data: imageData) {
                        
                        marker.icon = image
                    }
                    
                } else {
                
                    URLSession.shared.dataTask(with: bus.getImageURL()) { data, response, error in
                        guard
                            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                            let data = data, error == nil,
                            let image = UIImage(data: data)
                            else { return }
                        self.userDefaults.set(image.pngData(), forKey: bus.getCachedImageKey())
                        DispatchQueue.main.async() {
                            
                            marker.icon = image
                        }
                    }.resume()
                }
                self.busMarkers.append(marker)
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        guard let id = marker.userData as? String else {
            return false
        }
        
        MSAnalytics.trackEvent("Marker Tapped", withProperties: ["id": id])
        
        let url = "https://campusdata.uark.edu/api/routes?callback=jQuery18004251280482585251_1507605405541&stopId=" + id + "&_=1507605550296"
        
        Alamofire.request(url).responseString { responseString in
            
            guard var data: String = responseString.value else {
                return
            }
            
         //   data = data
            data = String(data.dropFirst(41))
            data = String(data.dropLast(2))
            
            let json = JSON(parseJSON: data)
            
            for (_, item) in json {
                
                let nextArrival = item["nextArrival"].description
                
                if nextArrival != "..." && nextArrival != "null" {
                    
                    marker.title = "Next Arrival: " + nextArrival
                    break
                }
            }
        }
        
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
*/
