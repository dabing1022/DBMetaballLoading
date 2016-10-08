# DBMetaballLoading

[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)]()
![Support](https://img.shields.io/badge/support-iOS8%2B-brightgreen.svg)
[![Blog](https://img.shields.io/badge/blog-http%3A%2F%2Fdabing1022.github.io-blue.svg)](http://dabing1022.github.io)

# Synopsis

A metaball loading written in Swift.

Special thanks to [dodola](https://github.com/dodola)'s [MetaballLoading](https://github.com/dodola/MetaballLoading), which is an android project. The animation is awesome! So I implement it in Swift, DBMetaballLoading's core algorithm is referenced by it's core algorithm.

# Preview

![DBMetaballLoading](http://7u2lyz.com1.z0.glb.clouddn.com/DBMetaballLoadingDemo.gif)

# Usage Example

``` swift
let loadingView = DBMetaballLoadingView(frame: CGRect(x: 0, y: 100, width: 404, height: 50))
self.view.addSubview(loadingView)
```

# Customizations

* fillColor: UIColor
* strokeColor: UIColor
* ballRadius: CGFloat
* maxDistance: CGFloat
* curveAngle: CGFloat
* handleLenRate: CGFloat
* spacing: spacing

## Installation

#### CocoaPods
You can use CocoaPods to install `DBMetaballLoading` by adding it to your `Podfile`:

```
platform :ios, '8.0'
use_frameworks!
pod 'DBMetaballLoading'
```

#### Manually

1. Download and drop ```DBMetaballLoading/Source```folder in your project.  
2. Congratulations!  

# Requirements

- iOS8+
- Swift3.0

# Contribution

Please let me know if you like the library, or have any suggestions:]. I plan to maintain this library regularly. Any pull requests are welcome!

# License

DBMetaballLoading is available under the MIT license. See the LICENSE file for more info.
