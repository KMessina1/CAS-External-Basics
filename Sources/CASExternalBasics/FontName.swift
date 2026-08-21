/*-------------------------------------------------------------------------------------------------------------------------
     File: FontName.swift
   Author: Kevin Messina
  Created: 4/18/20
 Modified: 08/21/2026 01:54 PM EDT
  Version: 1
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation

public struct FontName: RawRepresentable {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public enum CourierNew: String {
        case regular = "CourierNewPSMT"
        case italic = "CourierNewPS-ItalicMT"

        public enum Bold: String {
            case regular = "CourierNewPS-BoldMT"
            case italic = "CourierNewPS-ItalicMT"
        }
    }
}
