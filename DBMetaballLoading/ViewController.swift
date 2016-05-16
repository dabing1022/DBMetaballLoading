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
    var loadingView: DBMetaballLoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.0, green: 26.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
        
        let screenBounds = UIScreen.mainScreen().bounds
        let loadingView = DBMetaballLoadingView(frame: CGRect(x: 20, y: 100, width: screenBounds.size.width - 40, height: 200))
        loadingView.layer.borderColor = UIColor.redColor().CGColor
        loadingView.layer.borderWidth = 1.0
        self.view.addSubview(loadingView)
        self.loadingView = loadingView
        
        let styleSwitcher = UISwitch(frame: CGRect(x: 0, y: CGRectGetMaxY(loadingView.frame) + 50, width: 100, height: 50))
        styleSwitcher.center = CGPoint(x: screenBounds.size.width * 0.5, y: styleSwitcher.center.y)
        self.view.addSubview(styleSwitcher)
        styleSwitcher.on = true
        styleSwitcher.addTarget(self, action: #selector(switchLoadingViewStyle), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func switchLoadingViewStyle(switcher: UISwitch) {
        if switcher.on {
            swithMetaballLoadingStyle(.Fill)
        } else {
            swithMetaballLoadingStyle(.Stroke)
        }
    }
    
    func swithMetaballLoadingStyle(style: LoadingStyle) {
        loadingView?.loadingStyle = style
    }
}

