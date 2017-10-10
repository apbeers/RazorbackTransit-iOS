//
//  CustomInfoWindow.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 10/9/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import UIKit

class CustomInfoWindow: UIView {
    

    var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            // AutoLayout constraints
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    func setUp(infoWindowData: InfoWindowData) {
        
        for line in infoWindowData.stopDetails {
            
            print(line[0])
            print(line[1])
            print(line[2])
        }
        
        backgroundColor = UIColor.red
        
    }
    
}
