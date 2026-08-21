// swift-tools-version: 6.2
/*-------------------------------------------------------------------------------------------------------------------------
     File: Package.swift
   Author: Kevin Messina
  Created: 8/21/26
 Modified: 08/21/2026 06:05 PM EDT
  Version: 7
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.

©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import PackageDescription

let package = Package(
    name: "CAS-External-Basics",
    platforms: [
        .iOS(.v26),
        .macCatalyst(.v26)
    ],
    products: [
        .library(
            name: "CASExternalBasics",
            targets: ["CASExternalBasics"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/KMessina1/CAS-External-Foundations.git",
            from: "1.1.5"
        )
    ],
    targets: [
        .target(
            name: "CASExternalBasics",
            dependencies: [
                .product(
                    name: "CASExternalFoundations",
                    package: "CAS-External-Foundations"
                )
            ]
        ),
        .testTarget(
            name: "CASExternalBasicsTests",
            dependencies: ["CASExternalBasics"]
        )
    ],
    swiftLanguageModes: [.v5]
)
