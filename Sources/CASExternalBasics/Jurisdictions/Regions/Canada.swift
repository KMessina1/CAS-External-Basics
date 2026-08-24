/*-------------------------------------------------------------------------------------------------------------------------
     File: Canada.swift
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
    public struct Canada {
        public static let all:[JS] = (Provinces.all + Territories.all).sorted(by: { ($0.name < $1.name) })
        
        public struct Provinces {
            public static let Alberta:JS = JS(
                name:"Alberta",
                code:"AB",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let BritishColumbia:JS = JS(
                name:"British Columbia",
                code:"BC",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let Manitoba:JS = JS(
                name:"Manitoba",
                code:"MB",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let NewBrunswick:JS = JS(
                name:"New Brunswick",
                code:"NB",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let NewfoundlandAndLabrador:JS = JS(
                name:"Newfoundland and Labrador",
                code:"NL",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let NovaScotia:JS = JS(
                name:"Nova Scotia",
                code:"NS",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let Nunavut:JS = JS(
                name:"Nunavut",
                code:"NU",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let Ontario:JS = JS(
                name:"Ontario",
                code:"ON",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let PrinceEdwardIsland:JS = JS(
                name:"Prince Edward Island",
                code:"PE",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let Quebec:JS = JS(
                name:"Quebec",
                code:"QC",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let Saskatchewan:JS = JS(
                name:"Saskatchewan",
                code:"SK",
                country:"Canada",
                type:.province,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            
            public static let all:[JS] =
                [Alberta,BritishColumbia,Manitoba,NewBrunswick,NewfoundlandAndLabrador,NovaScotia,Nunavut,Ontario,PrinceEdwardIsland,Quebec]
                .sorted(by: { ($0.name < $1.name) })
        }
        
        public struct Territories {
            public static let Northwest:JS = JS(
                name:"Northwest Territories",
                code:"NT",
                country:"Canada",
                type:.provincialTerritory,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )
            public static let Yukon:JS = JS(
                name:"Yukon Territory",
                code:"YT",
                country:"Canada",
                type:.provincialTerritory,
                region:.country,
                flagImgName:"Canada",
                currency:"Canadian Dollar",
                currencyCode:"CD",
                currencySymbol:"$"
            )

            public static let all:[JS] =
                [Northwest,Yukon]
                .sorted(by: { ($0.name < $1.name) })
        }
        
        public func arrNames(jurisdictions: [JS]) -> [String] {
            var provinces:[String] = []
            
            jurisdictions.forEach { (provinceStruct) in
                provinces.append( provinceStruct.name )
            }
            
            return provinces.sorted()
        }
    }
}
