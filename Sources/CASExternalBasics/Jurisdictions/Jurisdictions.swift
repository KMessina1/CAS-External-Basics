/*-------------------------------------------------------------------------------------------------------------------------
     File: Jurisdictions.swift
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

// MARK: - *** FUNCTIONS ***
public extension String {
    // MARK: Format Strings to Address
    public func formatAsAddress(
        address1:String,
        address2:String,
        city:String,
        state:String,
        zip:String,
        country:String,
        abbrevState:Bool,
        abbrevCountry:Bool = false
    ) -> (
        singleLine:String,
        doubleLine:String,
        multipleLine:String
    ) {
        var address_single:String = ""
        var address_double:String = ""
        var address_multiple:String = ""
        
        let stateCode:String = ((state.count > 2) && abbrevState) ?Jurisdictions().returnStateCodeFor(state, jurisdictions:Jurisdictions.US.States_DC_AllTerritories_ArmedForces).code :state
        let countryCode:String = ((country.count > 2) && abbrevCountry) ?Jurisdictions().returnCodeForCountryName(country).code :country
        
        //Single
        if !address1.isEmpty { address_single += "\( address1 )" }
        if !address2.isEmpty { address_single += " \( address2 )" }
        if !city.isEmpty { address_single += " \( city )," }
        if !state.isEmpty { address_single += " \( stateCode )" }
        if !zip.isEmpty { address_single += " \( zip )" }
        if !country.isEmpty { address_single += " \( countryCode )" }
        
        //Double
        if !address1.isEmpty { address_double += "\( address1 )" }
        if !address2.isEmpty { address_double += " ・ \( address2 ) " }
        if !city.isEmpty { address_double += "\n\( city ), " }
        if !state.isEmpty { address_double += "\( stateCode ) " }
        if !zip.isEmpty { address_double += "\( zip ) " }
        if !country.isEmpty { address_double += "\( countryCode )" }
        
        //Multiple
        if !address1.isEmpty { address_multiple += "\( address1 )" }
        if !address2.isEmpty { address_multiple += "\n\( address2 ) " }
        if !city.isEmpty { address_multiple += "\n\( city ), " }
        if !state.isEmpty { address_multiple += "\( stateCode ) " }
        if !zip.isEmpty { address_multiple += "\( zip ) " }
        if !country.isEmpty { address_multiple += "\n\( countryCode )" }
        
        return (address_single,address_double,address_multiple)
    }
}

// MARK: - *** JURISDICTIONS CLASS ***
/// Structs for Jurisdictions.
public class Jurisdictions {
    public init() {}
    public var Version: String { return "5.0" }
    
    public typealias JS = JurisdictionStruct

    public let notSelectedText: String = "Not Selected"
    public let unselectedText: String = "-- Unselected --"
    public let dashesText: String = "--"


// MARK: --> *** U.S. ***
    public struct US {
        public static let DC:JS = JS(name:"D.C. (Washington DC)",code:"DC",country:"United States District of Columbia",type:.district,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
        public static let States_DC:[JS] = (States.all + [DC]).sorted(by: { ($0.name < $1.name) })
        public static let States_DC_PR:[JS] = (States.all + [DC] + [Territories.PuertoRico]).sorted(by: { ($0.name < $1.name) })
        public static let States_DC_AllTerritories:[JS] = (States_DC + Territories.Guam_PR_allTerritories).sorted(by: { ($0.name < $1.name) })
        public static let States_DC_AllTerritories_ArmedForces:[JS] = (States_DC + Territories.Guam_PR_allTerritories + ArmedForces.all).sorted(by: { ($0.name < $1.name) })
        public static let States_DC_MajorTerritories:[JS] = (States_DC + Territories.Guam_PR_minor_freeStatesTerritories).sorted(by: { ($0.name < $1.name) })
        public static let States_DC_MinorTerritories:[JS] = (States_DC + Territories.Guam_PR_minorTerritories).sorted(by: { ($0.name < $1.name) })

        // MARK: - *** States Lists ***
        public struct StatesList {
            //Data
            public static let states:[String] = Jurisdictions.US().arrNames(Jurisdictions.US.States_DC)
            public static let territories:[String] = Jurisdictions.US().arrNames(Jurisdictions.US.Territories.Guam_PR)
            public static let minor:[String] = Jurisdictions.US().arrNames(Jurisdictions.US.Territories.minorTerritories)
            public static let free:[String] = Jurisdictions.US().arrNames(Jurisdictions.US.Territories.freeTerritories)
            public static let outlying:[String] = Jurisdictions.US().arrNames(Jurisdictions.US.Territories.outlyingTerritories)
            public static let armedForces:[String] = Jurisdictions.US().arrNames(Jurisdictions.US.ArmedForces.all)
            public static let all:[String] = (states + territories + minor + free + outlying + armedForces)
            //Counts
            public static let stateCount = StatesList.states.count
            public static let territoryCount = StatesList.territories.count
            public static let minorCount = StatesList.minor.count
            public static let freeCount = StatesList.free.count
            public static let outlyingCount = StatesList.outlying.count
            public static let armedForcesCount = StatesList.armedForces.count
            //Counters
            public static let state_territory_Count = (stateCount + territoryCount)
            public static let state_territory_Minor_Count = (state_territory_Count + minorCount)
            public static let state_territory_Minor_Free_Count = (state_territory_Minor_Count + freeCount)
            public static let state_territory_Minor_Free_Outlying_Count = (state_territory_Minor_Free_Count + outlyingCount)
            public static let allTerritories_armedForces_Count = (state_territory_Minor_Free_Outlying_Count + armedForcesCount)
            //Ranges
            public static let stateRange = (0..<(stateCount - 1))
            public static let state_territoryRange = (stateCount...(state_territory_Count - 1))
            public static let state_territory_minorRange = (state_territory_Count...state_territory_Minor_Count - 1)
            public static let state_territory_minor_freeRange = (state_territory_Minor_Count...state_territory_Minor_Free_Count - 1)
            public static let state_territory_minor_free_outlyingRange = (state_territory_Minor_Free_Count...state_territory_Minor_Free_Outlying_Count - 1)
            public static let allTerritories_armedForcesRange = (state_territory_Minor_Free_Outlying_Count...allTerritories_armedForces_Count - 1)

            public struct statesPicker: View {
                @Binding var selection: String
                let rowSize: CGFloat
                let showTerritories: Bool
                let showMinor: Bool
                let showFreeStates: Bool
                let showOutlying: Bool
                let showArmedForces: Bool
                let color: Color

                public init(
                    selection: Binding<String>,
                    rowSize: CGFloat,
                    showTerritories: Bool,
                    showMinor: Bool,
                    showFreeStates: Bool,
                    showOutlying: Bool,
                    showArmedForces: Bool,
                    color: Color
                ) {
                    _selection = selection
                    self.rowSize = rowSize
                    self.showTerritories = showTerritories
                    self.showMinor = showMinor
                    self.showFreeStates = showFreeStates
                    self.showOutlying = showOutlying
                    self.showArmedForces = showArmedForces
                    self.color = color
                }
                
                public enum UnselectedTypes: Int { case unselected,notSelected,dashes }

                var statesAndDc_View: some View {
                    Section("U.S. States, DC") {
                        ForEach(stateRange, id: \.self) { counter in
                            Text(all[counter])
                                .tag(all[counter])
                                .font(.system(size: rowSize, weight: .regular))
                        }
                    }
                }

                var territories_View: some View {
                    Section("U.S. Territories") {
                        ForEach(Jurisdictions.US.StatesList.state_territoryRange, id: \.self) { counter in
                            Text(Jurisdictions.US.StatesList.all[counter])
                                .tag(Jurisdictions.US.StatesList.all[counter])
                                .font(.system(size: rowSize, weight: .regular))
                        }
                    }
                }
                
                var minor_View: some View {
                    Section("U.S. Minor Territories") {
                        ForEach(Jurisdictions.US.StatesList.state_territory_minorRange, id: \.self) { counter in
                            Text(Jurisdictions.US.StatesList.all[counter])
                                .tag(Jurisdictions.US.StatesList.all[counter])
                                .font(.system(size: rowSize, weight: .regular))
                        }
                    }
                }
                
                var freeStates_View: some View {
                    Section("U.S. Free State Territories") {
                        ForEach(Jurisdictions.US.StatesList.state_territory_minor_freeRange, id: \.self) { counter in
                            Text(Jurisdictions.US.StatesList.all[counter])
                                .tag(Jurisdictions.US.StatesList.all[counter])
                                .font(.system(size: rowSize, weight: .regular))
                        }
                    }
                }
                
                var outlying_View: some View {
                    Section("U.S. Outlying Territories") {
                        ForEach(Jurisdictions.US.StatesList.state_territory_minor_free_outlyingRange, id: \.self) { counter in
                            Text(Jurisdictions.US.StatesList.all[counter])
                                .tag(Jurisdictions.US.StatesList.all[counter])
                                .font(.system(size: rowSize, weight: .regular))
                        }
                    }
                }
                
                var armedForces_View: some View {
                    Section("U.S. Armed Forces") {
                        ForEach(Jurisdictions.US.StatesList.allTerritories_armedForcesRange, id: \.self) { counter in
                            Text(Jurisdictions.US.StatesList.all[counter])
                                .tag(Jurisdictions.US.StatesList.all[counter])
                                .font(.system(size: rowSize, weight: .regular))
                        }
                    }
                }

                var unselected_View: some View {
                    let txt: String  = Jurisdictions().unselectedText
                    
                    return Text(txt)
                        .font(.system(size: rowSize, weight: .regular))
                        .tag(txt)
                }

                public var body: some View {
                    Picker("", selection: $selection) {
                        unselected_View
                        statesAndDc_View
                        
                        if showTerritories { territories_View }
                        if showMinor { minor_View }
                        if showFreeStates { freeStates_View }
                        if showOutlying { outlying_View }
                        if showArmedForces { armedForces_View }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .tint(color)
                    .onAppear {
                        if selection.isEmpty ||
                           selection == Jurisdictions().dashesText ||
                           selection == Jurisdictions().notSelectedText ||
                           selection == Jurisdictions().unselectedText
                        {
                           selection = Jurisdictions().unselectedText
                        }
                    }
                }
            }
        }

        public struct States {
            public static let Continental:[JS] = Contiguous.all.sorted(by: { ($0.name < $1.name) })
            public static let all:[JS] = (NonContiguous.all + Contiguous.all).sorted(by: { ($0.name < $1.name) })
            
            public struct NonContiguous {
                public static let Alaska:JS = JS(name:"Alaska",code:"AK",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Hawaii:JS = JS(name:"Hawaii",code:"HI",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let all:[JS] = [Alaska,Hawaii].sorted(by: { ($0.name < $1.name) })
            }
            
            public struct Contiguous {
                public static let Alabama:JS = JS(name:"Alabama",code:"AL",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Arizona:JS = JS(name:"Arizona",code:"AZ",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Arkansas:JS = JS(name:"Arkansas",code:"AR",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let California:JS = JS(name:"California",code:"CA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Colorado:JS = JS(name:"Colorado",code:"CO",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Connecticut:JS = JS(name:"Connecticut",code:"CT",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Delaware:JS = JS(name:"Delaware",code:"DE",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Florida:JS = JS(name:"Florida",code:"FL",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Georgia:JS = JS(name:"Georgia",code:"GA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Idaho:JS = JS(name:"Idaho",code:"ID",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Illinois:JS = JS(name:"Illinois",code:"IL",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Indiana:JS = JS(name:"Indiana",code:"IN",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Iowa:JS = JS(name:"Iowa",code:"IA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Kansas:JS = JS(name:"Kansas",code:"KS",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Kentucky:JS = JS(name:"Kentucky",code:"KY",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Louisiana:JS = JS(name:"Louisiana",code:"LA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Maine:JS = JS(name:"Maine",code:"ME",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Maryland:JS = JS(name:"Maryland",code:"MD",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Massachusettes:JS = JS(name:"Massachusettes",code:"MA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Michigan:JS = JS(name:"Michigan",code:"MI",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Minnesota:JS = JS(name:"Minnesota",code:"MN",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Mississippi:JS = JS(name:"Mississippi",code:"MS",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Missouri:JS = JS(name:"Missouri",code:"MO",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Montana:JS = JS(name:"Montana",code:"MT",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Nebraska:JS = JS(name:"Nebraska",code:"NE",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Nevada:JS = JS(name:"Nevada",code:"NV",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NewHampshire:JS = JS(name:"New Hampshire",code:"NH",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NewJersey:JS = JS(name:"New Jersey",code:"NJ",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NewMexico:JS = JS(name:"New Mexico",code:"NM",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NewYork:JS = JS(name:"New York",code:"NY",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NorthCarolina:JS = JS(name:"North Carolina",code:"NC",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NorthDakota:JS = JS(name:"North Dakota",code:"ND",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Ohio:JS = JS(name:"Ohio",code:"OH",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Oklahoma:JS = JS(name:"Oklahoma",code:"OK",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Oregon:JS = JS(name:"Oregon",code:"OR",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Pennsylvania:JS = JS(name:"Pennsylvania",code:"PA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let RhodeIsland:JS = JS(name:"Rhode Island",code:"RI",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let SouthCarolina:JS = JS(name:"South Carolina",code:"SC",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let SouthDakota:JS = JS(name:"South Dakota",code:"SD",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Tennessee:JS = JS(name:"Tennessee",code:"TN",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Texas:JS = JS(name:"Texas",code:"TX",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Utah:JS = JS(name:"Utah",code:"UT",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Vermont:JS = JS(name:"Vermont",code:"VT",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Virginia:JS = JS(name:"Virginia",code:"VA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Washington:JS = JS(name:"Washington",code:"WA",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let WestVirginia:JS = JS(name:"West Virginia",code:"WV",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Wisconsin:JS = JS(name:"Wisconsin",code:"WI",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Wyoming:JS = JS(name:"Wyoming",code:"WY",country:"United States",type:.state,region:.country,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let all:[JS] = [
                    Alabama,Arizona,Arkansas,California,Colorado,Connecticut,Delaware,Florida,Georgia,Idaho,
                    Illinois,Indiana,Iowa,Kansas,Kentucky,Louisiana,Maine,Maryland,Massachusettes,Michigan,
                    Minnesota,Mississippi,Missouri,Montana,Nebraska,Nevada,NewHampshire,NewJersey,NewMexico,
                    NewYork,NorthCarolina,NorthDakota,Ohio,Oklahoma,Oregon,Pennsylvania,RhodeIsland,SouthCarolina,
                    SouthDakota,Tennessee,Texas,Utah,Vermont,Virginia,Washington,WestVirginia,Wisconsin,Wyoming
                ].sorted(by: { ($0.name < $1.name) })
            }
            
            public static var arrNames:[String] {
                var states:[String] = []
                
                States.all.forEach { (stateStruct) in
                    states.append( stateStruct.name )
                }
                
                return states.sorted()
            }
        }
        
        public struct Territories {
            public static let Guam:JS = JS(name:"Guam",code:"GU",country:"United States Territory",type:.minorTerritory,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
            public static let PuertoRico:JS = JS(name:"Puerto Rico",code:"PR",country:"United States Territory",type:.territory,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
            public static let Guam_PR:[JS] = [Guam,PuertoRico].sorted(by: { ($0.name < $1.name) })
            public static let Guam_PR_allTerritories:[JS] = (Guam_PR + Minor.all + FreeStates.all + Outlying.all).sorted(by: { ($0.name < $1.name) })
            public static let Guam_PR_minorTerritories:[JS] = (Guam_PR + Minor.all).sorted(by: { ($0.name < $1.name) })
            public static let Guam_PR_minor_freeStatesTerritories:[JS] = (Guam_PR + Minor.all + FreeStates.all).sorted(by: { ($0.name < $1.name) })
            public static let freeTerritories:[JS] = FreeStates.all.sorted(by: { ($0.name < $1.name) })
            public static let minorTerritories:[JS] = Minor.all.sorted(by: { ($0.name < $1.name) })
            public static let outlyingTerritories:[JS] = Outlying.all.sorted(by: { ($0.name < $1.name) })

            public struct Minor {
                public static let AmericanSamoa:JS = JS(name:"American Samoa",code:"AS",country:"United States Minor Territories",type:.minorTerritory,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NorthernMarianaIslands:JS = JS(name:"Northern Mariana Islands",code:"MP",country:"United States Minor Territories",type:.minorTerritory,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let VirginIslands:JS = JS(name:"US Virgin Islands",code:"VI",country:"United States Minor Territories",type:.minorTerritory,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let all:[JS] = [AmericanSamoa,NorthernMarianaIslands,VirginIslands].sorted(by: { ($0.name < $1.name) })
            }
            public struct FreeStates {
                public static let Micronesia:JS = JS(name:"Micronesia",code:"FM",country:"United States Free States",type:.freeStates,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let MarshallIslands:JS = JS(name:"Marshall Islands",code:"MH",country:"United States Free States",type:.freeStates,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Palau:JS = JS(name:"Palau",code:"PW",country:"United States Free States",type:.freeStates,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let all:[JS] = [Micronesia,MarshallIslands,Palau].sorted(by: { ($0.name < $1.name) })
            }
            public struct Outlying {
                public static let BakerIsland:JS = JS(name:"Baker Island",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let HowlandIsland:JS = JS(name:"Howland Island",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let JarvisIsland:JS = JS(name:"Jarvis Island",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let JohnstonAtoll:JS = JS(name:"Johnston Atoll",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let KingmanReef:JS = JS(name:"Kingman Reef",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let MidwayIslands:JS = JS(name:"Midway Islands",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let NavassaIsland:JS = JS(name:"Navassa Island",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let PalmyraAtoll:JS = JS(name:"Palmyra Atoll",code:"UM",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let WakeIsland:JS = JS(name:"Wake Island",code:"96898",country:"United States Minor Outlying Territories",type:.outlyingTerritories,region:.possession,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let all:[JS] = [BakerIsland,HowlandIsland,JarvisIsland,JohnstonAtoll,KingmanReef,MidwayIslands,NavassaIsland,PalmyraAtoll,WakeIsland].sorted(by: { ($0.name < $1.name) })
            }
        }
        
        public struct ArmedForces {
            public static let Americas:JS = JS(name:"Armed Forces Americas",code:"AA",country:"United States Armed Forces: Americas",type:.militaryMailCode,region:.military,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
            public static let Europe:JS = JS(name:"Armed Forces Europe",code:"AE",country:"United States Armed Forces: Europe",type:.militaryMailCode,region:.military,flagImgName:"United States",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
            public static let Pacific:JS = JS(name:"Armed Forces Pacific",code:"AP",country:"United States",type:.militaryMailCode,region:.military,flagImgName:"United States Armed Forces: Pacific",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
            public static let all:[JS] = [Americas,Europe,Pacific].sorted(by: { ($0.name < $1.name) })
        }
        
        public func arrNames(_ jurisdictions: [JS]) -> [String] {
            var states:[String] = []
            
            jurisdictions.forEach { (stateStruct) in
                states.append( stateStruct.name )
            }
            
            return states.sorted()
        }
    }

// MARK: --> *** Countries ***
    public struct Countries {
        public static let all:[JS] = Regions.all.sorted(by: { ($0.name < $1.name) })

// MARK: ---> *** Regions ***
        public struct Regions {
            public static let all:[JS] = (
                Americas.all + Europe.all + Asia.all + AustraliaOceania.all + Africa.all + Carribean.all + Other.all
            ).sorted(by: { ($0.name < $1.name) })

            public struct Americas {
                public static let all:[JS] = (NorthAmerica.all + Mexico.all + CentralAmerica.all + SouthAmerica.all).sorted(by: { ($0.name < $1.name) })
                public static let LatinAmerica:[JS] = (Mexico.all + CentralAmerica.all + SouthAmerica.all).sorted(by: { ($0.name < $1.name) })

                public struct NorthAmerica {
                    public static let Canada:JS = JS(name:"Canada",code:"CA",country:"Canada",type:.country,region:.country,flagImgName:"Canada",currency:"Canada Dollar",currencyCode:"CAD",currencySymbol:"$")
                    public static let Mexico:JS = JS(name:"Mexico",code:"MX",country:"Mexico",type:.country,region:.country,flagImgName:"Mexico",currency:"Mexico Peso",currencyCode:"MXN",currencySymbol:"$")
                    public static let UnitedStates:JS = JS(name:"United States",code:"US",country:"United States",type:.country,region:.country,flagImgName:"UnitedStates",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let all:[JS] = [Canada,UnitedStates,Mexico].sorted(by: { ($0.name < $1.name) })
                }
                
                public struct CentralAmerica  {
                    public static let Belize:JS = JS(name:"Belize",code:"BZ",country:"Belize",type:.country,region:.country,flagImgName:"Belize",currency:"Belize Dollar",currencyCode:"BZD",currencySymbol:"BZ$")
                    public static let CostaRica:JS = JS(name:"Costa Rica",code:"CR",country:"Costa Rica",type:.country,region:.country,flagImgName:"CostaRica",currency:"Costa Rica Colon",currencyCode:"CRC",currencySymbol:"₡")
                    public static let ElSalvador:JS = JS(name:"El Salvador",code:"SV",country:"El Salvador",type:.country,region:.country,flagImgName:"ElSalvador",currency:"El Salvador Colon",currencyCode:"SVC",currencySymbol:"$")
                    public static let Guatemala:JS = JS(name:"Guatemala",code:"GT",country:"Guatemala",type:.country,region:.country,flagImgName:"Guatemala",currency:"Guatemala Quetzal",currencyCode:"GTQ",currencySymbol:"Q")
                    public static let Honduras:JS = JS(name:"Honduras",code:"HN",country:"Honduras",type:.country,region:.country,flagImgName:"Honduras",currency:"Honduras Lempira",currencyCode:"HNL",currencySymbol:"L")
                    public static let Nicaragua:JS = JS(name:"Nicaragua",code:"NI",country:"Nicaragua",type:.country,region:.country,flagImgName:"Nicaragua",currency:"Nicaragua Cordoba",currencyCode:"NIO",currencySymbol:"C$")
                    public static let Panama:JS = JS(name:"Panama",code:"PA",country:"Panama",type:.country,region:.country,flagImgName:"Panama",currency:"Panama Balboa",currencyCode:"PAB",currencySymbol:"B/.")
                    public static let all:[JS] = [Belize,CostaRica,ElSalvador,Honduras,Nicaragua,Panama].sorted(by: { ($0.name < $1.name) })
                }
                
                public struct SouthAmerica  {
                    public static let Argentina:JS = JS(name:"Argentina",code:"AR",country:"Argentina",type:.country,region:.country,flagImgName:"Argentina",currency:"Argentina Peso",currencyCode:"ARS",currencySymbol:"$")
                    public static let Bolivia:JS = JS(name:"Bolivia",code:"BO",country:"Bolivai, Lurinational State Of",type:.country,region:.country,flagImgName:"Bolivia",currency:"Bolivia Boliviano",currencyCode:"BOB",currencySymbol:"$b")
                    public static let Brazil:JS = JS(name:"Brazil",code:"BR",country:"Brazil",type:.country,region:.country,flagImgName:"Brazil",currency:"Brazil Real",currencyCode:"BRL",currencySymbol:"R$")
                    public static let Chile:JS = JS(name:"Chile",code:"CL",country:"Chile",type:.country,region:.country,flagImgName:"Chile",currency:"Chile Peso",currencyCode:"CLP",currencySymbol:"$")
                    public static let Colombia:JS = JS(name:"Colombia",code:"CO",country:"Columbia",type:.country,region:.country,flagImgName:"Colombia",currency:"Colombia Peso",currencyCode:"COP",currencySymbol:"$")
                    public static let Ecuador:JS = JS(name:"Ecuador",code:"EC",country:"Ecuador",type:.country,region:.country,flagImgName:"Ecuador",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let FrenchGuiana:JS = JS(name:"French Guiana",code:"GF",country:"French Guiana",type:.country,region:.country,flagImgName:"FrenchGuiana",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                    public static let Guyana:JS = JS(name:"Guyana",code:"GY",country:"Guyana",type:.country,region:.country,flagImgName:"Guyana",currency:"Guyana Dollar",currencyCode:"GYD",currencySymbol:"$")
                    public static let Paraguay:JS = JS(name:"Paraguay",code:"PY",country:"Paraguay",type:.country,region:.country,flagImgName:"Paraguay",currency:"Paraguay Guarani",currencyCode:"PYG",currencySymbol:"Gs")
                    public static let Peru:JS = JS(name:"Peru",code:"PE",country:"Peru",type:.country,region:.country,flagImgName:"Peru",currency:"Peru Nuevo Sol",currencyCode:"PEN",currencySymbol:"S/.")
                    public static let Suriname:JS = JS(name:"Suriname",code:"SR",country:"Suriname",type:.country,region:.country,flagImgName:"Suriname",currency:"Suriname Dollar",currencyCode:"SRD",currencySymbol:"$")
                    public static let Uruguay:JS = JS(name:"Uruguay",code:"UY",country:"Uruguay",type:.country,region:.country,flagImgName:"Uruguay",currency:"Uruguay Peso",currencyCode:"UYU",currencySymbol:"$U")
                    public static let Venezuela:JS = JS(name:"Venezuela",code:"VE",country:"Venezuela, Bolivarian Republic Of",type:.country,region:.country,flagImgName:"Venezuela",currency:"Venezuela Bolivar",currencyCode:"VEF",currencySymbol:"Bs")
                    public static let all:[JS] = [
                        Argentina,Bolivia,Brazil,Chile,Colombia,Ecuador,FrenchGuiana,Guyana,Paraguay,Peru,Suriname,
                        Uruguay,Venezuela
                    ].sorted(by: { ($0.name < $1.name) })
                }
            }
            
            public struct Europe {
                public static let all:[JS] = [
                    Albania,Andorra,Armenia,Austria,Azerbaijan,Belarus,Belgium,BosniaAndHerzogovina,Bulgaria,Croatia,
                    Cyprus,CzechRepublic,Denmark,Estonia,Finland,France,Georgia,Germany,Greece,Hungary,Iceland,Ireland,
                    Italy,Khazakhstan,Kosovo,Latvia,Liechtenstein,Lithuania,Luxembourg,Malta,Moldova,Monaco,Montenegro,
                    Netherlands,NorthMacedonia,Norway,Poland,Portugal,Romania,Russia,SanMarino,Serbia,Slovakia,Slovenia,
                    Spain,Sweden,Switzerland,Turkey,Ukraine,UnitedKingdom,VaticanCity
                ].sorted(by: { ($0.name < $1.name) })

                public static let Albania:JS = JS(name:"Albania",code:"AL",country:"Albania",type:.country,region:.country,flagImgName:"Albania",currency:"Albania Lek",currencyCode:"ALL",currencySymbol:"Lek")
                public static let Andorra:JS = JS(name:"Andorra",code:"AD",country:"Andorra",type:.country,region:.country,flagImgName:"Andorra",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Armenia:JS = JS(name:"Armenia",code:"AM",country:"Armenia",type:.country,region:.country,flagImgName:"Armenia",currency:"Aremenia Dram",currencyCode:"AMD",currencySymbol:"AMD")
                public static let Austria:JS = JS(name:"Austria",code:"AT",country:"Austria",type:.country,region:.country,flagImgName:"Austria",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Azerbaijan:JS = JS(name:"Azerbaijan",code:"AZ",country:"Azerbaijan",type:.country,region:.country,flagImgName:"Azerbaijan",currency:"New Manats",currencyCode:"AZN",currencySymbol:"MaH")
                public static let Belarus:JS = JS(name:"Belarus",code:"BY",country:"Belarus",type:.country,region:.country,flagImgName:"Belarus",currency:"Belarus Ruble",currencyCode:"BYR",currencySymbol:"Br")
                public static let Belgium:JS = JS(name:"Belgium",code:"BE",country:"Belgium",type:.country,region:.country,flagImgName:"Belgium",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let BosniaAndHerzogovina:JS = JS(name:"Bosnia and Herzogovina",code:"BA",country:"Bosnia and Herzogovina",type:.country,region:.country,flagImgName:"BosniaAndHerzegovina",currency:"Bosnia and Herzegovina Convertible Marka",currencyCode:"BAM",currencySymbol:"KM")
                public static let Bulgaria:JS = JS(name:"Bulgaria",code:"BG",country:"Bulgaria",type:.country,region:.country,flagImgName:"Bulgaria",currency:"Bulgaria Lev",currencyCode:"BGN",currencySymbol:"BGN")
                public static let Croatia:JS = JS(name:"Croatia",code:"HR",country:"Croatia",type:.country,region:.country,flagImgName:"Croatia",currency:"Croatia Kuna",currencyCode:"HRK",currencySymbol:"kn")
                public static let Cyprus:JS = JS(name:"Cyprus",code:"CY",country:"Cyprus",type:.country,region:.country,flagImgName:"Cyprus",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let CzechRepublic:JS = JS(name:"Czech Republic",code:"CZ",country:"Czech Republic",type:.country,region:.country,flagImgName:"CzechRepublic",currency:"Czech Republic Koruna",currencyCode:"CZK",currencySymbol:"Kč")
                public static let Denmark:JS = JS(name:"Denmark",code:"DK",country:"Denmark",type:.country,region:.country,flagImgName:"Denmark",currency:"Denmark Krone",currencyCode:"DKK",currencySymbol:"kr")
                public static let Estonia:JS = JS(name:"Estonia",code:"EE",country:"Estonia",type:.country,region:.country,flagImgName:"Estonia",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Finland:JS = JS(name:"Finland",code:"FI",country:"Finland",type:.country,region:.country,flagImgName:"Finland",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let France:JS = JS(name:"France",code:"FR",country:"France",type:.country,region:.country,flagImgName:"France",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Georgia:JS = JS(name:"Georgia",code:"GE",country:"Georgia",type:.country,region:.country,flagImgName:"Georgia",currency:"Lari",currencyCode:"GEL",currencySymbol:"₾")
                public static let Germany:JS = JS(name:"Germany",code:"DE",country:"Germany",type:.country,region:.country,flagImgName:"Germany",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Greece:JS = JS(name:"Greece",code:"GR",country:"Greece",type:.country,region:.country,flagImgName:"Greece",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Hungary:JS = JS(name:"Hungary",code:"HU",country:"Hungary",type:.country,region:.country,flagImgName:"Hungary",currency:"Hungary Forint",currencyCode:"HUF",currencySymbol:"Ft")
                public static let Iceland:JS = JS(name:"Iceland",code:"IS",country:"Iceland",type:.country,region:.country,flagImgName:"Iceland",currency:"Iceland Krona",currencyCode:"ISK",currencySymbol:"kr")
                public static let Ireland:JS = JS(name:"Ireland",code:"IE",country:"Ireland",type:.country,region:.country,flagImgName:"Ireland",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Italy:JS = JS(name:"Italy",code:"IT",country:"Italy",type:.country,region:.country,flagImgName:"Italy",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Khazakhstan:JS = JS(name:"Khazakhstan",code:"KZ",country:"Khazakhstan",type:.country,region:.country,flagImgName:"Kazakhstan",currency:"Kazakhstan Tenge",currencyCode:"KZT",currencySymbol:"KZT")
                public static let Kosovo:JS = JS(name:"Kosovo",code:"XK",country:"Kosovo, Republic Of",type:.country,region:.country,flagImgName:"Kosovo",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Latvia:JS = JS(name:"Latvia",code:"LV",country:"Latvia",type:.country,region:.country,flagImgName:"Latvia",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Liechtenstein:JS = JS(name:"Liechtenstein",code:"LI",country:"Liechtenstein",type:.country,region:.country,flagImgName:"Liechtenstein",currency:"Swiss Franc",currencyCode:"CHF",currencySymbol:"CHF")
                public static let Lithuania:JS = JS(name:"Lithuania",code:"LT",country:"Lithuania",type:.country,region:.country,flagImgName:"Lithuania",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Luxembourg:JS = JS(name:"Luxembourg",code:"LU",country:"Luxembourg",type:.country,region:.country,flagImgName:"Luxembourg",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Malta:JS = JS(name:"Malta",code:"MT",country:"Malta",type:.country,region:.country,flagImgName:"Malta",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Moldova:JS = JS(name:"Moldova",code:"MD",country:"Moldova, Republic Of",type:.country,region:.country,flagImgName:"Moldova",currency:"Moldovan Leu",currencyCode:"MDL",currencySymbol:"L")
                public static let Monaco:JS = JS(name:"Monaco",code:"MC",country:"Monaco",type:.country,region:.country,flagImgName:"Monaco",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Montenegro:JS = JS(name:"Montenegro",code:"ME",country:"Montenegro",type:.country,region:.country,flagImgName:"Montenegro",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Netherlands:JS = JS(name:"Netherlands",code:"NL",country:"Netherlands",type:.country,region:.country,flagImgName:"Netherlands",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let NorthMacedonia:JS = JS(name:"North Macedonia",code:"MK",country:"North Macedonia, Formerly Macedonia",type:.country,region:.country,flagImgName:"Macedonia",currency:"Macedonia Denar",currencyCode:"MKD",currencySymbol:"ден")
                public static let Norway:JS = JS(name:"Norway",code:"NO",country:"Norway",type:.country,region:.country,flagImgName:"Norway",currency:"Norwegian Krone",currencyCode:"NOK",currencySymbol:"kr")
                public static let Poland:JS = JS(name:"Poland",code:"PL",country:"Poland",type:.country,region:.country,flagImgName:"Poland",currency:"Poland Zloty",currencyCode:"PLN",currencySymbol:"zł")
                public static let Portugal:JS = JS(name:"Portugal",code:"PT",country:"Portugal",type:.country,region:.country,flagImgName:"Portugal",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Romania:JS = JS(name:"Romania",code:"RO",country:"Romania",type:.country,region:.country,flagImgName:"Romania",currency:"Romania New Leu",currencyCode:"RON",currencySymbol:"lei")
                public static let Russia:JS = JS(name:"Russia",code:"RU",country:"Russian Federation",type:.country,region:.country,flagImgName:"Russia",currency:"Russia Ruble",currencyCode:"RUB",currencySymbol:"₽")
                public static let SanMarino:JS = JS(name:"San Marino",code:"SM",country:"San Marino",type:.country,region:.country,flagImgName:"SanMarino",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Serbia:JS = JS(name:"Serbia",code:"RS",country:"Serbia",type:.country,region:.country,flagImgName:"Serbia",currency:"Serbia Dinar",currencyCode:"RSD",currencySymbol:"RSD")
                public static let Slovakia:JS = JS(name:"Slovakia",code:"SK",country:"Slovakia",type:.country,region:.country,flagImgName:"Slovakia",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Slovenia:JS = JS(name:"Slovenia",code:"SI",country:"Slovenia",type:.country,region:.country,flagImgName:"Slovenia",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Spain:JS = JS(name:"Spain",code:"ES",country:"Espania",type:.country,region:.country,flagImgName:"Spain",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Sweden:JS = JS(name:"Sweden",code:"SE",country:"Sweden",type:.country,region:.country,flagImgName:"Sweden",currency:"Sweden Krona",currencyCode:"SEK",currencySymbol:"kr")
                public static let Switzerland:JS = JS(name:"Switzerland",code:"CH",country:"Switzerland",type:.country,region:.country,flagImgName:"Switzerland",currency:"Swiss Franc",currencyCode:"CHF",currencySymbol:"CHF")
                public static let Turkey:JS = JS(name:"Turkey",code:"TR",country:"Turkey",type:.country,region:.country,flagImgName:"Turkey",currency:"Turkey Lira",currencyCode:"TRY",currencySymbol:"₺")
                public static let Ukraine:JS = JS(name:"Ukraine",code:"UA",country:"Ukraine",type:.country,region:.country,flagImgName:"Ukraine",currency:"Ukraine Hryvna",currencyCode:"UAH",currencySymbol:"₴")
                public static let UnitedKingdom:JS = JS(name:"United Kingdom",code:"GB",country:"United Kingdom",type:.country,region:.country,flagImgName:"UnitedKingdom",currency:"Pound Sterling",currencyCode:"GBP",currencySymbol:"£")
                public static let VaticanCity:JS = JS(name:"Vatican City",code:"VA",country:"Holy See (Vatican City State)",type:.country,region:.country,flagImgName:"VaticanCity",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
            }
            
            public struct Asia {
                public static let all:[JS] = [
                    Afghanistan,Bahrain,Bangladesh,Bhutan,Brunei,Cambodia,China,India,Indonesia,Iran,Iraq,Israel,
                    Japan,Jordan,Kuwait,Krygystan,Laos,Lebanon,Malaysia,Maldives,Mongolia,Myanmar,Nepal,NorthKorea,
                    Oman,Pakistan,Philippines,Qatar,SaudiArabia,Singapore,SouthKorea,SriLanka,Syria,Taiwan,Tajikistan,
                    Thailand,TimorLeste,Turkmenistan,UnitedArabEmirates,Uzbekistan,Vietnam,Yemen
                ].sorted(by: { ($0.name < $1.name) })

                public static let Afghanistan:JS = JS(name:"Afghanistan",code:"AF",country:"Afghanistan",type:.country,region:.country,flagImgName:"Afghanistan",currency:"Afghanistan Afghanis",currencyCode:"AFN",currencySymbol:"؋")
                public static let Bahrain:JS = JS(name:"Bahrain",code:"BH",country:"Bahrain",type:.country,region:.country,flagImgName:"Bahrain",currency:"Bahraini Dinar",currencyCode:"BHD",currencySymbol:"BD")
                public static let Bangladesh:JS = JS(name:"Bangladesh",code:"BD",country:"Bangladesh",type:.country,region:.country,flagImgName:"Bangladesh",currency:"Taka",currencyCode:"BDT",currencySymbol:"৳")
                public static let Bhutan:JS = JS(name:"Bhutan",code:"BT",country:"Bhutan",type:.country,region:.country,flagImgName:"Bhutan",currency:"Bhutanese ngultrum",currencyCode:"BTN",currencySymbol:"BTN")
                public static let Brunei:JS = JS(name:"Brunei",code:"BN",country:"Brunei Darussalam",type:.country,region:.country,flagImgName:"Brunei",currency:"Brunei Darussalam Dollar",currencyCode:"BND",currencySymbol:"$")
                public static let Cambodia:JS = JS(name:"Cambodia",code:"KH",country:"Cambodia",type:.country,region:.country,flagImgName:"Cambodia",currency:"Cambodia Riel",currencyCode:"KHR",currencySymbol:"KHR")
                public static let China:JS = JS(name:"China",code:"CN",country:"China",type:.country,region:.country,flagImgName:"China",currency:"China Yuan Renminbi",currencyCode:"CNY",currencySymbol:"¥")
                public static let India:JS = JS(name:"India",code:"IN",country:"India",type:.country,region:.country,flagImgName:"India",currency:"India Rupee",currencyCode:"INR",currencySymbol:"₨")
                public static let Indonesia:JS = JS(name:"Indonesia",code:"ID",country:"Indonesia",type:.country,region:.country,flagImgName:"Indonesia",currency:"Indonesia Rupiah",currencyCode:"IDR",currencySymbol:"Rp")
                public static let Iran:JS = JS(name:"Iran",code:"IR",country:"Iran, Islamic Replubli Of",type:.country,region:.country,flagImgName:"Iran",currency:"Iran Rial",currencyCode:"IRR",currencySymbol:"﷼")
                public static let Iraq:JS = JS(name:"Iraq",code:"IQ",country:"Iraq",type:.country,region:.country,flagImgName:"Iraq",currency:"Iraqi Dinar",currencyCode:"IQD",currencySymbol:"IQD")
                public static let Israel:JS = JS(name:"Israel",code:"IL",country:"Isreal",type:.country,region:.country,flagImgName:"Israel",currency:"Israel Shekel",currencyCode:"ILS",currencySymbol:"₪")
                public static let Japan:JS = JS(name:"Japan",code:"JP",country:"Japan",type:.country,region:.country,flagImgName:"Japan",currency:"Japan Yen",currencyCode:"JPY",currencySymbol:"¥")
                public static let Jordan:JS = JS(name:"Jordan",code:"JO",country:"Jordan",type:.country,region:.country,flagImgName:"Jordan",currency:"Jordanian Dinar",currencyCode:"JOD",currencySymbol:"JD")
                public static let Kuwait:JS = JS(name:"Kuwait",code:"KW",country:"Kuwait",type:.country,region:.country,flagImgName:"Kuwait",currency:"Kuwaiti Dinar",currencyCode:"KWD",currencySymbol:"KD")
                public static let Krygystan:JS = JS(name:"Krygystan",code:"KG",country:"Krygystan",type:.country,region:.country,flagImgName:"Kyrgyzstan",currency:"Kyrgyzstan Som",currencyCode:"KGS",currencySymbol:"KGS")
                public static let Laos:JS = JS(name:"Laos",code:"LA",country:"Laos People's Republic Of",type:.country,region:.country,flagImgName:"Laos",currency:"Laos Kip",currencyCode:"LAK",currencySymbol:"₭")
                public static let Lebanon:JS = JS(name:"Lebanon",code:"LB",country:"Lebanon",type:.country,region:.country,flagImgName:"Lebanon",currency:"Lebanon Pound",currencyCode:"LBP",currencySymbol:"£")
                public static let Malaysia:JS = JS(name:"Malaysia",code:"MY",country:"Malaysia",type:.country,region:.country,flagImgName:"Malaysia",currency:"Malaysia Ringgit",currencyCode:"MYR",currencySymbol:"RM")
                public static let Maldives:JS = JS(name:"Maldives",code:"MV",country:"Maldives",type:.country,region:.country,flagImgName:"Maldives",currency:"Rufiyaa",currencyCode:"MVR",currencySymbol:"Rf")
                public static let Mongolia:JS = JS(name:"Mongolia",code:"MN",country:"Mongolia",type:.country,region:.country,flagImgName:"Mongolia",currency:"Mongolia Tughrik",currencyCode:"MNT",currencySymbol:"₮")
                public static let Myanmar:JS = JS(name:"Myanmar",code:"MM",country:"Myanmar formerly Burma",type:.country,region:.country,flagImgName:"Myanmar",currency:"Kyat",currencyCode:"MMK",currencySymbol:"Ks")
                public static let Nepal:JS = JS(name:"Nepal",code:"NP",country:"Nepal",type:.country,region:.country,flagImgName:"Nepal",currency:"Nepal Rupee",currencyCode:"NPR",currencySymbol:"₨")
                public static let NorthKorea:JS = JS(name:"North Korea",code:"KP",country:"Democratic People's Republic of",type:.country,region:.country,flagImgName:"KoreaNorth",currency:"Korea (North) Won",currencyCode:"KPW",currencySymbol:"₩")
                public static let Oman:JS = JS(name:"Oman",code:"OM",country:"Oman",type:.country,region:.country,flagImgName:"Oman",currency:"Oman Rial",currencyCode:"OMR",currencySymbol:"﷼")
                public static let Pakistan:JS = JS(name:"Pakistan",code:"PK",country:"Pakistan",type:.country,region:.country,flagImgName:"Pakistan",currency:"Pakistan Rupee",currencyCode:"PKR",currencySymbol:"₨")
                public static let Philippines:JS = JS(name:"Philippines",code:"PH",country:"Philippines",type:.country,region:.country,flagImgName:"Philippines",currency:"Philippines Peso",currencyCode:"PHP",currencySymbol:"₱")
                public static let Qatar:JS = JS(name:"Qatar",code:"QA",country:"Qatar",type:.country,region:.country,flagImgName:"Qatar",currency:"Qatar Riyal",currencyCode:"QAR",currencySymbol:"﷼")
                public static let SaudiArabia:JS = JS(name:"Saudi Arabia",code:"SA",country:"Saudi Arabia",type:.country,region:.country,flagImgName:"SaudiArabia",currency:"Saudi Arabia Riyal",currencyCode:"SAR",currencySymbol:"﷼")
                public static let Singapore:JS = JS(name:"Singapore",code:"SG",country:"Singapore",type:.country,region:.country,flagImgName:"Singapore",currency:"Singapore Dollar",currencyCode:"SGD",currencySymbol:"$")
                public static let SouthKorea:JS = JS(name:"South Korea",code:"KR",country:"Korea, Republic Of",type:.country,region:.country,flagImgName:"KoreaSouth",currency:"Korea (South) Won",currencyCode:"KRW",currencySymbol:"₩")
                public static let SriLanka:JS = JS(name:"Sri Lanka",code:"LK",country:"Sri Lanka",type:.country,region:.country,flagImgName:"SriLanka",currency:"Sri Lanka Rupee",currencyCode:"LKR",currencySymbol:"₨")
                public static let Syria:JS = JS(name:"Syria",code:"SY",country:"Syrian Arab republic",type:.country,region:.country,flagImgName:"Syria",currency:"Syria Pound",currencyCode:"SYP",currencySymbol:"£")
                public static let Taiwan:JS = JS(name:"Taiwan",code:"TW",country:"Taiwan, Province of China",type:.country,region:.country,flagImgName:"Taiwan",currency:"Taiwan New Dollar",currencyCode:"TWD",currencySymbol:"NT$")
                public static let Tajikistan:JS = JS(name:"Tajikistan",code:"TJ",country:"Tajikistan",type:.country,region:.country,flagImgName:"Tajikistan",currency:"Somoni",currencyCode:"TJS",currencySymbol:"T")
                public static let Thailand:JS = JS(name:"Thailand",code:"TH",country:"Thailand",type:.country,region:.country,flagImgName:"Thailand",currency:"Thailand Baht",currencyCode:"THB",currencySymbol:"฿")
                public static let TimorLeste:JS = JS(name:"Timor-Leste",code:"TL",country:"Democratic Republic of Timor-Leste",type:.country,region:.country,flagImgName:"Timor-Leste",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                public static let Turkmenistan:JS = JS(name:"Turkmenistan",code:"TM",country:"Turkmenistan",type:.country,region:.country,flagImgName:"Turkmenistan",currency:"Turkmenistan New Manat",currencyCode:"TMT",currencySymbol:"T")
                public static let UnitedArabEmirates:JS = JS(name:"United Arab Emirates",code:"AE",country:"United Arab Emirates",type:.country,region:.country,flagImgName:"UnitedArabEmirates",currency:"UAE Dirham",currencyCode:"AED",currencySymbol:"د.إ")
                public static let Uzbekistan:JS = JS(name:"Uzbekistan",code:"UZ",country:"Uzbekistan",type:.country,region:.country,flagImgName:"Uzbekistan",currency:"Uzbekistan Som",currencyCode:"UZS",currencySymbol:"UZS")
                public static let Vietnam:JS = JS(name:"Vietnam",code:"VN",country:"Viet Nam",type:.country,region:.country,flagImgName:"Vietnam",currency:"Viet Nam Dong",currencyCode:"VND",currencySymbol:"₫")
                public static let Yemen:JS = JS(name:"Yemen",code:"YE",country:"Yemen",type:.country,region:.country,flagImgName:"Yemen",currency:"Yemen Rial",currencyCode:"YER",currencySymbol:"﷼")
            }
            
            public struct AustraliaOceania {
                public static let all:[JS] = [
                    Australia,CookIslands,Fiji,FrenchPolynesia,Kiribati,Nauru,Niue,NewCaledonia,NewZealand,
                    NorfolkIsland,PapuaNewGuinea,PitcairnIsland,Samoa,SolomonIslands,Tokelau,Tonga,Tuvalu,
                    Vanuatu,WallisAndFutuna
                ].sorted(by: { ($0.name < $1.name) })

                public static let Australia:JS = JS(name:"Australia",code:"AU",country:"Australia",type:.country,region:.country,flagImgName:"Australia",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let CookIslands:JS = JS(name:"Cook Islands",code:"CK",country:"Cook Islands",type:.country,region:.country,flagImgName:"CookIslands",currency:"New Zealand Dollar",currencyCode:"NZD",currencySymbol:"$")
                public static let Fiji:JS = JS(name:"Fiji",code:"FJ",country:"Fiji",type:.country,region:.country,flagImgName:"Fiji",currency:"Fiji Dollar",currencyCode:"FJD",currencySymbol:"$")
                public static let FrenchPolynesia:JS = JS(name:"French Polynesia",code:"PF",country:"French Polynesia",type:.country,region:.country,flagImgName:"FrenchPolynesia",currency:"CFP Franc",currencyCode:"XPF",currencySymbol:"₣")
                public static let Kiribati:JS = JS(name:"Kiribati",code:"KI",country:"Kiribati",type:.country,region:.country,flagImgName:"Kiribati",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let Nauru:JS = JS(name:"Nauru",code:"NR",country:"Nauru",type:.country,region:.country,flagImgName:"Nauru",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let Niue:JS = JS(name:"Niue",code:"NU",country:"Niue",type:.country,region:.country,flagImgName:"Niue",currency:"New Zealand Dollar",currencyCode:"NZD",currencySymbol:"$")
                public static let NewCaledonia:JS = JS(name:"New Caledonia",code:"NC",country:"New Caledonia",type:.country,region:.country,flagImgName:"NewCaledonia",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let NewZealand:JS = JS(name:"New Zealand",code:"NZ",country:"New Zealand",type:.country,region:.country,flagImgName:"NewZealand",currency:"New Zealand Dollar",currencyCode:"NZD",currencySymbol:"$")
                public static let NorfolkIsland:JS = JS(name:"Norfolk Island",code:"NF",country:"Norfolk Island",type:.country,region:.country,flagImgName:"NorfolkIsland",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let PapuaNewGuinea:JS = JS(name:"Papua New Guinea",code:"PG",country:"Papua New Guinea",type:.country,region:.country,flagImgName:"PapuaNewGuinea",currency:"Kina",currencyCode:"PGK",currencySymbol:"K")
                public static let Samoa:JS = JS(name:"Samoa",code:"WS",country:"Samoa",type:.country,region:.country,flagImgName:"Samoa",currency:"Tala",currencyCode:"WST",currencySymbol:"WS$")
                public static let SolomonIslands:JS = JS(name:"Solomon Islands",code:"SB",country:"Solomon Islands",type:.country,region:.country,flagImgName:"SolomonIslands",currency:"Solomon Islands Dollar",currencyCode:"SBD",currencySymbol:"$")
                public static let Tonga:JS = JS(name:"Tonga",code:"TO",country:"Tonga",type:.country,region:.country,flagImgName:"Tonga",currency:"Pa'Anga",currencyCode:"TOP",currencySymbol:"T$")
                public static let Tuvalu:JS = JS(name:"Tuvalu",code:"TV",country:"Tuvalu",type:.country,region:.country,flagImgName:"Tuvalu",currency:"Tuvalu Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let Vanuatu:JS = JS(name:"Vanuatu",code:"VU",country:"Vanuatu",type:.country,region:.country,flagImgName:"Vanuatu",currency:"Vanuatu Vatu",currencyCode:"VUV",currencySymbol:"VT")
                public static let PitcairnIsland:JS = JS(name:"Pitcairn Island",code:"PN",country:"Pitcairn Island",type:.country,region:.country,flagImgName:"PitcairnIslands",currency:"New Zealand Dollar",currencyCode:"NZD",currencySymbol:"$")
                public static let Tokelau:JS = JS(name:"Tokelau",code:"TK",country:"Tokelau",type:.country,region:.country,flagImgName:"Tokelau",currency:"New Zealand Dollar",currencyCode:"NZD",currencySymbol:"$")
                public static let WallisAndFutuna:JS = JS(name:"Wallis and Futuna",code:"WF",country:"Wallis and Futuna",type:.country,region:.country,flagImgName:"WallisAndFutuna",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
            }

            public struct Africa {
                public static let all:[JS] = [
                    Algeria,Angola,Benin,Botswana,BurkinaFaso,Burundi,CapeVerde,Cameroon,CentralAfricanRepublic,
                    Chad,Comoros,CongoDemocraticRepublic,CongoRepublic,IvoryCoast,Djibouti,Egypt,EquatorialGuinea,
                    Eritrea,Eswatini,Ethiopia,Gabon,Gambia,Ghana,Guinea,GuineaBissau,Kenya,Lesotho,Liberia,Libya,
                    Madagascar,Malawi,Mauritania,Mauritius,Morocco,Mozambique,Namimbia,Niger,Nigeria,Rwanda,
                    SaoTomeAndPrincipe,Senegal,Seychelles,SierraLeone,Somalia,SouthAfrica,SouthSudan,Sudan,Tanzania,
                    Togo,Tunisia,Uganda,Zambia,Zimbabwe
                ].sorted(by: { ($0.name < $1.name) })

                public static let Algeria:JS = JS(name:"Algeria",code:"DZ",country:"Algeria",type:.country,region:.country,flagImgName:"Algeria",currency:"Algeria Dinar",currencyCode:"DZD",currencySymbol:"DA")
                public static let Angola:JS = JS(name:"Angola",code:"AO",country:"Angola",type:.country,region:.country,flagImgName:"Angola",currency:"Angola Kwnaza",currencyCode:"AOA",currencySymbol:"Kz")
                public static let Benin:JS = JS(name:"Benin",code:"BJ",country:"Benin",type:.country,region:.country,flagImgName:"Benin",currency:"West African CFA Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Botswana:JS = JS(name:"Botswana",code:"BW",country:"Botswana",type:.country,region:.country,flagImgName:"Botswana",currency:"Botswana Pula",currencyCode:"BWP",currencySymbol:"P")
                public static let BurkinaFaso:JS = JS(name:"Burkina Faso",code:"BF",country:"Burkina Faso",type:.country,region:.country,flagImgName:"BurkinaFaso",currency:"West African CFA Franc",currencyCode:"XOF",currencySymbol:"CFA")
                public static let Burundi:JS = JS(name:"Burundi",code:"BI",country:"Burundi",type:.country,region:.country,flagImgName:"Burundi",currency:"Burundi Franc",currencyCode:"BIF",currencySymbol:"₣")
                public static let CapeVerde:JS = JS(name:"Cape Verde",code:"CV",country:"Cape Verde",type:.country,region:.country,flagImgName:"CapeVerdeIslands",currency:"Cape Verde Escudo",currencyCode:"CVE",currencySymbol:"$")
                public static let Cameroon:JS = JS(name:"Cameroon",code:"CM",country:"Cameroon",type:.country,region:.country,flagImgName:"Cameroon",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let CentralAfricanRepublic:JS = JS(name:"Central African Republic",code:"CF",country:"Central African Republic",type:.country,region:.country,flagImgName:"CentralAfricanRepublic",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Chad:JS = JS(name:"Chad",code:"TD",country:"Chad",type:.country,region:.country,flagImgName:"Chad",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Comoros:JS = JS(name:"Comoros",code:"KM",country:"Comoros",type:.country,region:.country,flagImgName:"Comoros",currency:"Comorian Franc",currencyCode:"KMF",currencySymbol:"KMF")
                public static let CongoDemocraticRepublic:JS = JS(name:"Congo, Democratic Republic of",code:"CD",country:"Congo, Democratic Republic Of",type:.country,region:.country,flagImgName:"CongoDemRep",currency:"Congolese Franc",currencyCode:"CDF",currencySymbol:"CDF")
                public static let CongoRepublic:JS = JS(name:"Congo, Republic of",code:"CG",country:"Congo",type:.country,region:.country,flagImgName:"CongoRepublic",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let IvoryCoast:JS = JS(name:"Ivory Coast",code:"CI",country:"Cote D'Ivoire",type:.country,region:.country,flagImgName:"IvoryCoast",currency:"West African CFA Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Djibouti:JS = JS(name:"Djibouti",code:"DJ",country:"Djibouti",type:.country,region:.country,flagImgName:"Djibouti",currency:"Djibouti Franc",currencyCode:"DJF",currencySymbol:"Fdj")
                public static let Egypt:JS = JS(name:"Egypt",code:"EG",country:"Egypt",type:.country,region:.country,flagImgName:"Egypt",currency:"Egypt Pound",currencyCode:"EGP",currencySymbol:"£")
                public static let EquatorialGuinea:JS = JS(name:"Equatorial Guinea",code:"GQ",country:"Equatorial Guinea",type:.country,region:.country,flagImgName:"EquatorialGuinea",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Eritrea:JS = JS(name:"Eritrea",code:"ER",country:"Eritrea",type:.country,region:.country,flagImgName:"Eritrea",currency:"Eritrea Nakfa",currencyCode:"ERN",currencySymbol:"ERN")
                public static let Eswatini:JS = JS(name:"Eswatini",code:"SZ",country:"Eswatini, formerly Swaziland",type:.country,region:.country,flagImgName:"Swaziland",currency:"Lilangeni",currencyCode:"SZL",currencySymbol:"L")
                public static let Ethiopia:JS = JS(name:"Ethiopia",code:"ET",country:"Ethiopia",type:.country,region:.country,flagImgName:"Ethiopia",currency:"Ehtiopia Birr",currencyCode:"ETB",currencySymbol:"ETB")
                public static let Gabon:JS = JS(name:"Gabon",code:"GA",country:"Gabon",type:.country,region:.country,flagImgName:"Gabon",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Gambia:JS = JS(name:"Gambia",code:"GM",country:"Gambia",type:.country,region:.country,flagImgName:"Gambia",currency:"Dalasi",currencyCode:"GMD",currencySymbol:"D")
                public static let Ghana:JS = JS(name:"Ghana",code:"GH",country:"Ghana",type:.country,region:.country,flagImgName:"Ghana",currency:"Ghana Cedis",currencyCode:"GHS",currencySymbol:"₵")
                public static let Guinea:JS = JS(name:"Guinea",code:"GN",country:"Guinea",type:.country,region:.country,flagImgName:"Guinea",currency:"Guinea Franc",currencyCode:"GNF",currencySymbol:"GF")
                public static let GuineaBissau:JS = JS(name:"Guinea-Bissau",code:"GW",country:"Guinea-Bissau",type:.country,region:.country,flagImgName:"Guinea-Bissau",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Kenya:JS = JS(name:"Kenya",code:"KE",country:"Kenya",type:.country,region:.country,flagImgName:"Kenya",currency:"Kenyan Shilling",currencyCode:"KES",currencySymbol:"KSh")
                public static let Lesotho:JS = JS(name:"Lesotho",code:"LS",country:"Lesotho",type:.country,region:.country,flagImgName:"Liberia",currency:"Loti",currencyCode:"LSL",currencySymbol:"L")
                public static let Liberia:JS = JS(name:"Liberia",code:"LR",country:"Liberia",type:.country,region:.country,flagImgName:"Liberia",currency:"Liberia Dollar",currencyCode:"LRD",currencySymbol:"$")
                public static let Libya:JS = JS(name:"Libya",code:"LY",country:"Libya",type:.country,region:.country,flagImgName:"Libya",currency:"Libyan Dinar",currencyCode:"LYD",currencySymbol:"LD")
                public static let Madagascar:JS = JS(name:"Madagascar",code:"MG",country:"Madagascar",type:.country,region:.country,flagImgName:"Madagascar",currency:"Malagasy Ariary",currencyCode:"MGA",currencySymbol:"Ar")
                public static let Malawi:JS = JS(name:"Malawi",code:"MW",country:"Malawi",type:.country,region:.country,flagImgName:"Malawi",currency:"Kwacha",currencyCode:"MWK",currencySymbol:"ZK")
                public static let Mali:JS = JS(name:"Mali",code:"ML",country:"Mali",type:.country,region:.country,flagImgName:"Mali",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Mauritania:JS = JS(name:"Mauritania",code:"MR",country:"Mauritania",type:.country,region:.country,flagImgName:"Mauritania",currency:"Mauritanian Ouguiya",currencyCode:"MRO",currencySymbol:"UM")
                public static let Mauritius:JS = JS(name:"Mauritius",code:"MU",country:"Mauritius",type:.country,region:.country,flagImgName:"Mauritius",currency:"Mauritius Rupee",currencyCode:"MUR",currencySymbol:"₨")
                public static let Morocco:JS = JS(name:"Morocco",code:"MA",country:"Morocco",type:.country,region:.country,flagImgName:"Morocco",currency:"Moroccan Dirham",currencyCode:"MAD",currencySymbol:"MAD")
                public static let Mozambique:JS = JS(name:"Mozambique",code:"MZ",country:"Mozambique",type:.country,region:.country,flagImgName:"Mozambique",currency:"Mozambique Metical",currencyCode:"MZN",currencySymbol:"MT")
                public static let Namimbia:JS = JS(name:"Namimbia",code:"NA",country:"Namimbia",type:.country,region:.country,flagImgName:"Namibia",currency:"Namibia Dollar",currencyCode:"NAD",currencySymbol:"$")
                public static let Niger:JS = JS(name:"Niger",code:"NE",country:"Niger",type:.country,region:.country,flagImgName:"Niger",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Nigeria:JS = JS(name:"Nigeria",code:"NG",country:"Nigeria",type:.country,region:.country,flagImgName:"Nigeria",currency:"Nigeria Naira",currencyCode:"NGN",currencySymbol:"₦")
                public static let Rwanda:JS = JS(name:"Rwanda",code:"RW",country:"Rwanda",type:.country,region:.country,flagImgName:"Rwanda",currency:"Rwanda Franc",currencyCode:"RWF",currencySymbol:"FRw")
                public static let SaoTomeAndPrincipe:JS = JS(name:"Sao Tome and Principe",code:"ST",country:"Sao Tome and Principe",type:.country,region:.country,flagImgName:"SaoTomeAndPrincipe",currency:"Dobra",currencyCode:"STD",currencySymbol:"Db")
                public static let Senegal:JS = JS(name:"Senegal",code:"SN",country:"Senegal",type:.country,region:.country,flagImgName:"Senegal",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Seychelles:JS = JS(name:"Seychelles",code:"SC",country:"Seychelles",type:.country,region:.country,flagImgName:"Seychelles",currency:"Seychelles Rupee",currencyCode:"SCR",currencySymbol:"₨")
                public static let SierraLeone:JS = JS(name:"Sierra Leone",code:"SL",country:"Sierra Leone",type:.country,region:.country,flagImgName:"SierraLeone",currency:"Leone",currencyCode:"SLL",currencySymbol:"Le")
                public static let Somalia:JS = JS(name:"Somalia",code:"SO",country:"Somalia",type:.country,region:.country,flagImgName:"Somalia",currency:"Somalia Shilling",currencyCode:"SOS",currencySymbol:"S")
                public static let SouthAfrica:JS = JS(name:"South Africa",code:"ZA",country:"South Africa",type:.country,region:.country,flagImgName:"SouthAfrica",currency:"South Africa Rand",currencyCode:"ZAR",currencySymbol:"R")
                public static let SouthSudan:JS = JS(name:"South Sudan",code:"SS",country:"Republic of South Sudan",type:.country,region:.country,flagImgName:"SouthSudan",currency:"Sudanese Pound",currencyCode:"SDG",currencySymbol:"£")
                public static let Sudan:JS = JS(name:"Sudan",code:"SD",country:"Sudan",type:.country,region:.country,flagImgName:"Sudan",currency:"Sudanese Pound",currencyCode:"SDG",currencySymbol:"£")
                public static let Tanzania:JS = JS(name:"Tanzania",code:"TZ",country:"Tanzania, United Republic Of",type:.country,region:.country,flagImgName:"Tanzania",currency:"Tanzanian Shilling",currencyCode:"TZS",currencySymbol:"x/y")
                public static let Togo:JS = JS(name:"Togo",code:"TG",country:"Togo",type:.country,region:.country,flagImgName:"Togo",currency:"Central African Franc",currencyCode:"XAF",currencySymbol:"CFA")
                public static let Tunisia:JS = JS(name:"Tunisia",code:"TN",country:"Tunisia",type:.country,region:.country,flagImgName:"Tunisia",currency:"Tunisian Dinar",currencyCode:"TND",currencySymbol:"DT")
                public static let Uganda:JS = JS(name:"Uganda",code:"UG",country:"Uganda",type:.country,region:.country,flagImgName:"Uganda",currency:"Uganda Shilling",currencyCode:"UGX",currencySymbol:"USh")
                public static let Zambia:JS = JS(name:"Zambia",code:"ZM",country:"Zambia",type:.country,region:.country,flagImgName:"Zambia",currency:"Zambia Kwacha",currencyCode:"ZMK",currencySymbol:"ZMK")
                public static let Zimbabwe:JS = JS(name:"Zimbabwe",code:"ZW",country:"Zimbabwe",type:.country,region:.country,flagImgName:"Zimbabwe",currency:"Zimbabwe Dollar",currencyCode:"ZWL",currencySymbol:"Z$")
            }

            public struct Carribean {
                public static let all:[JS] = (Independent.all + Dependent.all).sorted(by: { ($0.name < $1.name) })

                public struct Independent {
                    public static let AntiguaAndBarbuda:JS = JS(name:"Antigua and Barbuda",code:"AG",country:"Antigua and Barbuda",type:.country,region:.country,flagImgName:"AntiguaAndBarbuda",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let Bahamas:JS = JS(name:"Bahamas",code:"BS",country:"Bahamas",type:.country,region:.country,flagImgName:"Bahamas",currency:"Bahamas Dollar",currencyCode:"BSD",currencySymbol:"$")
                    public static let Barbados:JS = JS(name:"Barbados",code:"BB",country:"Barbados",type:.country,region:.country,flagImgName:"Barbados",currency:"Barados Dollar",currencyCode:"BBD",currencySymbol:"$")
                    public static let Cuba:JS = JS(name:"Cuba",code:"CU",country:"Cuba",type:.country,region:.country,flagImgName:"Cuba",currency:"Cuba Peso",currencyCode:"CUP",currencySymbol:"₱")
                    public static let Dominica:JS = JS(name:"Dominica",code:"DM",country:"Dominica",type:.country,region:.country,flagImgName:"Dominica",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let DominicanRepublic:JS = JS(name:"Dominican Republic",code:"DO",country:"Dominican Republic",type:.country,region:.country,flagImgName:"DominicanRepublic",currency:"Dominican Republic Peso",currencyCode:"DOP",currencySymbol:"RD$")
                    public static let Grenada:JS = JS(name:"Grenada",code:"GD",country:"Grenada",type:.country,region:.country,flagImgName:"Grenada",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let Haiti:JS = JS(name:"Haiti",code:"HT",country:"Haiti",type:.country,region:.country,flagImgName:"Haiti",currency:"Haitian Gourde",currencyCode:"HTG",currencySymbol:"G")
                    public static let Jamaica:JS = JS(name:"Jamaica",code:"JM",country:"Jamaica",type:.country,region:.country,flagImgName:"Jamaica",currency:"Jamaica Dollar",currencyCode:"JMD",currencySymbol:"$")
                    public static let SaintKittsAndNevis:JS = JS(name:"Saint Kitts and Nevis",code:"KN",country:"Saint Kitts and Nevis",type:.country,region:.country,flagImgName:"SaintKittsAndNevis",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let SaintLucia:JS = JS(name:"Saint Lucia",code:"LC",country:"Saint Lucia",type:.country,region:.country,flagImgName:"SaintLucia",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let SaintVincentAndTheGrenadines:JS = JS(name:"Saint Vincent and the Grenadines",code:"VC",country:"Saint Vincent and the Grenadines",type:.country,region:.country,flagImgName:"SaintVincentAndTheGrenadines",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let TrinidadAndTobago:JS = JS(name:"Trinidad and Tobago",code:"TT",country:"Trinidad and Tobago",type:.country,region:.country,flagImgName:"TrinidadAndTobago",currency:"Trinidad and Tobago Dollar",currencyCode:"TTD",currencySymbol:"TT$")
                    public static let all:[JS] = [
                        AntiguaAndBarbuda,Bahamas,Barbados,Cuba,Dominica,DominicanRepublic,Grenada,Haiti,
                        Jamaica,SaintKittsAndNevis,SaintLucia,SaintVincentAndTheGrenadines,TrinidadAndTobago
                    ].sorted(by: { ($0.name < $1.name) })
                }

                public struct Dependent {
                    public static let Anguilla:JS = JS(name:"Anguilla",code:"AI",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"Anguilla",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let Aruba:JS = JS(name:"Aruba",code:"AW",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"Aruba",currency:"Aruba Guilder",currencyCode:"AWG",currencySymbol:"ƒ")
                    public static let Bermuda:JS = JS(name:"Bermuda",code:"BM",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"Bermuda",currency:"Bermuda Dollar",currencyCode:"BMD",currencySymbol:"$")
                    public static let Bonaire:JS = JS(name:"Bonaire",code:"BQ-BO",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"Bonaire",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let BritishVirginIslands:JS = JS(name:"British Virgin Islands",code:"VG",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"BritishVirginIslands",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let CaymanIslands:JS = JS(name:"Cayman Islands",code:"KY",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"CaymanIslands",currency:"Cayman Islands Dollar",currencyCode:"KYD",currencySymbol:"$")
                    public static let Curacao:JS = JS(name:"Curacao",code:"CW",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"Curacao",currency:"Netherlands Antillean Guilder",currencyCode:"ANG",currencySymbol:"ƒ")
                    public static let Guadeloupe:JS = JS(name:"Guadeloupe",code:"GP",country:"France Overseas Region",type:.territory,region:.possession,flagImgName:"Guadeloupe",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                    public static let Martinique:JS = JS(name:"Martinique",code:"MQ",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"Martinique",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                    public static let Montserrat:JS = JS(name:"Montserrat",code:"MS",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"Montserrat",currency:"East Caribbean Dollar",currencyCode:"XCD",currencySymbol:"$")
                    public static let Saba:JS = JS(name:"Saba",code:"BQ-SA",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"Netherlands",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let SaintBarthelemy:JS = JS(name:"Saint Barthelemy",code:"BL",country:"France Overseas Region",type:.territory,region:.possession,flagImgName:"France",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                    public static let SaintEustatius:JS = JS(name:"Saint Eustatius",code:"BQ-SE",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"Netherlands",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let SaintMartin:JS = JS(name:"Saint Martin",code:"MF",country:"France Overseas Region",type:.territory,region:.possession,flagImgName:"France",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                    public static let SaintMaartin:JS = JS(name:"Saint Maartin",code:"SX",country:"Netherlands Antilles",type:.territory,region:.possession,flagImgName:"SaintMartin",currency:"Netherlands Antillean Guilder",currencyCode:"ANG",currencySymbol:"NAƒ")
                    public static let TurksAndCaicosIslands:JS = JS(name:"Turks and Caicos Islands",code:"TC",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"TurksAndCaicos",currency:"US Dollar",currencyCode:"USD",currencySymbol:"$")
                    public static let all:[JS] = [
                        Anguilla,Aruba,Bermuda,Bonaire,BritishVirginIslands,CaymanIslands,Curacao,Guadeloupe,
                        Martinique,Montserrat,Saba,SaintBarthelemy,SaintEustatius,SaintMartin,SaintMaartin,
                        TurksAndCaicosIslands
                    ].sorted(by: { ($0.name < $1.name) })
                }
            }
            
            public struct Other {
                public static let all:[JS] = [
                    Gibraltar,Guernsey,HongKong,IsleofMan,Jersey,Macau,BouvetIsland,ChristmasIsland,CocosIsland,
                    FalklandIslands,FaroeIslands,Greenland,HeardAndMcDonaldIslands,Mayotte,Reunion,SaintHelena,
                    Ascension,TristanDaCunha,SaintPierreAndMiquelon,SouthGeorgia,SandwichIslands,
                    SvalbardAndJanMayen,WesternSahara
                ].sorted(by: { ($0.name < $1.name) })
                
                public static let Gibraltar:JS = JS(name:"Gibraltar",code:"GI",country:"United Kingdom",type:.territory,region:.possession,flagImgName:"Gibraltar",currency:"Gibraltar Pound",currencyCode:"GIP",currencySymbol:"£")
                public static let Guernsey:JS = JS(name:"Guernsey",code:"GG",country:"United Kingdom",type:.territory,region:.possession,flagImgName:"United Kingdom",currency:"Guernsey Pound",currencyCode:"GGP",currencySymbol:"£")
                public static let HongKong:JS = JS(name:"Hong Kong",code:"HK",country:"China",type:.district,region:.possession,flagImgName:"HongKong",currency:"Hong Kong Dollar",currencyCode:"HKD",currencySymbol:"$")
                public static let IsleofMan:JS = JS(name:"Isle of Man",code:"IM",country:"United Kingdom",type:.territory,region:.possession,flagImgName:"IsleOfMan",currency:"Isle of Man Pound",currencyCode:"IMP",currencySymbol:"£")
                public static let Jersey:JS = JS(name:"Jersey",code:"JE",country:"United Kingdom",type:.territory,region:.possession,flagImgName:"Jersey",currency:"Jersey Pound",currencyCode:"JEP",currencySymbol:"£")
                public static let Macau:JS = JS(name:"Macau",code:"MO",country:"China",type:.district,region:.possession,flagImgName:"Macau",currency:"Pataca",currencyCode:"MOP",currencySymbol:"MOP$")
                public static let BouvetIsland:JS = JS(name:"Bouvet Island",code:"BV",country:"Norway",type:.territory,region:.possession,flagImgName:"Norway",currency:"Norwegian Krone",currencyCode:"NOK",currencySymbol:"kr")
                public static let ChristmasIsland:JS = JS(name:"Christmas Island",code:"CX",country:"Australia",type:.territory,region:.possession,flagImgName:"ChristmasIsland",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let CocosIsland:JS = JS(name:"Cocos Island",code:"CC",country:"Costa Rico",type:.territory,region:.possession,flagImgName:"CocosKeelingIslands",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let FalklandIslands:JS = JS(name:"Falkland Islands",code:"FK",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"FalklandIslands",currency:"Falkland Islands (Malvinas) Pound",currencyCode:"FKP",currencySymbol:"£")
                public static let FaroeIslands:JS = JS(name:"Faroe Islands",code:"FO",country:"United Kingdom",type:.territory,region:.possession,flagImgName:"FaroeIslands",currency:"Denmark Krona",currencyCode:"DKK",currencySymbol:"kr")
                public static let Greenland:JS = JS(name:"Greenland",code:"GL",country:"Denmark",type:.territory,region:.possession,flagImgName:"Greenland",currency:"Danish Krone",currencyCode:"DKK",currencySymbol:"kr")
                public static let HeardAndMcDonaldIslands:JS = JS(name:"Heard & McDonald Islands",code:"HM",country:"Australia",type:.territory,region:.possession,flagImgName:"Australia",currency:"Australia Dollar",currencyCode:"AUD",currencySymbol:"$")
                public static let Mayotte:JS = JS(name:"Mayotte",code:"YT",country:"France",type:.territory,region:.possession,flagImgName:"Mayotte",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let Reunion:JS = JS(name:"Reunion",code:"RE",country:"France",type:.territory,region:.possession,flagImgName:"France",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let SaintHelena:JS = JS(name:"Saint Helena",code:"SH",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"SaintHelena",currency:"Saint Helena Pound",currencyCode:"SHP",currencySymbol:"£")
                public static let Ascension:JS = JS(name:"Ascension",code:"SH",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"BritishIndianOceanTerritory",currency:"Saint Helena Pound",currencyCode:"SHP",currencySymbol:"£")
                public static let TristanDaCunha:JS = JS(name:"Tristan Da Cunha",code:"SH",country:"British Overseas Territory",type:.territory,region:.possession,flagImgName:"BritishIndianOceanTerritory",currency:"Saint Helena Pound",currencyCode:"SHP",currencySymbol:"£")
                public static let SaintPierreAndMiquelon:JS = JS(name:"Saint Pierre and Miquelon",code:"PM",country:"Saint Pierre and Miquelon",type:.territory,region:.possession,flagImgName:"SaintPierreAndMiquelon",currency:"Euro",currencyCode:"EUR",currencySymbol:"€")
                public static let SouthGeorgia:JS = JS(name:"South Georgia",code:"GS",country:"South Georia and the Sandwich Islands",type:.territory,region:.possession,flagImgName:"SouthGeorgia",currency:"Pound Sterling",currencyCode:"GBP",currencySymbol:"£")
                public static let SandwichIslands:JS = JS(name:"Sandwich Islands",code:"GS",country:"South Georia and the Sandwich Islands",type:.territory,region:.possession,flagImgName:"SouthGeorgia",currency:"Pound Sterling",currencyCode:"GBP",currencySymbol:"£")
                public static let SvalbardAndJanMayen:JS = JS(name:"Svalbard and Jan Mayen",code:"SJ",country:"Svalbard and Jan Mayen",type:.territory,region:.possession,flagImgName:"Norway",currency:"Norwegian Krone",currencyCode:"NOK",currencySymbol:"kr")
                public static let WesternSahara:JS = JS(name:"Western Sahara",code:"EH",country:"Western Sahara",type:.territory,region:.possession,flagImgName:"WesternSahara",currency:"Moroccan Dirham",currencyCode:"MAD",currencySymbol:"MAD")
            }
        }
    }

// MARK: ├─➤ FUNCTIONS
//    func returnISO_LocaleForCountryCode(code:String) -> String {
//        let itemsArray = Locale.availableIdentifiers
//
//        let matchingTerms = itemsArray.filter({
//            $0.range(of: code.uppercased() ) != nil
//        })
//
//        if matchingTerms.count > 0 {
//            return matchingTerms.first!
//        }
//
//        return ""
//    }
    
    public func returnCodeForCountryName(_ countryName:String) -> (found:Bool,code:String) {
        guard
            var code = Countries.all.filter({ $0.country.lowercased() == countryName.lowercased() }).first?.code
        else {
            return (found:false,code:"")
        }
        
        if (countryName == "U.S." || countryName == "U.S.A." || countryName == "USA") { 
            code = "US"
        }

        return (found:true,code:code)
    }
    
    public func returnCountryNameForCode(_ countryCode:String) -> String {
        let name = Countries.all.filter({ $0.code.lowercased() == countryCode.lowercased() }).first?.country ?? ""
        
        return name
    }
    
    public func returnCurrencyInfoForCurrencyCode(code:String) -> (found:Bool,name:String,code:String,symbol:String) {
        guard let arr = (Jurisdictions.Countries.all.filter({ $0.currencyCode == code }) as [JS]?) else {
            return (found:false,name:"n/a",code:"n/a",symbol:"n/a")
        }
        
        let name = arr.first?.currency ?? ""
        let code = arr.first?.currencyCode ?? ""
        let symbol = arr.first?.currencySymbol ?? ""
        
        return (found:true,name:name,code:code,symbol:symbol)
    }
    
    public func returnCountryNameForCode(code:String) -> (found:Bool,name:String) {
        guard let arr = (Jurisdictions.Countries.all.filter({ $0.code == code }) as [JS]?) else {
            return (found:false,name:"")
        }
        
        let name = arr.first?.name ?? ""

        return (found:true,name:name)
    }
    
    public func returnStateNameForCode(_ code:String) -> String {
        guard
            let found = Jurisdictions.US.States_DC_AllTerritories_ArmedForces.filter({ $0.code == code }).first
        else {
            return ""
        }
        
        let name = found.name ?? ""
        
        return name
    }

    public func returnStateCodeFor(_ name:String, jurisdictions:[JS]) -> (found:Bool,code:String) {
        guard
            let arr = (jurisdictions.filter({ $0.name == name }) as [JS]?)
        else {
            return (found:false,code:"")
        }
        
        let code = arr.first?.code ?? ""
        
        return (found:true,code:code)
    }
    
    public func returnInfo(jusridiction name:String) -> (
        found:Bool,name:String,code:String,country:String,type:Juristype,region:JurisRegion,flagImgName:String,
        currency:String,currencyCode:String,currencySymbol:String,codeISO:String
    ) {
        guard let arr = (Jurisdictions.Countries.all.filter(
            { $0.name.uppercased() == name.uppercased() ||
              $0.code.uppercased() == name.uppercased()}
            ) as [JS]?)
        else {
            return (found:false,
                    name:"",
                    code:"",
                    country:"",
                    type:.unknown,
                    region:.unknown,
                    flagImgName:"",
                    currency:"",
                    currencyCode:"",
                    currencySymbol:"",
                    codeISO:"")
        }

        let name = arr.first?.name ?? ""
        let code = arr.first?.code ?? ""
        let country = arr.first?.country ?? ""
        let type = arr.first?.type ?? Juristype.unknown
        let region = arr.first?.region ?? JurisRegion.unknown
        let flagImgName = arr.first?.flagImgName ?? ""
        let currency = arr.first?.currency ?? ""
        let currencyCode = arr.first?.currencyCode ?? ""
        let currencySymbol = arr.first?.currencySymbol ?? ""
        let codeISO = arr.first?.codeISO ?? ""
        
        return (found:true,
                name:name,
                code:code,
                country:country,
                type:type,
                region:region,
                flagImgName:flagImgName,
                currency:currency,
                currencyCode:currencyCode,
                currencySymbol:currencySymbol,
                codeISO:codeISO)
    }

    public func returnJurisdictionForCode(_ code:String,andType:Juristype) -> [JS] {
        guard
            let jurisdictions = (Jurisdictions.Countries.all.filter({ $0.code == code && $0.type == andType }) as [JS]?)
        else {
            return []
        }
        
        return jurisdictions
    }

    public func returnJurisdictionsForType(_ type:Juristype) -> (found:Bool,jurisdiction:[JS]) {
        guard let arr = (Jurisdictions.Countries.all.filter({ $0.type == type }) as [JS]?) else {
            return (found:false, jurisdiction:[])
        }
        
        return (found:true,jurisdiction:arr)
    }
    
    public func returnJurisdictionsForRegion(_ region:JurisRegion) -> (found:Bool,region:[JS]) {
        guard var countries = (Jurisdictions.Countries.all.filter({ $0.region == region }) as [JS]?) else {
            return (found:false, region:[])
        }

        countries.sort(by: { $0.name < $1.name })
        
        return (found:true,region:countries)
    }

    public func returnCountries() -> [JS] {
        guard var countries = (Jurisdictions.Countries.all.filter({ $0.type == .country }) as [JS]?) else {
            return []
        }

        countries.sort(by: { $0.name < $1.name })
        
        return countries
    }
}
