/*-------------------------------------------------------------------------------------------------------------------------
     File: MailHelper.swift
   Author: Kevin Messina
  Created: 9/29/20
 Modified: 08/21/2026 05:38 PM EDT
  Version: 5
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import CASExternalFoundations
import SwiftUI
import MessageUI
import AVFoundation
import Foundation

/* USAGE DIRECTIONS:
 
 @State var showMail:Bool = false

 // Placed in functionality....
 Button {
    mailData = ComposeMailData(type: .contact, recipients:[employee.email])
    showMail.toggle()
 } label: {
    Label("Send Email to \"\(name)\"", systemImage: appImages.email.rawValue)
 }//End Button
 .disabled(employee.email.isEmpty || !EmailHelper.shared.canSendMail())
 .sheet(isPresented: $showMail) {
    MailHelper.MailView(data: $mailData) { result in
    switch result {
        case .success(_): showMailSent.toggle()
        case .failure(_): showMailFailed.toggle()
    }
 
    SimPrint.Info(type: .info, msg: result, log: logFileFunctionLine())
 }

*/
typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

public struct MailSheet: View {
    @Binding var data: MailHelper.ComposeMailData
    @Binding var result: Result<MFMailComposeResult, Error>?
    var onResult: (Result<MFMailComposeResult, Error>) -> Void

    public init(
        data: Binding<MailHelper.ComposeMailData>,
        result: Binding<Result<MFMailComposeResult, Error>?>,
        onResult: @escaping (Result<MFMailComposeResult, Error>) -> Void
    ) {
        self._data = data
        self._result = result
        self.onResult = onResult
    }

    public var body: some View {
        MailHelper.MailView(data: $data, result: $result)
            .onDisappear {
                if let result {
                    onResult(result)
                }
            }
    }
}

/// MailHelper
/// ---
/// ie: @State private var mailData = ComposeMailData(subject: .contact)
///     @State private var mailData = ComposeMailData(
///         subject: .other,
///         recipients: ["a@yahoo.com"],
///         message:"Hello",
///         attachments:[AttachmentData(data: "Some text".data(using: .utf8)!,mimeType: "text/plain",fileName: "text.txt")]
///     )
///
///     MailHelper.shared.canSendMail() ? showMailView.toggle() : showAlertNoMail.toggle()
///
public class MailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = MailHelper()
    public override init() {
        super.init()
    }

    public enum MailAvailability {
        case nativeCompose      // Apple Mail app is configured
        case thirdPartyDefault  // Gmail/Outlook/etc. is set as default
        case unavailable        // No mail account or app is setup
        
        public var name: String {
            switch self {
            case .nativeCompose: return " Mail"
            case .thirdPartyDefault: return "Third Party"
            case .unavailable: return "Unavailalbe"
            }
        }
    }

    public enum MailSubjectType: Int {
        case suggestion
        case support
        case contact
        case tellAFriend
        case other
        case supportSendData
        
        var note: String {
            switch self {
            case .suggestion: return "‼️ NOTE: If you have a suggestion for changing an existing feature, please attach a screenshot if applicable. If its a new feature please, please write New Feature. In either case, please try and explain (long descriptions are better) so that we can best understand the suggestion.<br>"
            case .support: return "‼️ NOTE: If you are having a technical issue, please attach screen shots that would be helpful explaining your issue.<br>"
            case .contact, .tellAFriend, .other: return ""
            case .supportSendData: return "‼️ NOTE: If you are having a technical issue, please attach screen shots that would be helpful explaining your issue.<br><br>Remember that you are sending text of your data to our Support Team, some of which my be considered private information.<br>br>Please know that we will treat your data with respect to your privacy, will not distribute, copy or sell to anyone.<br><br>Your data will be deleted upon completion of your support request or sooner if requested in writing to our Support Team."
            }
        }

        func msg(appStoreURL: String) -> String {
            //App Info
            let appName:String = (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String) ?? "n/a"
            let version:String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "n/a"
            let build:String = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "n/a"
            //Device Info
            let osVersion = UIDevice.current.systemVersion
            let family = UIDevice.Family().typeIs()
            let model = UIDevice.modelName
            let txt =
            """
            TECHNICAL INFO:<br>
            ----------------------<br>
               App Info: \(appName) v\(version).\(build)<br>
              Device OS: \(osVersion)<br>
            Device Type: \(family)<br>
            Device Model: \(model)<br>
            ----------------------<br>
            \(note)<br><br>
            ======================<br><br>
            Comments:<br><br>
            """

            switch self {
                case .tellAFriend: return "Check out \(appName) in the AppStore:<br><br>\(appStoreURL)<br><br>I think you will like it.<br><br>"
                default: return txt
            }
        }

        var subject: String {
            let appName = (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String) ?? "n/a"
            switch self {
            case .suggestion: return "Suggestion for \(appName)..."
            case .support, .supportSendData: return "Support and Data for \(appName)..."
            case .contact: return "Contact from \(appName)..."
            case .tellAFriend: return "I am recommending the app '\(appName)' for you..."
            case .other: return ""
            }
        }
        
        func recipients(contactEmail: String, supportEmail: String) -> [String] {
            switch self {
            case .suggestion, .contact: return [contactEmail]
            case .support, .supportSendData: return [supportEmail]
            default: return []
            }
        }
    }

    public enum MimeTypes: String {
        //Audio
        case audioAAC = "audio/aac" //AAC audio
        case audioMPEG = "audio/mpeg" //MP3 audio
        case audioWAV = "audio/wav" //Waveform Audio Format
        //Binary
        case binary = "application/octet-stream" //Binary files (default for attachments)
        //Images
        case imageJPEG = "image/jpeg" //JPEG image files
        case imagePNG = "image/png" //PNG image files
        case imageTIFF = "image/tiff" //Tagged Image File Format (TIFF)
        //Data
        case JSON = "application/json" //Used for JSON Data
        //Text
        case textPlain = "text/plain" //Simple text messages (default for email body)
        case textHTML = "text/html" //HTML formatted email body
        case textCSV = "text/csv" //Comma-separated values (CSV)
        //Mail Message
        case message = "message/rfc822" //Used for forwarding or replying with the original message as an attachment
        //Mail Attachments
        case mixed = "multipart/mixed" //Used for emails with attachments, containing both text and other parts
        //PDF
        case pdf = "application/pdf" //PDF documents
        //Video
        case videoMP4 = "video/mp4" //MP4 video
        case videoMPEG = "video/mpeg" //MPEG Video
        //Zip/Archive
        case zipArchive = "application/zip" //ZIP archive
    }

    public var canSendMail: Bool {
        return getMailAvailability() != .unavailable
    }

    public struct AttachmentDataInfo {
        public var data: Data
        public var mimeType: MimeTypes
        public var fileName: String

        public init(data: Data, mimeType: MimeTypes, fileName: String) {
            self.data = data
            self.mimeType = mimeType
            self.fileName = fileName
        }
    }

    public struct ComposeMailData {
        public var type: MailSubjectType
        public var appStoreURL: String
        public var contactEmail: String
        public var supportEmail: String
        public var subject: String?
        public var recipients: [String]?
        public var message: String?
        public var attachments: [AttachmentDataInfo]?

        public init(
            type: MailSubjectType,
            appStoreURL: String,
            contactEmail: String,
            supportEmail: String,
            subject: String? = "",
            recipients: [String]? = [],
            message: String? = "",
            attachments: [AttachmentDataInfo]? = []
        ) {
            self.type = type
            self.appStoreURL = appStoreURL
            self.contactEmail = contactEmail
            self.supportEmail = supportEmail
            self.subject = subject
            self.recipients = recipients
            self.message = message
            self.attachments = attachments
        }
    }

    public func getMailAvailability() -> MailAvailability {
        // 1. Check if native MessageUI can send (Apple Mail only)
        if MFMailComposeViewController.canSendMail() {
            return .nativeCompose
        }
        
        // 2. Check if the system can open a mailto link (Third-party default)
        // Note: requires "mailto" in LSApplicationQueriesSchemes in Info.plist
        let mailtoURL = URL(string: "mailto:")!
        if UIApplication.shared.canOpenURL(mailtoURL) {
            return .thirdPartyDefault
        }
        
        return .unavailable
    }
    
    public struct MailView: UIViewControllerRepresentable {
        @Environment(\.dismiss) private var dismiss
        @Binding var data: ComposeMailData
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        public init(
            data: Binding<ComposeMailData>,
            result: Binding<Result<MFMailComposeResult, Error>?>
        ) {
            self._data = data
            self._result = result
        }

        public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
            var parent: MailView
            
            init(_ parent: MailView) {
                self.parent = parent
            }
            
            public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                defer {
                    parent.dismiss()
                }
                if let error = error {
                    parent.result = .failure(error)
                } else {
                    parent.result = .success(result)
                }
            }
        }
        
        public func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        public func makeUIViewController(context: Context) -> MFMailComposeViewController {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = context.coordinator
            vc.setToRecipients(
                data.type.recipients(
                    contactEmail: data.contactEmail,
                    supportEmail: data.supportEmail
                )
            )
            vc.setSubject(data.type.subject)
            vc.setMessageBody(data.type.msg(appStoreURL: data.appStoreURL), isHTML: true)
                
            if let attachments = data.attachments {
                for attachment in attachments {
                    vc.addAttachmentData(attachment.data, mimeType: attachment.mimeType.rawValue, fileName: attachment.fileName)
                }
            }
            return vc
        }
        
        public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }
    }
}
