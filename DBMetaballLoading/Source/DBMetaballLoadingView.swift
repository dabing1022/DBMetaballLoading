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
import GLKit

class DBMetaballLoadingView: UIView {
    var loadingAnimation: CABasicAnimation?
    var loadingStyle: LoadingStyle = .Fill {
        didSet {
            (self.layer as! DBMetaballLoadingLayer).loadingStyle = loadingStyle
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
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
        self.backgroundColor = UIColor.clearColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(resumeAnimation), name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(pauseAnimation), name: UIApplicationDidEnterBackgroundNotification, object: nil)

        startAnimation()
    }
    
    override class func layerClass() -> AnyClass {
        return DBMetaballLoadingLayer.self
    }
    
    func startAnimation() {
        let loadingLayer = self.layer as! DBMetaballLoadingLayer
        loadingAnimation = CABasicAnimation(keyPath: "movingBallCenterX")
        loadingAnimation!.duration = 2.5
        loadingAnimation!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        loadingAnimation!.fromValue = NSNumber(float: Float(loadingLayer.movingBallCenterX))
        loadingAnimation!.toValue = NSNumber(float: Float(loadingLayer.maxLength))
        loadingAnimation!.repeatCount = Float.infinity
        loadingAnimation!.autoreverses = true
        loadingLayer.addAnimation(loadingAnimation!, forKey: "loading")
    }
    
    func resumeAnimation() {
        if let animation = loadingAnimation {
            self.layer.addAnimation(animation, forKey: "loading")
        }
        resumeLayer(self.layer)
    }
    
    func pauseAnimation() {
        loadingAnimation = self.layer.animationForKey("loading")?.copy() as? CABasicAnimation
        pauseLayer(self.layer)
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime = layer .convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
}
