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

class DBMetaballLoadingLayer: CALayer {
    private let MOVE_BALL_SCALE_RATE: CGFloat = 0.75
    private let ITEM_COUNT = 6
    private let SCALE_RATE: CGFloat = 0.3
    private var circlePaths = [DBCircle]()
    
    var radius: CGFloat = DefaultConfig.radius
    var maxLength: CGFloat {
        get {
            return (radius * 2 + spacing) * CGFloat(ITEM_COUNT)
        }
    }
    var maxDistance: CGFloat = DefaultConfig.maxDistance
    var curveAngle: CGFloat = DefaultConfig.curveAngle
    var spacing: CGFloat = DefaultConfig.spacing {
        didSet {
            _adjustSpacing(spacing: spacing)
        }
    }
    var handleLenRate: CGFloat = DefaultConfig.handleLenRate
    
    var fillColor: UIColor = DefaultConfig.fillColor
    var strokeColor: UIColor = DefaultConfig.strokeColor
    var loadingStyle: LoadingStyle = .Fill
    
    var movingBallCenterX : CGFloat = 0.0 {
        didSet {
            if (circlePaths.count > 0) {
                circlePaths[0].center = CGPoint(x: movingBallCenterX, y: circlePaths[0].center.y)
            }
        }
    }
    
    override init() {
        super.init()
        _generalInit()
    }
    
    override init(layer: Any) {
        if let layer = layer as? DBMetaballLoadingLayer {
            movingBallCenterX = layer.movingBallCenterX
            loadingStyle = layer.loadingStyle
            fillColor = layer.fillColor
            strokeColor = layer.strokeColor
            radius = layer.radius
            maxDistance = layer.maxDistance
            curveAngle = layer.curveAngle
            handleLenRate = layer.handleLenRate
            spacing = layer.spacing
        }
        
        super.init(layer: layer)
        _generalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _generalInit()
    }
    
    func _generalInit() {
        circlePaths = Array(0..<ITEM_COUNT).map { i in
            var circlePath = DBCircle()
            circlePath.center = CGPoint(x: (radius * 2 + spacing) * CGFloat(i), y: radius * (1.0 + SCALE_RATE))
            circlePath.radius = i == 0 ? radius * MOVE_BALL_SCALE_RATE : radius
            return circlePath
        }
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if (key == "movingBallCenterX") {
            return true
        }
        
        return super.needsDisplay(forKey: key)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if (event == "movingBallCenterX") {
            let animation = CABasicAnimation(keyPath: event)
            animation.fromValue = self.presentation()?.value(forKey: event)
            
            return animation
        }
        
        return super.action(forKey: event)
    }
    
    override func draw(in ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        
        var movingCircle = circlePaths[0]
        movingCircle.center = CGPoint(x: movingBallCenterX, y: movingCircle.center.y)
        
        _renderPath(path: UIBezierPath(ovalIn: movingCircle.frame))
        for j in 1..<circlePaths.count {
            _metaball(j: j, i: 0, curveAngle: curveAngle, handeLenRate: handleLenRate, maxDistance: maxDistance)
        }
        
        UIGraphicsPopContext()
    }
    
    func _adjustSpacing(spacing: CGFloat) {
        if (ITEM_COUNT > 1 && circlePaths.count > 1) {
            for i in 1..<ITEM_COUNT {
                var circlePath = circlePaths[i]
                circlePath.center = CGPoint(x: (radius * 2 + spacing) * CGFloat(i), y: radius * (1.0 + SCALE_RATE))
            }
        }
    }
    
    func _renderPath(path: UIBezierPath) {
        fillColor.setFill()
        strokeColor.setStroke()
        self.loadingStyle == .Fill ? path.fill() : path.stroke()
    }

    func _metaball(j: Int, i: Int, curveAngle: CGFloat, handeLenRate: CGFloat, maxDistance: CGFloat) {
        let circle1 = circlePaths[i]
        let circle2 = circlePaths[j]
        
        let center1 = circle1.center
        let center2 = circle2.center
        
        let d = center1.distance(point: center2)
        
        var radius1 = circle1.radius
        var radius2 = circle2.radius
        
        if (d > maxDistance) {
            _renderPath(path: UIBezierPath(ovalIn: circle2.frame))
        } else {
            let scale2 = 1 + SCALE_RATE * (1 - d / maxDistance)
            radius2 *= scale2
            _renderPath(path: UIBezierPath(ovalIn: CGRect(x: circle2.center.x - radius2, y: circle2.center.y - radius2, width: 2 * radius2, height: 2 * radius2)))
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
        
        let angle1 = center1.angleBetween(point: center2)
        let angle2 = acos((radius1 - radius2) / d)
        let angle1a = angle1 + u1 + (angle2 - u1) * curveAngle
        let angle1b = angle1 - u1 - (angle2 - u1) * curveAngle
        let angle2a = angle1 + CGFloat(M_PI) - u2 - (CGFloat(M_PI) - u2 - angle2) * curveAngle
        let angle2b = angle1 - CGFloat(M_PI) + u2 + (CGFloat(M_PI) - u2 - angle2) * curveAngle
        
        let p1a = center1.point(radians: angle1a, withLength: radius1)
        let p1b = center1.point(radians: angle1b, withLength: radius1)
        let p2a = center2.point(radians: angle2a, withLength: radius2)
        let p2b = center2.point(radians: angle2b, withLength: radius2)
        
        let totalRadius = radius1 + radius2
        var d2 = min(curveAngle * handeLenRate, p1a.minus(point: p2a).length() / totalRadius)
        d2 *= min(1, d * 2 / totalRadius)
        radius1 *= d2
        radius2 *= d2
        
        let cp1a = p1a.point(radians: angle1a - CGFloat(M_PI_2), withLength: radius1)
        let cp2a = p2a.point(radians: angle2a + CGFloat(M_PI_2), withLength: radius2)
        let cp2b = p2b.point(radians: angle2b - CGFloat(M_PI_2), withLength: radius2)
        let cp1b = p1b.point(radians: angle1b + CGFloat(M_PI_2), withLength: radius1)
        
        let pathJoinedCircles = UIBezierPath()
        pathJoinedCircles.move(to: p1a)
        pathJoinedCircles.addCurve(to: p2a, controlPoint1: cp1a, controlPoint2: cp2a)
        pathJoinedCircles.addLine(to: p2b)
        pathJoinedCircles.addCurve(to: p1b, controlPoint1: cp2b, controlPoint2: cp1b)
        pathJoinedCircles.addLine(to: p1a)
        pathJoinedCircles.close()
        _renderPath(path: pathJoinedCircles)
    }
}
