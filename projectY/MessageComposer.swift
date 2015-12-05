//
//  MessageComposer.swift
//  projectY
//
//  Created by Philip Ondrejack on 12/4/15.
//  Copyright © 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Branch
import MessageUI


func prefillMessageBody(couldNotMatch: String, completion: (String) -> Void) {
    
        let object: BranchUniversalObject = BranchUniversalObject(title: "GameInvite")
        object.title = "Game Invite"
        object.addMetadataKey("sendingUser", value: user?.objectId)
        object.addMetadataKey("CouldNotFindMatch", value: couldNotMatch)
        object.addMetadataKey(sendingUserDisplayName, value: user?.valueForKey(displayName) as! String)
        
        let linkProperties: BranchLinkProperties = BranchLinkProperties()
        linkProperties.channel = "in-app"
        linkProperties.addControlParam(deepLinkChallenge, withValue: user?.objectId)
        
        object.registerView()
        
        object.getShortUrlWithLinkProperties(linkProperties) { (url, error) -> Void in
            
            if error == nil {
                
                completion(url)
                
            } else if error != nil {
                
                print(error.localizedDescription)
                
            }
            
        }
    
}


















