/*-------------------------------------------------------------------------------------------------------------------------
     File: Location.swift
   Author: Kevin Messina
  Created: 7/19/24
 Modified: 08/21/2026 04:43 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
The app must have location permission description in `Info.plist`.
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import CoreLocation
import CASExternalFoundations

// Isolate the CLLocationManagerDelegate conformance to the main actor to satisfy Swift 6 actor-isolation rules.
@MainActor
public final class LocationManager: NSObject, @MainActor CLLocationManagerDelegate {
    public private(set) var location: CLLocation? = nil
    public private(set) var lat: Double = 0.0
    public private(set) var lon: Double = 0.0
    public private(set) var alt: Double = 0.0

    private let manager = CLLocationManager()

    public override init() {
        super.init()
        manager.delegate = self
    }
        
    public func requestUserAuthorization() async throws {
        manager.requestWhenInUseAuthorization()
        SimPrint.Info("Location Manager: Request Authorization From User...", action: .info, subType: .API_Location, log: "")
    }
    
    public func startCurrentLocationUpdates() {
        manager.startUpdatingLocation()
        SimPrint.Info("Location Manager: Start Updating Location Services...", action: .info, subType: .API_Location, log: "")
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            SimPrint.Info("Location Manager: No records found. Exiting didUpdateLocations delegate.", action: .error, log: "")
            return
        }
        
        self.location = location
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        alt = location.altitude

        let altTxt = alt.formatted(.number.precision(.fractionLength(2)))
        let txt = "Location Manager: Found Location (Latitude: \(lat), Longitude: \(lon), Altitude: \(altTxt))"
        SimPrint.Info(txt, action: .success, subType: .API_Location, log: LFFL())

        manager.stopUpdatingLocation()
        SimPrint.Info("Location Manager: Stopped Updating Location Services...", action: .info, subType: .API_Location, log: "")
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        SimPrint.Info("Location Manager Error: \(error)", action: .error, log: LFFL())
    }
}
