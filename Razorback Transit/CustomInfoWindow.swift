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
    
    var routeNameLabels: [UILabel] = []
    
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
        
        let verticalStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        verticalStackView.backgroundColor = UIColor.blue
        
        verticalStackView.axis = UILayoutConstraintAxis.vertical
        verticalStackView.alignment = UIStackViewAlignment.center
        verticalStackView.spacing = 10;
        self.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.centerXAnchor.constraint(equalTo: (verticalStackView.superview?.centerXAnchor)!).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: (verticalStackView.superview?.centerYAnchor)!).isActive = true
        verticalStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        verticalStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        backgroundColor = UIColor.white
        
        for route in infoWindowData.stopDetails {
            
            let frame = CGRect(x: 0, y: 0, width: 300, height: 50)
            let horizontalStackView = UIStackView(frame: frame)
            
            
            let routeNameLabel = UILabel()
            routeNameLabel.text = route[2]
            routeNameLabel.backgroundColor = UIColor.red
            
            horizontalStackView.addArrangedSubview(routeNameLabel)
            
            let nextArrivalLabel = UILabel()
            nextArrivalLabel.text = route[1]
            nextArrivalLabel.backgroundColor = UIColor.blue
            
            horizontalStackView.addArrangedSubview(horizontalStackView)
            verticalStackView.addArrangedSubview(horizontalStackView)
            
            
          //  stackView.addArrangedSubview(label)
            
            /*
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: (label.superview?.leftAnchor)!).isActive = true
            label.centerYAnchor.constraint(equalTo: (label.superview?.centerYAnchor)!).isActive = true
            label.heightAnchor.constraint(equalToConstant: 40).isActive = true
            label.widthAnchor.constraint(equalToConstant: 100).isActive = true
 */
        }
    }
}
