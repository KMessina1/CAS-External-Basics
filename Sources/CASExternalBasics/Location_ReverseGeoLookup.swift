/*-------------------------------------------------------------------------------------------------------------------------
     File: Location_ReverseGeoLookup.swift
   Author: Kevin Messina
  Created: 7/22/24
 Modified: 08/21/2026 05:06 PM EDT
  Version: 3
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import CoreLocation
import MapKit

public struct PlaceMarkDetails {
    public struct PlaceMarkInfo {
        public var name: String
        public var address: PlaceMarkInfo_AddressInfo
        public var timeZone: PlaceMarkInfo_TimeZoneInfo
        public var region: PlaceMarkInfo_RegionInfo
        public var coordinate: PlaceMarkInfo_CoordinateInfo

        public init(
            name: String = "",
            address: PlaceMarkInfo_AddressInfo = PlaceMarkInfo_AddressInfo(),
            timeZone: PlaceMarkInfo_TimeZoneInfo = PlaceMarkInfo_TimeZoneInfo(),
            region: PlaceMarkInfo_RegionInfo = PlaceMarkInfo_RegionInfo(),
            coordinate: PlaceMarkInfo_CoordinateInfo = PlaceMarkInfo_CoordinateInfo()
        ) {
            self.name = name
            self.address = address
            self.timeZone = timeZone
            self.region = region
            self.coordinate = coordinate
        }
    }
    
    public struct PlaceMarkInfo_AddressInfo {
        public var address1: String
        public var address2: String
        public var city: String
        public var neighborhood: String
        public var county: String
        public var state: String
        public var zip: String
        public var country: String

        public init(
            address1: String = "",
            address2: String = "",
            city: String = "",
            neighborhood: String = "",
            county: String = "",
            state: String = "",
            zip: String = "",
            country: String = ""
        ) {
            self.address1 = address1
            self.address2 = address2
            self.city = city
            self.neighborhood = neighborhood
            self.county = county
            self.state = state
            self.zip = zip
            self.country = country
        }
    }
    
    public struct PlaceMarkInfo_TimeZoneInfo {
        public var identifier: String
        public var description: String
        public var abbrev: String
        public var hours: Double

        public init(
            identifier: String = "",
            description: String = "",
            abbrev: String = "",
            hours: Double = 0.0
        ) {
            self.identifier = identifier
            self.description = description
            self.abbrev = abbrev
            self.hours = hours
        }
    }
    
    public struct PlaceMarkInfo_RegionInfo {
        public var region: String
        public var countryCode: String

        public init(region: String = "", countryCode: String = "") {
            self.region = region
            self.countryCode = countryCode
        }
    }

    public struct PlaceMarkInfo_CoordinateInfo {
        public var latitude: Double
        public var longitude: Double
        public var altitude: Double

        public init(latitude: Double = 0.0, longitude: Double = 0.0, altitude: Double = 0.0) {
            self.latitude = latitude
            self.longitude = longitude
            self.altitude = altitude
        }
    }

    public init() {}

    @MainActor
    public func getPlaceMarkFrom(address: String) async -> PlaceMarkInfo? {
        guard let request = MKGeocodingRequest(addressString: address) else {
            return nil
        }

        do {
            guard let mapItem = try await request.mapItems.first else {
                return nil
            }

            return placeMarkInfo(from: mapItem)
        } catch {
            print("Error geocoding address: \(error.localizedDescription)")
            return nil
        }
    }
    
    @MainActor
    public func getPlaceMark(for location: CLLocation) async -> PlaceMarkInfo? {
        guard let request = MKReverseGeocodingRequest(location: location) else {
            return nil
        }

        do {
            guard let mapItem = try await request.mapItems.first else {
                return nil
            }

            return placeMarkInfo(from: mapItem)
        } catch {
            print("Error in reverse geocoding: \(error.localizedDescription)")
            return nil
        }
    }

    private func placeMarkInfo(from mapItem: MKMapItem) -> PlaceMarkInfo {
        let representations = mapItem.addressRepresentations
        let location = mapItem.location
        let timeZone = mapItem.timeZone
        let fullAddress = representations?.fullAddress(includingRegion: true, singleLine: true)
            ?? mapItem.address?.fullAddress
            ?? ""
        let shortAddress = mapItem.address?.shortAddress ?? ""

        return PlaceMarkInfo(
            name: mapItem.name ?? "n/a",
            address: PlaceMarkInfo_AddressInfo(
                address1: addressLine(from: shortAddress),
                address2: "n/a",
                city: representations?.cityName ?? "n/a",
                neighborhood: "n/a",
                county: "n/a",
                state: stateCode(from: representations),
                zip: postalCode(from: fullAddress),
                country: representations?.regionName ?? "n/a"
            ),
            timeZone: PlaceMarkInfo_TimeZoneInfo(
                identifier: timeZone?.identifier ?? "n/a",
                description: timeZone?.description ?? "n/a",
                abbrev: timeZone?.abbreviation(for: Date()) ?? "n/a",
                hours: Double(timeZone?.secondsFromGMT(for: Date()) ?? 0) / 3600.0
            ),
            region: PlaceMarkInfo_RegionInfo(
                region: representations?.regionName ?? "n/a",
                countryCode: representations?.region?.identifier ?? "n/a"
            ),
            coordinate: PlaceMarkInfo_CoordinateInfo(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                altitude: Measurement(value: location.altitude, unit: UnitLength.meters)
                    .converted(to: .feet)
                    .value
            )
        )
    }

    private func addressLine(from shortAddress: String) -> String {
        shortAddress
            .split(separator: ",", maxSplits: 1)
            .first
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .flatMap { $0.isEmpty ? nil : $0 }
            ?? "n/a"
    }

    private func stateCode(from representations: MKAddressRepresentations?) -> String {
        guard let context = representations?.cityWithContext(.short) else {
            return "n/a"
        }

        let components = context.split(separator: ",")
        guard components.count > 1 else {
            return "n/a"
        }

        return components[1]
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ")
            .first
            .map(String.init)
            ?? "n/a"
    }

    private func postalCode(from fullAddress: String) -> String {
        guard let range = fullAddress.range(
            of: #"\b\d{5}(?:-\d{4})?\b"#,
            options: .regularExpression
        ) else {
            return "n/a"
        }

        return String(fullAddress[range])
    }
}
