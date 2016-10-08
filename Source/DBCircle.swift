//
//  DBCircle.swift
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

struct DBCircle {
    var center: CGPoint = CGPoint.zero
    var radius: CGFloat = 0.0
    
    var frame: CGRect {
        get {
            return CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        }
    }
}

struct DefaultConfig {
    static let radius: CGFloat = 15.0
    static let fillColor = UIColor(red: 67.0 / 255.0, green: 182.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    static let strokeColor = UIColor(red: 67.0 / 255.0, green: 182.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    static let mv: CGFloat = 0.6
    static let maxDistance: CGFloat = 4 * DefaultConfig.radius
    static let handleLenRate: CGFloat = 2.0
    static let spacing: CGFloat = 30.0
}
