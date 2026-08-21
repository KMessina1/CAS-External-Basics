/*-------------------------------------------------------------------------------------------------------------------------
     File: CircularProgressView.swift
   Author: Kevin Messina
  Created: 1/19/25
 Modified: 08/21/2026 03:36 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI

public struct CircularProgressView: View {
    @Binding public var progress: Double
    public let size: CGFloat
    public let color: Color
    public let text: String

    public init(
        progress: Binding<Double>,
        size: CGFloat,
        color: Color,
        text: String
    ) {
        _progress = progress
        self.size = size
        self.color = color
        self.text = text
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.white.opacity(0.33), lineWidth: 2)
                }

            Circle()
                .stroke(color.opacity(0.33), lineWidth: 12)
                .frame(width: size - 35, height: size - 35)

            Circle()
                .trim(from: 0, to: min(max(progress, 0), 1))
                .stroke(
                    color.gradient,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)
                .frame(width: size - 35, height: size - 35)

            Text(text)
                .frame(width: size - 75, height: size - 75)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .minimumScaleFactor(0.25)
        }
        .frame(width: size, height: size)
    }
}
