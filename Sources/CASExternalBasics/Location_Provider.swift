/*-------------------------------------------------------------------------------------------------------------------------
     File: Location_Provider.swift
   Author: Kevin Messina
  Created: 2/3/26
 Modified: 08/21/2026 05:10 PM EDT
  Version: 3
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
The app must have location permission description in `Info.plist`.

2026_02_01: Added Geolocation to returned location values in addition to the original core location values.
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import CoreLocation
import MapKit
import CASExternalFoundations

public final class LocationProvider: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var hasCompleted = false
    private var continuation: CheckedContinuation<
        (lat: Double, lon: Double, alt: Double, street: String, city: String, state: String, zip: String)?,
        Error
    >?

    public override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    /// Fetches the current location once and returns specific values.
    public func fetchCurrentLocation() async throws -> (
        lat: Double,
        lon: Double,
        alt: Double,
        street: String,
        city: String,
        state: String,
        zip: String
    )? {
        hasCompleted = false

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
    }

    private func extractZipFromEndOfAddress(_ address: String) -> String {
        let segments = address.components(separatedBy: ",")
        guard let lastSegment = segments.last?.trimmingCharacters(in: .whitespaces) else { return "" }
        
        let pattern = #"\d{5}(?:-\d{4})?"#
        if let range = lastSegment.range(of: pattern, options: .regularExpression) {
            return String(lastSegment[range])
        }
        return ""
    }
    
    private func finish(
        returning value: (
            lat: Double,
            lon: Double,
            alt: Double,
            street: String,
            city: String,
            state: String,
            zip: String
        )?
    ) {
        guard !hasCompleted else { return }
        
        hasCompleted = true
        if let currentContinuation = continuation {
            currentContinuation.resume(returning: value)
            continuation = nil
        }
        manager.stopUpdatingLocation()
    }

    private func finish(throwing error: Error) {
        guard !hasCompleted else { return }
        
        hasCompleted = true
        if let currentContinuation = continuation {
            currentContinuation.resume(throwing: error)
            continuation = nil
        }
        manager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !hasCompleted else { return }
        guard let location = locations.first else {
            finish(returning: nil)
            return
        }

        var result: (lat: Double, lon: Double, alt: Double, street: String, city: String, state: String, zip: String) = (
            lat: 0.0,
            lon: 0.0,
            alt: 0.0,
            street: "",
            city: "",
            state: "",
            zip: ""
        )
        
        let request = MKReverseGeocodingRequest(location: location)

        Task {
            do {
                let mapItems = try await request?.mapItems
                if let mapItem = mapItems?.first,
                   let representations = mapItem.addressRepresentations,
                   let address = mapItem.address {
                    var streetAddress = ""
                    var city = ""
                    var state = ""
                    var zip = ""
                    
                    if let contextString = address.shortAddress {
                        let components = contextString.components(separatedBy: ",")
                        if components.count > 1 {
                            streetAddress = components.first?.trimmingCharacters(in: .whitespaces) ?? ""
                        }
                    }

                    city = representations.cityName ?? dashesTxt
                    
                    if let contextString = representations.cityWithContext(.short) {
                        let components = contextString.components(separatedBy: ",")
                        if components.count > 1 {
                            state = components.last?.trimmingCharacters(in: .whitespaces) ?? ""
                        }
                    }
                    
                    if let fullAddr = representations.fullAddress(includingRegion: false, singleLine: true) {
                        zip = extractZipFromEndOfAddress(fullAddr)
                    }
                    
                    result = (
                        lat: Double(location.coordinate.latitude),
                        lon: Double(location.coordinate.longitude),
                        alt: Double(location.altitude.convert_m_feet),
                        street: streetAddress,
                        city: city,
                        state: state,
                        zip: zip
                    )

                    finish(returning: result)
                } else {
                    finish(returning: nil)
                }
            } catch {
                print("Geocoding error: \(error.localizedDescription)")
                finish(throwing: error)
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finish(throwing: error)
    }
}
