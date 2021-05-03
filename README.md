# SwiftUIWavyRectangleShape

<!-- Header Logo -->

<div align="center">
   <img width="600px" src="./Extras/banner-logo.png" alt="Banner Logo">
</div>


<!-- Badges -->

<p>
    <img src="https://img.shields.io/badge/iOS-14.0+-865EFC.svg" />
    <img src="https://img.shields.io/badge/iPadOS-14.0+-F65EFC.svg" />
    <img src="https://img.shields.io/badge/macOS-11.0+-179AC8.svg" />
    <img src="https://img.shields.io/badge/tvOS-14.0+-41465B.svg" />
    <img src="https://img.shields.io/badge/watchOS-7.0+-1FD67A.svg" />
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" />
    <img src="https://github.com/CypherPoet/SwiftUIWavyRectangleShape/workflows/Build%20&%20Test/badge.svg" />
    <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" />
    </a>
    <a href="https://twitter.com/cypher_poet">
        <img src="https://img.shields.io/badge/Contact-@cypher_poet-lightgrey.svg?style=flat" alt="Twitter: @cypher_poet" />
    </a>
</p>


<p align="center">

_An animatable SwiftUI Shape for drawing a rectangle with curved sine wave along the bottom_.

<p />


<!-- ## Features

- ✅ Feature 1
- ✅ Feature 2
 -->

## Installation

### Xcode Projects

Select `File` -> `Swift Packages` -> `Add Package Dependency` and enter `https://github.com/CypherPoet/SwiftUIWavyRectangleShape`.


### Swift Package Manager Projects

You can add `SwiftUIWavyRectangleShape` as a package dependency in your `Package.swift` file:

```swift
let package = Package(
    //...
    dependencies: [
        .package(
          url: "https://github.com/CypherPoet/SwiftUIWavyRectangleShape",
          .upToNextMinor(from: "0.1.0")
        ),
    ],
    //...
)
```

From there, refer to `SwiftUIWavyRectangleShape` as a "target dependency" in any of _your_ package's targets that need it.

```swift
targets: [
    .target(
        name: "YourLibrary",
        dependencies: [
          "SwiftUIWavyRectangleShape",
        ],
        ...
    ),
    ...
]
```

Then simply `import SwiftUIWavyRectangleShape` wherever you’d like to use it.


## Usage

Importing `SwiftUIWavyRectangleShape` will expose the `WavyRectangle` type.

```swift
  WavyRectangle(
      phase: .radians(.pi / 6.0),
      amplitudeRatio: 0.3,
      frequency: 30
  )
  .fill(Color.pink)
```

`WavyRectangle` documentation can be found [here](https://cypherpoet.github.io/SwiftUIWavyRectangleShape/), and this project's [example app](https://github.com/CypherPoet/SwiftUIWavyRectangleShape/tree/main/Examples/WavyRectangleShapeDemo) contains a demonstration of more ways to use it.


<div align="center">
   <img height="500px" src="./Extras/recording-1.gif" alt="Demo Recording">
</div>

## Contributing

Contributions to `SwiftUIWavyRectangleShape` are most welcome. Check out some of the [issue templates](./.github/ISSUE_TEMPLATE/) for more info.



## 💻 Developing

### Requirements

- Xcode 12.5+ (Recommended)


### 📜 Generating Documentation

Documentation is generated by [Jazzy](https://github.com/realm/jazzy). Installation instructions can be found [here](https://github.com/realm/jazzy#installation), and as soon as you have it set up, docs can be generated simply by running `jazzy` from the command line.

📝 Note that this will only generate the `docs` folder for you to view locally. This folder is being ignored by `git`, as an [action](./.github/workflows/PublishDocumentation.yml) exists to automatically generate docs at the root level and serve them on the project's `gh-pages` branch.


## 🏷 License

`SwiftUIWavyRectangleShape` is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.
