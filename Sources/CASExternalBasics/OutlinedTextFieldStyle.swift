/*-------------------------------------------------------------------------------------------------------------------------
     File: OutlinedTextFieldStyle.swift
   Author: Kevin Messina
  Created: 3/23/24
 Modified: 08/21/2026 01:48 PM EDT
  Version: 1
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI

public struct OutlinedTextFieldStyle: TextFieldStyle {
    public let borderColor: Color
    public let corner: CGFloat
    public let lineWidth: CGFloat

    public init(borderColor: Color, corner: CGFloat, lineWidth: CGFloat) {
        self.borderColor = borderColor
        self.corner = corner
        self.lineWidth = lineWidth
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.all, 7)
            .cornerRadius(corner)
            .overlay {
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(borderColor, lineWidth: lineWidth, antialiased: true)
            }
    }
}
