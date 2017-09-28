//
//  BuildingManager.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/26/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

extension String {
    
    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return self.substring(from: to)
            
        } else {
            return ""
        }
    }
}
class BuildingManager {
    
    func getBuidings() {
        
        Alamofire.request("http://campusdata.uark.edu/api/buildings?callback=Buildings").responseString { responseString in
            
            var data: String = responseString.value!
            data = String(data.characters.dropFirst(10))
            data = String(data.characters.dropLast(2))
            
            let jsonBuildings = JSON.init(parseJSON: data)
            print(jsonBuildings)
            
        }
    }
}
