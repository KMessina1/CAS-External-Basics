/*-------------------------------------------------------------------------------------------------------------------------
     File: Location_OpenElevation.swift
   Author: Kevin Messina
  Created: 3/1/26
 Modified: 08/21/2026 05:10 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
Uses the OpenTopoData elevation API.
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation

public final class LocationOpenElevation: NSObject {
    private struct ElevationResponse: Decodable {
        let status: String
        let results: [ElevationResult]
    }

    private struct ElevationResult: Decodable {
        let elevation: Double
        let dataset: String
    }

    public override init() {
        super.init()
    }

    public func fetchElevation(
        lat: Double,
        lon: Double
    ) async -> (status: String, elevation_m: Double, elevation_ft: Double, dataset: String) {
        let urlString = "https://api.opentopodata.org/v1/ned10m?locations=\(lat),\(lon)"

        guard let url = URL(string: urlString) else {
            return ("Invalid URL", 0, 0, "")
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let response = response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode) {
                return ("HTTP Error: \(response.statusCode)", 0, 0, "")
            }

            let decoded = try JSONDecoder().decode(ElevationResponse.self, from: data)

            guard let result = decoded.results.first else {
                return (decoded.status, 0, 0, "No Results")
            }

            return (
                decoded.status,
                result.elevation,
                result.elevation * 3.280_839_895,
                result.dataset
            )
        } catch {
            return ("Error: \(error.localizedDescription)", 0, 0, "")
        }
    }
}
