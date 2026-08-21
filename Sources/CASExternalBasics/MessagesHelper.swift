/*-------------------------------------------------------------------------------------------------------------------------
     File: MessagesHelper.swift
   Author: Kevin Messina
  Created: 7/16/23
 Modified: 08/21/2026 05:31 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import MessageUI
import SwiftUI
import CASExternalFoundations

protocol MessagesViewDelegate {
    func messageCompletion(result: MessageComposeResult)
}

public class MessagesViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    var delegate: MessagesViewDelegate?
    var recipients: [String]?
    var subject: String?
    var body: String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController ()
        composeVC.messageComposeDelegate = self
        composeVC.recipients = self.recipients ?? []
        composeVC.body = body ?? ""
        
        if MessageView.canSendText() {
            self.present (composeVC, animated: true, completion: nil)
        } else {
            self.delegate?.messageCompletion(result: MessageComposeResult.failed)
        }
    }

    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss (animated: true)
        self.delegate?.messageCompletion(result: result)
    }
}

public struct MessageView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var recipients: [String]
    @Binding var subject: String
    @Binding var body: String
    
    var completion: ((_ result: MessageComposeResult) -> Void)
    
    public init(
        recipients: Binding<[String]>,
        subject: Binding<String>,
        body: Binding<String>,
        completion: @escaping (_ result: MessageComposeResult) -> Void
    ) {
        self._recipients = recipients
        self._subject = subject
        self._body = body
        self.completion = completion
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: Context) -> MessagesViewController {
        let controller = MessagesViewController()
        controller.delegate = context.coordinator
        controller.recipients = recipients
        controller.subject = subject
        controller.body = body
        
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: MessagesViewController, context: Context) {
        uiViewController.recipients = recipients
        if MessageView.canSendSubject() {
            uiViewController.subject = subject
        }else{
            SimPrint.Info("Cannot Send Text Subject", action: .txtMsg_NoSubject, log: LFFL())
        }
        uiViewController.body = body
        if MessageView.canSendAttachments() {
            //Place attachment code here...
        }else{
            SimPrint.Info("Cannot Send Text Attachments", action: .txtMsg_NoAttachment, log: LFFL())
        }
        uiViewController.displayMessageInterface()
    }
    
    public class Coordinator: NSObject, UINavigationControllerDelegate, MessagesViewDelegate {
        var parent: MessageView
        
        init(_ controller: MessageView) {
            self.parent = controller
        }
        
        func messageCompletion (result: MessageComposeResult) {
            self.parent.presentationMode.wrappedValue.dismiss ()
            self.parent.completion(result)
        }
    }
    
    public static func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    public static func canSendAttachments() -> Bool {
        return MFMessageComposeViewController.canSendAttachments()
    }
    
    public static func canSendSubject() -> Bool {
        return MFMessageComposeViewController.canSendSubject()
    }
}

//class MessagesViewController: UIViewController, MFMessageComposeViewControllerDelegate {
//    var delegate: MessagesViewDelegate?
//    var recipients: [String]?
//    var subject: String?
//    var body: String?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    func displayMessageInterface() {
//        let composeVC = MFMessageComposeViewController()
//        composeVC.messageComposeDelegate = self
//        
//        composeVC.recipients = self.recipients ?? []
//        composeVC.subject = self.subject ?? ""
//        composeVC.body = body ?? ""
//        
//        if MFMessageComposeViewController.canSendText() {
//            self.present(composeVC, animated: true, completion: nil)
//        } else {
//            self.delegate?.messageCompletion(result: MessageComposeResult.failed)
//        }
//    }
//    
//    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//        controller.dismiss(animated: true)
//        self.delegate?.messageCompletion(result: result)
//    }
//}
//
///*
// 
//USAGE:
// // Messages Params
// @State var showMsgView:Bool = false
// @State private var txtRecipients: [String] = []
// @State private var txtSubject: String = "App Recomendation..."
// @State private var txtMsg: String = "I am recommending an AppStore app, '\(AppInfo.appName)' that I think you would like..."
//
// ...
// 
//    .sheet(isPresented: $showMsgView) {
//        MessageUIView(recipients: $txtRecipients, subject: $txtSubject, body: $txtMsg) { result in
//            switch result {
//                case .cancelled: break
//                case .sent:
//                    activeAlert = .textSent
//                    showAlert.toggle()
//                case .failed:
//                    activeAlert = .textFailed
//                    showAlert.toggle()
//                @unknown default: break
//            }
//        }
//    }
//*/
//struct MessageUIView: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) var presentationMode
//    
//    @Binding var recipients: [String]
//    @Binding var subject: String
//    @Binding var body: String
//    var completion: ((_ result: MessageComposeResult) -> Void)
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    func makeUIViewController(context: Context) -> MessagesViewController {
//        let controller = MessagesViewController()
//        controller.delegate = context.coordinator
//        controller.recipients = recipients
//        controller.subject = subject
//        controller.body = body
//        
//        return controller
//    }
//    
//    func updateUIViewController(_ uiViewController: MessagesViewController, context: Context) {
//        uiViewController.recipients = recipients
//        uiViewController.subject = subject
//        uiViewController.displayMessageInterface()
//    }
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, MessagesViewDelegate {
//        var parent: MessageUIView
//        
//        init(_ controller: MessageUIView) {
//            self.parent = controller
//        }
//        
//        func messageCompletion(result: MessageComposeResult) {
//            self.parent.presentationMode.wrappedValue.dismiss()
//            self.parent.completion(result)
//        }
//    }
//}
//
//
