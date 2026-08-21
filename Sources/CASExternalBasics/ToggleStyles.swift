/*-------------------------------------------------------------------------------------------------------------------------
     File: ToggleStyles.swift
   Author: Kevin Messina
  Created: 5/24/24
 Modified: 08/21/2026 04:02 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI

public final class ToggleStyle {
    private init() {
    }

    public struct Checkbox: SwiftUI.ToggleStyle {
        public var size: CGFloat
        public var showXForOff: Bool
        public var textColor: Color
        public var onColor: Color
        public var offColor: Color

        public init(
            size: CGFloat = 22,
            showXForOff: Bool = false,
            textColor: Color = .orange,
            onColor: Color = .green,
            offColor: Color = .red
        ) {
            self.size = size
            self.showXForOff = showXForOff
            self.textColor = textColor
            self.onColor = onColor
            self.offColor = offColor
        }

        public func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.label
                    .foregroundStyle(textColor)

                ZStack {
                    Image(systemName: "square")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(textColor)
                        .frame(width: size, height: size)
                        .onTapGesture { configuration.isOn.toggle() }

                    if configuration.isOn || showXForOff {
                        Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(configuration.isOn ? onColor : offColor)
                            .bold()
                            .frame(width: size - 10, height: size - 10)
                            .onTapGesture { configuration.isOn.toggle() }
                    }
                }
            }
        }
    }

    public struct SwitchStyle: SwiftUI.ToggleStyle {
        public let onColor: Color
        public let offColor: Color
        public let thumbColor: Color
        public let thumbImgColor: Color
        public let thumbImgShow: Bool
        public let showTitle: Bool

        public init(
            onColor: Color,
            offColor: Color,
            thumbColor: Color,
            thumbImgColor: Color,
            thumbImgShow: Bool,
            showTitle: Bool
        ) {
            self.onColor = onColor
            self.offColor = offColor
            self.thumbColor = thumbColor
            self.thumbImgColor = thumbImgColor
            self.thumbImgShow = thumbImgShow
            self.showTitle = showTitle
        }

        public func makeBody(configuration: Configuration) -> some View {
            HStack {
                if showTitle {
                    configuration.label
                        .font(.body)
                    Spacer()
                }

                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 46, height: 26)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(4)
                            .overlay(
                                Image(
                                    systemName: configuration.isOn
                                        ? thumbImgShow ? "checkmark.circle" : ""
                                        : thumbImgShow ? "xmark.circle" : ""
                                )
                                .foregroundStyle(thumbImgColor)
                            )
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn.toggle()
                        }
                    }
            }
        }
    }

    public struct SwitchAndCheckbox: View {
        @State private var isOn: Bool
        @State private var title1: String
        @State private var title2: String

        public init(
            isOn: Bool = false,
            title1: String = "Default Toggle with Tint",
            title2: String = "Don't show this tip again."
        ) {
            _isOn = State(initialValue: isOn)
            _title1 = State(initialValue: title1)
            _title2 = State(initialValue: title2)
        }

        public var body: some View {
            VStack {
                Toggle("Example Toggle", isOn: $isOn)
                    .toggleStyle(
                        SwitchStyle(
                            onColor: .green,
                            offColor: .red,
                            thumbColor: .orange,
                            thumbImgColor: .white,
                            thumbImgShow: true,
                            showTitle: true
                        )
                    )

                Toggle(title1, isOn: $isOn)
                    .tint(.yellow)

                Toggle(title2, isOn: $isOn)
                    .toggleStyle(Checkbox(size: 30))
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.red)
            }
            .padding()
        }
    }
}
