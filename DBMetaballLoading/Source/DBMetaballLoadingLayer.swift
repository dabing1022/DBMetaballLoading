//
//  DBMetaballLoadingLayer.swift
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

import UIKit

enum LoadingStyle {
    case Stroke
    case Fill
}

typealias DBVector2 = CGPoint
class DBMetaballLoadingLayer: CALayer {
    private var ITEM_COUNT = 6
    private let ITEM_DIVIDER: CGFloat = 30.0
    private var radius: CGFloat = 15.0
    private let SCALE_RATE: CGFloat = 0.3
    private var handleLenRate: CGFloat = 2.0
    var maxLength: CGFloat = 0.0
    private var circlePaths = [DBCircle]()
    
    var fillColor: UIColor = UIColor(red: 67.0 / 255.0, green: 182.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    var strokeColor: UIColor = UIColor(red: 67.0 / 255.0, green: 182.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    
    var movingBallCenterX : CGFloat = 0.0 {
        didSet {
            if (circlePaths.count > 0) {
                circlePaths[0].center = CGPoint(x: movingBallCenterX, y: circlePaths[0].center.y)
            }
        }
    }
    
    var loadingStyle: LoadingStyle = .Fill {
        didSet {
            print("loading style :\(self.loadingStyle)")
            setNeedsDisplay()
            displayIfNeeded()
        }
    }
    
    override init() {
        super.init()
        _generalInit()
    }
    
    override init(layer: AnyObject) {
        if let layer = layer as? DBMetaballLoadingLayer {
            movingBallCenterX = layer.movingBallCenterX
        }
        
        super.init(layer: layer)
        _generalInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _generalInit()
    }
    
    func _generalInit() {
        var circlePath = DBCircle()
        circlePath.center = CGPoint(x: radius + ITEM_DIVIDER, y: radius * (1.0 + SCALE_RATE))
        circlePath.radius = radius * 3 / 4
        circlePaths.append(circlePath)
        
        for i in 1..<ITEM_COUNT {
            circlePath = DBCircle()
            circlePath.center = CGPoint(x: (radius * 2 + ITEM_DIVIDER) * CGFloat(i), y: radius * (1.0 + SCALE_RATE))
            circlePath.radius = radius
            circlePaths.append(circlePath)
        }
        maxLength = (radius * 2 + ITEM_DIVIDER) * CGFloat(ITEM_COUNT)
        
        self.allowsEdgeAntialiasing = true
    }

    override class func needsDisplayForKey(key: String) -> Bool {
        if (key == "movingBallCenterX") {
            return true
        }
        
        return super.needsDisplayForKey(key)
    }
    
    override func actionForKey(event: String) -> CAAction? {
        if (event == "movingBallCenterX") {
            let animation = CABasicAnimation(keyPath: event)
            animation.fromValue = self.presentationLayer()?.valueForKey(event)
            
            return animation
        }
        
        return super.actionForKey(event)
    }
    
    override func drawInContext(ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        
        var movingCircle = circlePaths[0]
        movingCircle.center = CGPoint(x: movingBallCenterX, y: movingCircle.center.y)
        
        _renderPath(UIBezierPath(ovalInRect: movingCircle.frame))
        for j in 1..<circlePaths.count {
            _metaball(j, i: 0, v: 0.6, handeLenRate: handleLenRate, maxDistance: radius * 4)
        }
        
        UIGraphicsPopContext()
    }
    
    func _vector2By(radians radians: CGFloat, length: CGFloat) -> DBVector2 {
        return DBVector2(x: length * cos(radians), y: length * sin(radians))
    }
    
    func _distance(point1 point1: CGPoint, point2: CGPoint) -> CGFloat {
        let deltaX = point1.x - point2.x
        let deltaY = point1.y - point2.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
    
    func _length(point: CGPoint) -> CGFloat {
        return sqrt(point.x * point.x + point.y * point.y)
    }
    
    func _renderPath(path: UIBezierPath) {
        fillColor.setFill()
        strokeColor.setStroke()
        self.loadingStyle == .Fill ? path.fill() : path.stroke()
    }

    func _metaball(j: Int, i: Int, v: CGFloat, handeLenRate: CGFloat, maxDistance: CGFloat) {
        let circle1 = circlePaths[i]
        let circle2 = circlePaths[j]
        
        let center1 = circle1.center
        let center2 = circle2.center
        
        let d = _distance(point1: center1, point2: center2)
        
        var radius1 = circle1.radius
        var radius2 = circle2.radius
        
        if (d > maxDistance) {
            _renderPath(UIBezierPath(ovalInRect: circle2.frame))
        } else {
            let scale2 = 1 + SCALE_RATE * (1 - d / maxDistance)
            radius2 *= scale2
            _renderPath(UIBezierPath(ovalInRect: CGRect(x: circle2.center.x - radius2, y: circle2.center.y - radius2, width: 2 * radius2, height: 2 * radius2)))
        }
        
        if (radius1 == 0 || radius2 == 0) {
            return
        }
        
        var u1: CGFloat = 0.0
        var u2: CGFloat = 0.0
        if (d > maxDistance || d <= abs(radius1 - radius2)) {
            return
        } else if (d < radius1 + radius2) {
            u1 = acos((radius1 * radius1 + d * d - radius2 * radius2) / (2 * radius1 * d))
            u2 = acos((radius2 * radius2 + d * d - radius1 * radius1) / (2 * radius2 * d))
        } else {
            u1 = 0.0
            u2 = 0.0
        }
        
        let centerMin = CGPoint(x: center2.x - center1.x, y: center2.y - center1.y)
        
        let angle1 = atan2(centerMin.y, centerMin.x)
        let angle2 = acos((radius1 - radius2) / d)
        let angle1a = angle1 + u1 + (angle2 - u1) * v
        let angle1b = angle1 - u1 - (angle2 - u1) * v
        let angle2a = angle1 + CGFloat(M_PI) - u2 - (CGFloat(M_PI) - u2 - angle2) * v
        let angle2b = angle1 - CGFloat(M_PI) + u2 + (CGFloat(M_PI) - u2 - angle2) * v
        
        let p1a1 = _vector2By(radians: angle1a, length: radius1)
        let p1b1 = _vector2By(radians: angle1b, length: radius1)
        let p2a1 = _vector2By(radians: angle2a, length: radius2)
        let p2b1 = _vector2By(radians: angle2b, length: radius2)
        
        let p1a = CGPoint(x: p1a1.x + center1.x, y: p1a1.y + center1.y)
        let p1b = CGPoint(x: p1b1.x + center1.x, y: p1b1.y + center1.y)
        let p2a = CGPoint(x: p2a1.x + center2.x, y: p2a1.y + center2.y)
        let p2b = CGPoint(x: p2b1.x + center2.x, y: p2b1.y + center2.y)
        
        let p1_p2 = CGPoint(x: p1a.x - p2a.x, y: p1a.y - p2a.y)
        let totalRadius = radius1 + radius2
        var d2 = min(v * handeLenRate, _length(p1_p2) / totalRadius)
        d2 *= min(1, d * 2 / totalRadius)
        radius1 *= d2
        radius2 *= d2
        
        let sp1 = _vector2By(radians: angle1a - CGFloat(M_PI_2), length: radius1)
        let sp2 = _vector2By(radians: angle2a + CGFloat(M_PI_2), length: radius2)
        let sp3 = _vector2By(radians: angle2b - CGFloat(M_PI_2), length: radius2)
        let sp4 = _vector2By(radians: angle1b + CGFloat(M_PI_2), length: radius1)
        
        let pathJoinedCircles = UIBezierPath()
        pathJoinedCircles.moveToPoint(p1a)
        pathJoinedCircles.addCurveToPoint(p2a, controlPoint1: CGPoint(x: p1a.x + sp1.x, y: p1a.y + sp1.y), controlPoint2: CGPoint(x: p2a.x + sp2.x, y: p2a.y + sp2.y))
        pathJoinedCircles.addLineToPoint(p2b)
        pathJoinedCircles.addCurveToPoint(p1b, controlPoint1: CGPoint(x: p2b.x + sp3.x, y:p2b.y + sp3.y), controlPoint2: CGPoint(x: p1b.x + sp4.x, y:p1b.y + sp4.y))
        pathJoinedCircles.addLineToPoint(p1a)
        pathJoinedCircles.closePath()
        _renderPath(pathJoinedCircles)
    }
}
