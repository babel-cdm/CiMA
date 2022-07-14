# CiMA

**CiMA** is a library based on MVVM-C architecture.

This way you can create by a very easy and fast way robust and maintenable apps due to **CiMA** support, it handles lots of classes that helps the developer to develop new features respecting the MVVM-C architecture.

You can see the documentation [here](https://github.com/babel-cdm/CiMA/wiki).

## Requirements

* macOS v10.15
* iOS v14.0
* watchOS 6.0
* tvOS 1.0
* Xcode 13.0
* Swift 5.5+

## Installation

### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CiMA into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
pod 'CiMA', '1.0.0'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding CiMA as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/babel-cdm/CiMA.git", .upToNextMajor(from: "1.0.0"))
]
```

## License

CiMA-Architecture is released under the MIT license. See [LICENSE](LICENSE) for details.
