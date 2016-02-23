//
//  Vector.swift
//  Lost
//
//  Created by Rob Visentin on 2/22/16.
//  Copyright © 2016 Rob Visentin. All rights reserved.
//

import CoreGraphics

// MARK: - Vec2

protocol Vec2 {

    var x: CGFloat { get set }
    var y: CGFloat { get set }

    init(x: CGFloat, y: CGFloat)

}

extension Vec2 {

    init(_ vec: Vec2) {
        self.init(x: vec.x, y: vec.y)
    }

    var magnitude: CGFloat {
        return hypot(x, y)
    }

    var normalized: Self {
        return (self / magnitude)
    }

    func distanceTo(other: Vec2) -> CGFloat {
        return hypot(other.x - x, other.y - y)
    }

    func midpointTo(other: Vec2) -> Self {
        return Self.init(x: 0.5 * (x + other.x), y: 0.5 * (y + other.y))
    }

    func angleTo(other: Vec2) -> CGFloat {
        return atan2(self × other, self × other);
    }

    func lerpTo(other: Vec2, t: CGFloat) -> Self {
        return Self.init(x: x + t * (other.x - x), y: y + t * (other.y - y))
    }

    func translatedBy(tx tx: CGFloat, ty: CGFloat) -> Self {
        return Self.init(x: x + tx, y: y + ty)
    }

    func scaledBy(sx sx: CGFloat, sy: CGFloat) -> Self {
        return Self.init(x: x * sx, y: y * sy)
    }

    func rotatedBy(angle: CGFloat) -> Self {
        return transformedBy(CGAffineTransformMakeRotation(angle))
    }

    func transformedBy(t: CGAffineTransform) -> Self {
        return Self.init(x: t.a * x + t.c * y + t.tx, y: t.b * x + t.d * y + t.ty)
    }

    mutating func normalize() {
        self /= magnitude
    }

    mutating func translate(tx: CGFloat, ty: CGFloat) {
        x += tx
        y += ty
    }

    mutating func scale(sx: CGFloat, sy: CGFloat) {
        x *= sx
        y *= sy
    }

    mutating func rotate(angle: CGFloat) {
        transform(CGAffineTransformMakeRotation(angle))
    }

    mutating func transform(t: CGAffineTransform) {
        x = (t.a * x + t.c * y + t.tx);
        y = (t.b * x + t.d * y + t.ty);

    }

}

// MARK: - Operators

/**
*  Dot product of 2 vectors.
*/
infix operator × {
associativity left
precedence 150
}

func ×(lhs: Vec2, rhs: Vec2) -> CGFloat {
    return (lhs.x * rhs.y - lhs.y * rhs.x)
}

/**
*  Dot product of 2 vectors. Alt + 8 on Mac keyboard to make the symbol.
*/
infix operator • {
associativity left
precedence 150
}

func •(lhs: Vec2, rhs: Vec2) -> CGFloat {
    return (lhs.x * rhs.x + lhs.y * rhs.y)
}

func +<T : Vec2>(lhs: CGFloat, rhs: T) -> T {
    return T.init(x: lhs + rhs.x, y: lhs + rhs.y)
}

func +<T : Vec2>(lhs: T, rhs: CGFloat) -> T {
    return T.init(x: lhs.x + rhs, y: lhs.y + rhs)
}

func +=<T : Vec2>(inout lhs: T, rhs: CGFloat) {
    lhs = lhs + rhs
}

func +<T : Vec2>(lhs: T, rhs: Vec2) -> T {
    return T.init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func +=<T : Vec2>(inout lhs: T, rhs: Vec2) {
    lhs = lhs + rhs
}

func -<T : Vec2>(lhs: CGFloat, rhs: T) -> T {
    return T.init(x: lhs - rhs.x, y: lhs - rhs.y)
}

func -<T : Vec2>(lhs: T, rhs: CGFloat) -> T {
    return T.init(x: lhs.x - rhs, y: lhs.y - rhs)
}

func -=<T : Vec2>(inout lhs: T, rhs: CGFloat) {
    lhs = lhs - rhs
}

func -<T : Vec2>(lhs: T, rhs: Vec2) -> T {
    return T.init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -=<T : Vec2>(inout lhs: T, rhs: Vec2) {
    lhs = lhs - rhs
}

func *<T : Vec2>(lhs: CGFloat, rhs: T) -> T {
    return T.init(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *<T : Vec2>(lhs: T, rhs: CGFloat) -> T {
    return T.init(x: lhs.x * rhs, y: lhs.y * rhs)
}

func *=<T : Vec2>(inout lhs: T, rhs: CGFloat) {
    lhs = lhs * rhs
}

func *<T : Vec2>(lhs: T, rhs: Vec2) -> T {
    return T.init(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

func *=<T : Vec2>(inout lhs: T, rhs: Vec2) {
    lhs = lhs * rhs
}

func /<T : Vec2>(lhs: CGFloat, rhs: T) -> T {
    return T.init(x: lhs / rhs.x, y: lhs / rhs.y)
}

func /<T : Vec2>(lhs: T, rhs: CGFloat) -> T {
    return T.init(x: lhs.x / rhs, y: lhs.y / rhs)
}

func /=<T : Vec2>(inout lhs: T, rhs: CGFloat) {
    lhs = lhs / rhs
}

func /<T : Vec2>(lhs: T, rhs: Vec2) -> T {
    return T.init(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

func /=<T : Vec2>(inout lhs: T, rhs: Vec2) {
    lhs = lhs / rhs
}

// MARK: - Convenience Functions

func max(v: Vec2) -> CGFloat {
    return max(v.x, v.y)
}

func min(v: Vec2) -> CGFloat {
    return min(v.x, v.y)
}

// MARK: - Conformance

extension CGPoint : Vec2 {}

extension CGVector : Vec2 {

    var x: CGFloat { get { return dx } set { dx = newValue } }
    var y: CGFloat { get { return dy } set { dy = newValue } }

    init(x: CGFloat, y: CGFloat) {
        self.init(dx: x, dy: y)
    }

}

extension CGSize : Vec2 {

    var x: CGFloat { get { return width } set { width = newValue } }
    var y: CGFloat { get { return height } set { height = newValue } }

    init(x: CGFloat, y: CGFloat) {
        self.init(width: x, height: y)
    }

}
