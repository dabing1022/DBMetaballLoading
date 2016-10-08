//
//  ViewController.swift
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

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingView: DBMetaballLoadingView!
    
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var styleSwitcher: UISwitch!
    
    @IBOutlet weak var fillColorLabel: UILabel!
    @IBOutlet weak var fillColorSlider: UISlider!
    
    @IBOutlet weak var strokeColorLabel: UILabel!
    @IBOutlet weak var strokeColorSlider: UISlider!
    
    @IBOutlet weak var ballRadiusLabel: UILabel!
    @IBOutlet weak var ballRadiusSlider: UISlider!
    
    @IBOutlet weak var maxDistanceLabel: UILabel!
    @IBOutlet weak var maxDistanceSlider: UISlider!
    
    @IBOutlet weak var mvLabel: UILabel!
    @IBOutlet weak var mvSlider: UISlider!
    
    
    @IBOutlet weak var handleLenRateLabel: UILabel!
    @IBOutlet weak var handleLenRateSlider: UISlider!
    
    @IBOutlet weak var spacingLabel: UILabel!
    @IBOutlet weak var spacingSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.0, green: 26.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
        self.title = "DBMetaballLoading"
        
        strokeColorSlider.value = 0.0
        changeStrokeColor(strokeColorSlider)
        
        fillColorSlider.value = 0.0
        changeFillColor(fillColorSlider)
        
        changeBallRadius(ballRadiusSlider)
        changeMaxDistance(maxDistanceSlider)
        changeMv(mvSlider)
        changeHandleLenRate(handleLenRateSlider)
        changeSpacing(spacingSlider)
    }
    
    @IBAction func switchLoadingViewStyle(_ sender: UISwitch) {
        if sender.isOn {
            styleLabel.text = "loadingStyle: Fill"
            loadingView.loadingStyle = .Fill
        } else {
            styleLabel.text = "loadingStyle: Stroke"
            loadingView.loadingStyle = .Stroke
        }
    }
    
    @IBAction func changeFillColor(_ sender: UISlider) {
        styleSwitcher.setOn(true, animated: true)
        switchLoadingViewStyle(styleSwitcher)
        
        fillColorLabel.textColor = _colorByIndex(index: NSInteger(sender.value))
        loadingView.fillColor = fillColorLabel.textColor
        sender.minimumTrackTintColor = fillColorLabel.textColor
        sender.thumbTintColor = fillColorLabel.textColor
    }
    
    @IBAction func changeStrokeColor(_ sender: UISlider) {
        styleSwitcher.setOn(false, animated: true)
        switchLoadingViewStyle(styleSwitcher)
        
        strokeColorLabel.textColor = _colorByIndex(index: NSInteger(sender.value))
        loadingView.strokeColor = strokeColorLabel.textColor
        sender.minimumTrackTintColor = strokeColorLabel.textColor
        sender.thumbTintColor = strokeColorLabel.textColor
    }
    
    @IBAction func changeBallRadius(_ sender: UISlider) {
        ballRadiusLabel.text = String(format: "ballRadius %.2f", sender.value)
        loadingView.ballRadius = CGFloat(sender.value)
        loadingView.resetAnimation()
        
        maxDistanceSlider.minimumValue = ballRadiusSlider.minimumValue * 4
        maxDistanceSlider.maximumValue = ballRadiusSlider.maximumValue * 4
    }
    
    @IBAction func changeMaxDistance(_ sender: UISlider) {
        maxDistanceLabel.text = String(format: "maxDistance %.2f", sender.value)
        loadingView.maxDistance = CGFloat(sender.value)
        loadingView.resetAnimation()
    }
    
    @IBAction func changeMv(_ sender: UISlider) {
        styleSwitcher.setOn(false, animated: true)
        switchLoadingViewStyle(styleSwitcher)
        
        mvLabel.text = String(format: "curveAngle: %.2f", sender.value)
        loadingView.curveAngle = CGFloat(sender.value)
        loadingView.resetAnimation()
    }
    
    @IBAction func changeHandleLenRate(_ sender: UISlider) {
        styleSwitcher.setOn(false, animated: true)
        switchLoadingViewStyle(styleSwitcher)
        
        handleLenRateLabel.text = String(format: "hanleLenRate: %.2f", sender.value)
        loadingView.handleLenRate = CGFloat(sender.value)
        loadingView.resetAnimation()
    }
    
    @IBAction func changeSpacing(_ sender: UISlider) {
        spacingLabel.text = String(format: "spacing: %.2f", sender.value)
        loadingView.spacing = CGFloat(sender.value)
        loadingView.resetAnimation()
    }
    
    @IBAction func resetConfig(sender: UIButton) {
        strokeColorSlider.value = 0.0
        changeStrokeColor(strokeColorSlider)
        
        fillColorSlider.value = 0.0
        changeFillColor(fillColorSlider)
        
        ballRadiusSlider.value = Float(DefaultConfig.radius)
        changeBallRadius(ballRadiusSlider)
        
        maxDistanceSlider.value = Float(DefaultConfig.maxDistance)
        changeMaxDistance(maxDistanceSlider)
        
        mvSlider.value = Float(DefaultConfig.curveAngle)
        changeMv(mvSlider)
        
        handleLenRateSlider.value = Float(DefaultConfig.handleLenRate)
        changeHandleLenRate(handleLenRateSlider)
        
        spacingSlider.value = Float(DefaultConfig.spacing)
        changeSpacing(spacingSlider)
    }
    
    func _colorByIndex(index: NSInteger) -> UIColor {
        var color = UIColor.black
        switch index {
        case 0:
            color = UIColor.orange
            break
        case 1:
            color = UIColor.yellow
            break
        case 2:
            color = UIColor.green
            break
        case 3:
            color = UIColor.cyan
            break
        case 4:
            color = UIColor.red
            break
        default:
            color = UIColor.blue
        }
        
        return color
    }
}

