//
//  MessageComposer.swift
//  PlazaMaintain
//
//  Created by Buwaneka Galpoththawela on 11/10/15.
//  Copyright © 2015 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MessageUI



class MessageComposer: NSObject,MFMessageComposeViewControllerDelegate{
    
    let textMessageRecipients = ["240-246-4697"]
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
        
    }
    
    
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Hey Mike, great job thanks again for the help!"
        return messageComposeVC
    }
    
        func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}


