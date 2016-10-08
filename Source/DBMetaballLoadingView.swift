//
//  DBMetaballLoadingView.swift
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

class DBMetaballLoadingView: UIView {
    var loadingAnimation: CABasicAnimation?
    var loadingStyle: LoadingStyle = .Fill {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).loadingStyle = loadingStyle
        }
    }
    var fillColor: UIColor = DefaultConfig.fillColor {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).fillColor = fillColor
        }
    }
    
    var strokeColor: UIColor = DefaultConfig.strokeColor {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).strokeColor = strokeColor
        }
    }
    
    var ballRadius: CGFloat = DefaultConfig.radius {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).radius = ballRadius
        }
    }
    
    var maxDistance: CGFloat = DefaultConfig.maxDistance {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).maxDistance = maxDistance
        }
    }
    
    var mv: CGFloat = DefaultConfig.mv {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).mv = mv
        }
    }
    
    var handleLenRate: CGFloat = DefaultConfig.handleLenRate {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).handleLenRate = handleLenRate
        }
    }
    
    var spacing: CGFloat = DefaultConfig.spacing {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).spacing = spacing
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        _generalInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _generalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _generalInit()
    }
    
    func _generalInit() {
        self.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(resumeAnimation), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseAnimation), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)

        startAnimation()
    }
    
    override class var layerClass : AnyClass {
        return DBMetaballLoadingLayer.self
    }
    
    func startAnimation() {
        let loadingLayer = self.layer as! DBMetaballLoadingLayer
        loadingAnimation = CABasicAnimation(keyPath: "movingBallCenterX")
        loadingAnimation!.duration = 2.5
        loadingAnimation!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        loadingAnimation!.fromValue = NSNumber(value: Float(loadingLayer.radius))
        loadingAnimation!.toValue = NSNumber(value: Float(loadingLayer.maxLength - loadingLayer.radius))
        loadingAnimation!.repeatCount = Float.infinity
        loadingAnimation!.autoreverses = true
        loadingLayer.add(loadingAnimation!, forKey: "loading")
    }
    
    func resetAnimation() {
        self.layer.removeAnimation(forKey: "loading")
        startAnimation()
    }
    
    func resumeAnimation() {
        if let animation = loadingAnimation {
            self.layer.add(animation, forKey: "loading")
        }
        resumeLayer(layer: self.layer)
    }
    
    func pauseAnimation() {
        loadingAnimation = self.layer.animation(forKey: "loading")?.copy() as? CABasicAnimation
        pauseLayer(layer: self.layer)
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
}
