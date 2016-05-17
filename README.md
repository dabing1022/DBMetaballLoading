# DBMetaballLoading

[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)]()
![Support](https://img.shields.io/badge/support-iOS8%2B-brightgreen.svg)
[![Blog](https://img.shields.io/badge/blog-http%3A%2F%2Fdabing1022.github.io-blue.svg)](http://dabing1022.github.io)

# Synopsis

A metaball loading written in Swift.

Special thanks to [dodola](https://github.com/dodola)'s [MetaballLoading](https://github.com/dodola/MetaballLoading), which is an android project. The animation is awesome! So I implement it in Swift, DBMetaballLoading's core algorithm is referenced by it's core algorithm.

# PreView

![DBMetaballLoading](http://7u2lyz.com1.z0.glb.clouddn.com/DBMetaballLoading.gif)

# Code Example

You can init a metaball loading view by `init(frame: CGRect)` or make an instance from `xib`/`storyboard`. Then there are several options you could config.

```swift
···
loadingView.fillColor = ..
loadingView.strokeColor = ..
loadingView.ballRadius = ..
loadingView.maxDistance = ..
loadingView.mv = ..
loadingView.handleRate = ..
laodingView.spacing = ..
```

These options all have default values. You can change them to satifiy your requirements. Please check demo to see more info.

# Requirements

- iOS8+
- Swift2.0+

# Contribution

Please let me know if you like the library, or have any suggestions:]. I plan to maintain this library regularly. Any pull requests are welcome!

# License

DBMetaballLoading is available under the MIT license. See the LICENSE file for more info.
