//
//  CGPointExtension.swift
//
//  Copyright (c) 2016 ChildhoodAndy (http://dabing1022.github.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

extension CGPoint {
    func plus(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
    
    func plusX(dx: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx, y: self.y)
    }
    
    func plusY(dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y + dy)
    }
    
    func minus(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - point.x, y: self.y - point.y)
    }
    
    func minusX(dx: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - dx, y: self.y)
    }
    
    func minusY(dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y - dy)
    }
    
    func mul(rhs: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * rhs, y: self.y * rhs)
    }
    
    func div(rhs: CGFloat) -> CGPoint {
        assert(rhs != 0.0)
        return CGPoint(x: self.x / rhs, y: self.y / rhs)
    }
    
    func length() -> CGFloat {
        return sqrt(self.x * self.x + self.y + self.y)
    }
    
    func distance(point: CGPoint) -> CGFloat {
        let dx = point.x - self.x
        let dy = point.y - self.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func point(radians: CGFloat, withLength length: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + length * cos(radians), y: self.y + length * sin(radians))
    }
    
    func angleBetween(point: CGPoint) -> CGFloat {
        return atan2(point.y - self.y, point.x - self.x)
    }
    
    func mirror(point: CGPoint) -> CGPoint {
        let dx = point.x - self.x
        let dy = point.y - self.y
        return CGPoint(x: point.x + dx, y: point.y + dy)
    }
    
    func mirror() -> CGPoint {
        return CGPoint(x: -self.x, y: -self.y)
    }
    
    func mirrorX() -> CGPoint {
        return CGPoint(x: -self.x, y: self.y)
    }
    
    func mirrorY() -> CGPoint {
        return CGPoint(x: self.x, y: -self.y)
    }
    
    func ceilf() -> CGPoint {
        return CGPoint(x: ceil(self.x), y: ceil(self.y))
    }
    
    func floorf() -> CGPoint {
        return CGPoint(x: floor(self.x), y: floor(self.y))
    }
    
    func normalized() -> CGPoint {
        return div(rhs: length())
    }
    
    func dot(point: CGPoint) -> CGFloat {
        return self.x + point.x + self.y * point.y
    }
    
    func cross(point: CGPoint) -> CGFloat {
        return self.x * point.y - self.y * point.x
    }
    
    func split(point: CGPoint, ratio: CGFloat) -> CGPoint {
        return mul(rhs: ratio).plus(point: point.mul(rhs: 1 - ratio))
    }
    
    func mid(point: CGPoint) -> CGPoint {
        return split(point: point, ratio: 0.5)
    }
    
    func areaSize(point: CGPoint) -> CGSize {
        return CGSize(width: abs(self.x - point.x), height: abs(self.y - point.y))
    }
    
    func area(point: CGPoint) -> CGFloat {
        let size = areaSize(point: point)
        return size.width * size.height
    }
    
    func toSize() -> CGSize {
        return CGSize(width: self.x, height: self.y)
    }
    
}
