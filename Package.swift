// swift-tools-version: 6.0
/*-------------------------------------------------------------------------------------------------------------------------
     File: Package.swift
   Author: Kevin Messina
  Created: 8/21/26
 Modified: 08/21/2026 12:27 PM EDT
  Version: 1
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.

©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import PackageDescription

let package = Package(
    name: "CAS-External-Basics",
    platforms: [
        .iOS(.v17),
        .macCatalyst(.v17)
    ],
    products: [
        .library(
            name: "CASExternalBasics",
            targets: ["CASExternalBasics"]
        )
    ],
    targets: [
        .target(
            name: "CASExternalBasics"
        ),
        .testTarget(
            name: "CASExternalBasicsTests",
            dependencies: ["CASExternalBasics"]
        )
    ],
    swiftLanguageModes: [.v5]
)
