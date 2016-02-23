//
//  Utilities.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import CoreGraphics

extension CGFloat {

    var radians: CGFloat { return self * CGFloat(M_PI / 180.0) }
    var degrees: CGFloat { return self * CGFloat(180.0 / M_PI) }
    
}
