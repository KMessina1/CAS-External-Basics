// swift-tools-version: 6.2
/*-------------------------------------------------------------------------------------------------------------------------
     File: Package.swift
   Author: Kevin Messina
  Created: 8/21/26
 Modified: 09/05/2026 05:31 AM EDT
  Version: 10
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
        .macCatalyst(.v26),
        .macOS(.v26)
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
        ),
        .package(
            url: "https://github.com/KMessina1/CAS-ThemeSupport.git",
            from: "1.1.1"
        )
    ],
    targets: [
        .target(
            name: "CASExternalBasics",
            dependencies: [
                .product(
                    name: "CASExternalFoundations",
                    package: "CAS-External-Foundations"
                ),
                .product(
                    name: "CASThemeSupport",
                    package: "CAS-ThemeSupport"
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
