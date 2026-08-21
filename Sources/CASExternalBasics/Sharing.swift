/*-------------------------------------------------------------------------------------------------------------------------
     File: Sharing.swift
   Author: Kevin Messina
  Created: 6/19/22
 Modified: 08/21/2026 04:12 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import UIKit
import SwiftUI

public struct ActivityViewController: UIViewControllerRepresentable {
    public var itemsToShare: [Any]
    public var servicesToShareItem: [UIActivity]?

    public init(
        itemsToShare: [Any],
        servicesToShareItem: [UIActivity]? = nil
    ) {
        self.itemsToShare = itemsToShare
        self.servicesToShareItem = servicesToShareItem
    }

    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<ActivityViewController>
    ) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: servicesToShareItem
        )
    }

    public func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityViewController>
    ) {
    }
}
