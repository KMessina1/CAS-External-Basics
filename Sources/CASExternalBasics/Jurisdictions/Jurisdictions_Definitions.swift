/*-------------------------------------------------------------------------------------------------------------------------
     File: Jurisdictions_Definitions.swift
   Author: Kevin Messina
  Created: 2/18/24
 Modified: 08/24/2026 05:13 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import SwiftUI

extension Jurisdictions {
    // MARK: - *** JURISDICTION STRUCTS ***
    public enum Juristype: String, Identifiable, CaseIterable {
        case state = "State"
        case province = "Province"
        case territory = "Territory"
        case district = "District"
        case outlyingTerritories = "Outlying Territories"
        case freeStates = "Free States"
        case militaryMailCode = "Military Mail Code"
        case minorTerritory = "Minor Territory"
        case provincialTerritory = "Provincial Territory"
        case country = "Country"
        case unknown = "Unknown"
        
        public var id: String { self.rawValue }
    }

    public enum JurisRegion: String, Identifiable, CaseIterable {
        case continental = "Continental"
        case nonContiguous = "Non-Contiguous"
        case possession = "Posession"
        case military = "Military"
        case country = "Country"
        case unknown = "Unknown"
        
        public var id: String { self.rawValue }
    }

    // MARK: --> *** Continents ***
    public enum Continents: String, Identifiable, CaseIterable {
        case africa = "Africa"
        case antarctica = "Antarctica"
        case asia = "Asia"
        case australia = "Australia"
        case europe = "Europe"
        case northAmerica = "North America"
        case southAmerica = "South America"

        public var id: String { self.rawValue }

        static let all: [String] = [africa.id,antarctica.id,asia.id,australia.id,europe.id,northAmerica.id,southAmerica.id].sorted()
    }

    // MARK: --> *** Seas ***
    public enum Seas: String, Identifiable, CaseIterable {
        case arctic = "Arctic"
        case northAtlantic = "North Atlantic"
        case southAtlantic = "South Atlantic"
        case northPacific = "North Pacific"
        case southPacific = "South Pacific"
        case indian = "Indian"
        case southern = "Southern"
        
        public var id: String { self.rawValue }
        
        static let all: [String] = [arctic.id,northAtlantic.id,southAtlantic.id,northPacific.id,southPacific.id,indian.id,southern.id].sorted()
    }

    // MARK: --> *** Oceans ***
    public enum Oceans: String, Identifiable, CaseIterable {
        case arctic = "Arctic"
        case atlantic = "Atlantic"
        case pacific = "Pacific"
        case indian = "Indian"
        case southern = "Southern"

        public var id: String { self.rawValue }

        static let all: [String] = [arctic.id,atlantic.id,pacific.id,indian.id,southern.id].sorted()
    }


    
}
