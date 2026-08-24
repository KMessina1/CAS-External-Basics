/*-------------------------------------------------------------------------------------------------------------------------
     File: Jurisdictions_Structs.swift
   Author: Kevin Messina
  Created: 8/24/26
 Modified: 08/24/2026 05:13 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation

extension Jurisdictions {
    public struct JurisdictionStruct {
        public var name:String!
        public var code:String!
        public var country:String!
        public var type:Juristype!
        public var region:JurisRegion!
        public var flagImgName:String!
        public var currency:String!
        public var currencyCode:String!
        public var currencySymbol:String!
        public var codeISO:String!

        public init(
            name:String? = "",
            code:String? = "",
            country:String? = "",
            type:Juristype? = Juristype.country,
            region:JurisRegion = JurisRegion.country,
            flagImgName:String? = "",
            currency:String? = "",
            currencyCode:String? = "",
            currencySymbol:String? = "",
            codeISO:String? = ""
        ){
            self.name = name
            self.code = code
            self.country = country
            self.type = type
            self.region = region
            self.flagImgName = flagImgName
            self.currency = currency
            self.currencyCode = currencyCode
            self.currencySymbol = currencySymbol
            self.codeISO = codeISO!
        }
    }
}
