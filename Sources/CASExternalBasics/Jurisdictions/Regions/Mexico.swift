/*-------------------------------------------------------------------------------------------------------------------------
     File: Mexico.swift
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
    public struct Mexico  {
        public static let all:[JS] = States.all.sorted(by: { ($0.name < $1.name) })
        
        public struct States {
            public static let Aguascalientes:JS = JS(
                name:"Aguascalientes",
                code:"AG",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let BajaCalifornia:JS = JS(
                name:"Baja California",
                code:"BC",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let BajaCaliforniaSur:JS = JS(
                name:"Baja California Sur",
                code:"BS",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Campeche:JS = JS(
                name:"Campeche",
                code:"CM",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Coahuila:JS = JS(
                name:"Coahuila",
                code:"CO",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Colima:JS = JS(
                name:"Colima",
                code:"CL",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Chiapas:JS = JS(
                name:"Chiapas",
                code:"CS",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Chihuahua:JS = JS(
                name:"Chihuahua",
                code:"CH",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Durango:JS = JS(
                name:"Durango",
                code:"DG",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Guanajuato:JS = JS(
                name:"Guanajuato",
                code:"GT",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Guerrero:JS = JS(
                name:"Guerrero",
                code:"GR",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Hidalgo:JS = JS(
                name:"Hidalgo",
                code:"HG",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Jalisco:JS = JS(
                name:"Jalisco",
                code:"JA",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Mexico:JS = JS(
                name:"Mexico",
                code:"EM",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let MexicoCity:JS = JS(
                name:"Mexico City",
                code:"DF",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Michoacan:JS = JS(
                name:"Michoacan",
                code:"MI",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Morelos:JS = JS(
                name:"Morelos",
                code:"MO",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Nayarit:JS = JS(
                name:"Nayarit",
                code:"NA",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let NuevoLeón:JS = JS(
                name:"Nuevo León",
                code:"NL",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Oaxaca:JS = JS(
                name:"Oaxaca",
                code:"OA",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Puebla:JS = JS(
                name:"Puebla",
                code:"PU",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Queretaro:JS = JS(
                name:"Queretaro",
                code:"QT",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let QuintanaRoo:JS = JS(
                name:"Quintana Roo",
                code:"QR",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let SanLuisPotosi:JS = JS(
                name:"San Luis Potosi",
                code:"SL",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Sinaloa:JS = JS(
                name:"Sinaloa",
                code:"SI",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Sonora:JS = JS(
                name:"Sonora",
                code:"SO",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Tabasco:JS = JS(
                name:"Tabasco",
                code:"TB",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Tamaulipas:JS = JS(
                name:"Tamaulipas",
                code:"TM",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Tlaxcala:JS = JS(
                name:"Tlaxcala",
                code:"TL",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Veracruz:JS = JS(
                name:"Veracruz",
                code:"VE",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Yucatán:JS = JS(
                name:"Yucatán",
                code:"YU",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
            public static let Zacatecas:JS = JS(
                name:"Zacatecas",
                code:"ZA",
                country:"Mexico",
                type:.state,
                region:.country,
                flagImgName:"Mexico",
                currency:"Mexico Peso",
                currencyCode:"MXN",
                currencySymbol:"$"
            )
    
            public static let all:[JS] =
                [Aguascalientes,BajaCalifornia,BajaCaliforniaSur,Campeche,Coahuila,Colima,Chiapas,Chihuahua,Durango,
                Guanajuato,Guerrero,Hidalgo,Jalisco,Mexico,MexicoCity,Michoacan,Morelos,Nayarit,NuevoLeón,Oaxaca,Puebla,Queretaro,QuintanaRoo,
                SanLuisPotosi,Sinaloa,Sonora,Tabasco,Tamaulipas,Tlaxcala,Veracruz,Yucatán,Zacatecas]
                .sorted(by: { ($0.name < $1.name) })
            
            public static var arrNames:[String] {
                var states:[String] = []
                
                States.all.forEach { (stateStruct) in
                    states.append( stateStruct.name )
                }
                
                return states.sorted()
            }
        }
    }
}
