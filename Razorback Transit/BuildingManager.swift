//
//  BuildingManager.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/26/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BuildingManager {
    
    func getData() {
        Alamofire.request("http://campusdata.uark.edu/api/buildings?callback=Buildings").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}
