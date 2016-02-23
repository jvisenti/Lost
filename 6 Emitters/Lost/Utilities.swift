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

extension CGRect {

    func walkEdges(interval: CGFloat, function: CGPoint -> Void) {
        // Invoke the function at the origin
        function(origin)

        guard !isEmpty else {
            return
        }

        // Walk the rectangle edges in clockwise order, starting from the origin
        walkEdge(.MinYEdge, interval: interval, function: function)
        walkEdge(.MaxXEdge, interval: interval, function: function)
        walkEdge(.MaxYEdge, interval: interval, function: function)
        walkEdge(.MinXEdge, interval: interval, function: function)
    }

    private func walkEdge(edge: CGRectEdge, interval: CGFloat, function: CGPoint -> Void) {
        switch edge {
        case .MinYEdge:
            var point = origin

            while point.x + interval <= maxX {
                point.x += interval
                function(point)
            }

        case .MaxXEdge:
            var point = CGPoint(x: maxX, y: minY)

            while point.y + interval <= maxY {
                point.y += interval
                function(point)
            }

        case .MaxYEdge:
            var point = CGPoint(x: maxX, y: maxY)

            while point.x - interval >= minX {
                point.x -= interval
                function(point)
            }

        case .MinXEdge:
            var point = CGPoint(x: minX, y: maxY)

            while point.y - interval >= minY {
                point.y -= interval
                function(point)
            }
        }
    }

}
