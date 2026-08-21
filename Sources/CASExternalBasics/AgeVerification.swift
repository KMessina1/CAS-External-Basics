/*-------------------------------------------------------------------------------------------------------------------------
     File: AgeVerification.swift
   Author: Kevin Messina
  Created: 11/25/25
 Modified: 08/21/2026 02:26 PM EDT
  Version: 3
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import DeclaredAgeRange
import CASExternalFoundations

public enum AgeRangeAlertType: Int, Sendable {
    case none
    case ageValidationFailed
    case ageValidationDeclined
    case ageValidationInvalid
    case ageValidationNotAvailable
    case ageValidationError
    case ageValidationPassed
}

public enum AgeRange: Int, Codable, CaseIterable, Identifiable {
    case minAge
    case regionAssurance
    case isSufficient

    public var id: Int { rawValue }

    public var keyName: String {
        switch self {
        case .minAge: return "DeclaredAge.minimum"
        case .regionAssurance: return "DeclaredAge.regionRequires"
        case .isSufficient: return "DeclaredAge.isSufficient"
        }
    }
}

public func checkRegionForAgeRequirement(completion: @escaping (Bool) -> Void) {
    if #available(iOS 26.2, *) {
        Task {
            do {
                let isEligible = try await AgeRangeService.shared.isEligibleForAgeFeatures
                completion(isEligible)
            } catch {
                SimPrint.Info(
                    "AGE VERIFICATION: Region Eligibility check failed.",
                    action: .error,
                    errorMsg: error.localizedDescription,
                    log: LFFL()
                )
                completion(false)
            }
        }
    } else {
        completion(true)
    }
}

@available(iOS 26.0, *)
public func requestAgeRangeHelper(
    requestAgeRange: DeclaredAgeRangeAction,
    completion: @escaping (Bool, Bool, AgeRangeAlertType) -> Void
) {
    if deviceIs.CanvasPreview || deviceIs.Sim {
        SimPrint.Info(
            "AGE VERIFICATION: Unsupported while running in Simulator or CanvasPreview.",
            action: .info,
            log: LFFL()
        )

        completion(true, false, .none)
        return
    }

    checkRegionForAgeRequirement { isRegionRegulated in
        if !isRegionRegulated {
            SimPrint.Info(
                "AGE VERIFICATION: Region does not require age assurance.",
                action: .info,
                log: LFFL()
            )

            completion(true, false, .none)
            return
        }

        var minAge = UserDefaults.standard.integer(forKey: AgeRange.minAge.keyName)
        if minAge >= 16 {
            let isSufficient = true
            SimPrint.Info(
                "AGE VERIFICATION: Stored value is sufficient (YES)",
                action: .success,
                log: LFFL()
            )

            completion(isSufficient, isRegionRegulated, .none)
            return
        } else {
            minAge = 16
            UserDefaults.standard.set(minAge, forKey: AgeRange.minAge.keyName)
            UserDefaults.standard.synchronize()
        }

        Task {
            do {
                let response = try await requestAgeRange(ageGates: minAge)
                let resultIsSufficient: Bool
                let resultType: AgeRangeAlertType

                switch response {
                case let .sharing(range):
                    if let lowerBound = range.lowerBound {
                        resultIsSufficient = lowerBound >= minAge
                        resultType = resultIsSufficient ? .ageValidationPassed : .ageValidationFailed
                        SimPrint.Info(
                            "AGE VERIFICATION: Sharing response received for range \(lowerBound), Sufficient: (\(resultIsSufficient.asYesNo))",
                            action: .success,
                            log: LFFL()
                        )
                    } else {
                        resultIsSufficient = false
                        resultType = .ageValidationError
                        SimPrint.Info(
                            "AGE VERIFICATION: ageValidationError",
                            action: .info,
                            log: LFFL()
                        )
                    }

                case .declinedSharing:
                    resultIsSufficient = false
                    resultType = .ageValidationDeclined
                    SimPrint.Info(
                        "AGE VERIFICATION: ageValidationDeclined",
                        action: .info,
                        log: LFFL()
                    )

                @unknown default:
                    resultIsSufficient = false
                    resultType = .ageValidationError
                    SimPrint.Info(
                        "AGE VERIFICATION: ageValidationError",
                        action: .info,
                        log: LFFL()
                    )
                }

                DispatchQueue.main.async {
                    completion(resultIsSufficient, isRegionRegulated, resultType)
                }
            } catch DeclaredAgeRange.AgeRangeService.Error.invalidRequest {
                SimPrint.Info(
                    "AGE VERIFICATION: ageValidationInvalid",
                    action: .info,
                    log: LFFL()
                )
                DispatchQueue.main.async {
                    completion(false, isRegionRegulated, .ageValidationInvalid)
                }
            } catch {
                SimPrint.Info(
                    "AGE VERIFICATION: ageValidationError",
                    action: .info,
                    log: LFFL()
                )
                DispatchQueue.main.async {
                    completion(false, isRegionRegulated, .ageValidationError)
                }
            }
        }
    }
}
