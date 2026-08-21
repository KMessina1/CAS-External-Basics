# CAS External Basics

Public Swift package for reusable Creative App Solutions standard SwiftUI and UIKit libraries.

## Requirements

- Xcode 26 or later
- Swift 6
- iOS 26 or later
- Mac Catalyst 26 or later

## Add to an Xcode project

In Xcode, choose **File > Add Package Dependencies**, enter the public repository URL below, select the desired version rule, and add the `CASExternalBasics` library product to the required application targets.

```text
https://github.com/KMessina1/CAS-External-Basics.git
```

```swift
import CASExternalBasics
```

No GitHub account or private-repository authentication is required to download this public package.

## Local development

Add this folder as a local package to override the remote dependency while developing the package and an application together. The original `Standard Libraries` folder remains the working source until each library is deliberately migrated into this package.

## License

©2026 Creative App Solutions, LLC. All Rights Reserved. The source is publicly viewable, but no permission to copy, modify, or redistribute it is granted except as expressly authorized by Creative App Solutions, LLC.
