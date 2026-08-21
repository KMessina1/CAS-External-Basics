/*-------------------------------------------------------------------------------------------------------------------------
     File: ToolbarItems.swift
   Author: Kevin Messina
  Created: 10/9/25
 Modified: 08/21/2026 03:23 PM EDT
  Version: 5
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.

©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import UIKit

@available(iOS 26.0, *)
public typealias TB = ToolbarItemViews

public enum ToolbarThemeStorage {
    static let buttonColorKey = "CASExternalBasics.Toolbar.buttonColor"
    static let titleColorKey = "CASExternalBasics.Toolbar.titleColor"
    static let defaultButtonRGBA = "007AFFA8"
    static let defaultTitleRGBA = "FFFFFFFF"

    public static func saveButtonColor(_ color: Color) {
        save(color, forKey: buttonColorKey)
    }

    public static func saveTitleColor(_ color: Color) {
        save(color, forKey: titleColorKey)
    }

    private static func save(_ color: Color, forKey key: String) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return
        }

        let rgba = String(
            format: "%02X%02X%02X%02X",
            Int(round(red * 255)),
            Int(round(green * 255)),
            Int(round(blue * 255)),
            Int(round(alpha * 255))
        )
        UserDefaults.standard.set(rgba, forKey: key)
    }

    static func color(from rgba: String) -> Color {
        let value = UInt64(rgba, radix: 16) ?? 0x007AFFA8

        return Color(
            .sRGB,
            red: Double((value >> 24) & 0xFF) / 255,
            green: Double((value >> 16) & 0xFF) / 255,
            blue: Double((value >> 8) & 0xFF) / 255,
            opacity: Double(value & 0xFF) / 255
        )
    }
}

@available(iOS 26.0, *)
public struct ToolbarItemViews {
    public init() {
    }

    public enum iconNames: Int, CaseIterable, Identifiable {
        case add
        case barcode
        case cancel
        case close
        case info
        case menu
        case reorder
        case save
        case setting
        case share
        case textSize
        case closeAll

        public var id: Int { rawValue }

        public var name: String {
            switch self {
            case .add: return "plus"
            case .barcode: return "barcode.viewfinder"
            case .cancel: return "chevron.left"
            case .close: return "x.circle"
            case .closeAll: return "platter.filled.top.and.arrow.up.iphone"
            case .info: return "info"
            case .menu: return "line.3.horizontal"
            case .reorder: return "arrow.up.and.down.text.horizontal"
            case .save: return "checkmark"
            case .setting: return "gear"
            case .share: return "square.and.arrow.up"
            case .textSize: return "textformat.size"
            }
        }
    }

    public enum tintColorNames: Int, CaseIterable, Identifiable {
        case red
        case green
        case blue
        case orange
        case theme
        case clear

        public var id: Int { rawValue }

        public var buttonColor: Color {
            switch self {
            case .red:
                return Color(.displayP3, red: 0.611, green: 0.198, blue: 0.191)
            case .green:
                return Color(.sRGB, red: 0.206, green: 0.557, blue: 0.341)
            case .blue:
                return Color(.sRGB, red: 0.093, green: 0.160, blue: 0.759)
            case .orange:
                return Color(.displayP3, red: 0.600, green: 0.349, blue: 0.126)
            case .theme:
                return .accentColor.opacity(0.66)
            case .clear:
                return .clear
            }
        }

        public func resolvedButtonColor(themeColor: Color) -> Color {
            self == .theme ? themeColor : buttonColor
        }
    }

    public func buttonImg(_ imgName: iconNames, color: Color = .white) -> some View {
        Image(systemName: imgName.name)
            .foregroundStyle(color)
    }

    public struct buttonColor: ViewModifier {
        @AppStorage(ToolbarThemeStorage.buttonColorKey)
        private var storedToolbarButtonColor = ToolbarThemeStorage.defaultButtonRGBA

        public let color: tintColorNames

        public init(color: tintColorNames) {
            self.color = color
        }

        public func body(content: Content) -> some View {
            content
                .buttonStyle(.glassProminent)
                .tint(
                    color.resolvedButtonColor(
                        themeColor: ToolbarThemeStorage.color(from: storedToolbarButtonColor)
                    )
                )
        }
    }

    public struct glassButtonColor: ViewModifier {
        @AppStorage(ToolbarThemeStorage.buttonColorKey)
        private var storedToolbarButtonColor = ToolbarThemeStorage.defaultButtonRGBA

        public var color: tintColorNames
        public var padding: CGFloat
        public var opacity: CGFloat

        public init(
            color: tintColorNames,
            padding: CGFloat = 15,
            opacity: CGFloat = 0.3
        ) {
            self.color = color
            self.padding = padding
            self.opacity = opacity
        }

        public func body(content: Content) -> some View {
            content
                .padding(.all, padding)
                .glassEffect(
                    color == .clear
                        ? .clear
                        : .regular.tint(
                            color.resolvedButtonColor(
                                themeColor: ToolbarThemeStorage.color(from: storedToolbarButtonColor)
                            ).opacity(opacity)
                        )
                )
        }
    }

    public func title(_ title: String) -> some ToolbarContent {
        ToolbarItem(placement: .title) {
            ToolbarTitleText(title: title, isSubtitle: false)
        }
    }

    public func subtitle(_ title: String) -> some ToolbarContent {
        ToolbarItem(placement: .subtitle) {
            ToolbarTitleText(title: title, isSubtitle: true)
        }
    }

    public func recordIDSubtitle(id: Int64) -> some ToolbarContent {
        ToolbarItem(placement: .subtitle) {
            HStack(spacing: 0) {
                Text("Record ").font(.headline)
                Image(systemName: "key.horizontal.fill")
                Text(": \(id)").font(.headline)
            }
            .foregroundStyle(.pink)
            .fontWeight(.light)
            .fontWidth(.condensed)
        }
    }

    private struct ToolbarTitleText: View {
        @AppStorage(ToolbarThemeStorage.titleColorKey)
        private var storedToolbarTitleColor = ToolbarThemeStorage.defaultTitleRGBA

        let title: String
        let isSubtitle: Bool

        var body: some View {
            Text(isSubtitle ? title : title.uppercased())
                .fontWeight(isSubtitle ? .light : .regular)
                .fontWidth(.condensed)
                .foregroundStyle(
                    ToolbarThemeStorage.color(from: storedToolbarTitleColor)
                )
        }
    }
}
