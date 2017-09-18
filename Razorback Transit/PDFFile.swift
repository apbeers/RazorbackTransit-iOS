//
//  PDFFile.swift
//  Razorback Transit
//
//  Created by Andrew Beers on 9/14/17.
//  Copyright © 2017 Andrew Beers. All rights reserved.
//

import Foundation
import UIKit

class PDFFile {
    
    var fileName: String
    var title: String
    
    init(filename: String, title: String) {
        self.fileName = filename
        self.title = title
    }
}
