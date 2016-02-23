//
//  Constants.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import Foundation

struct PhysicsCategory {

    static let world        = UInt32(1)
    static let player       = UInt32(1 << 1)
    static let obstacle     = UInt32(1 << 2)

    static let all          = UInt32.max

}
