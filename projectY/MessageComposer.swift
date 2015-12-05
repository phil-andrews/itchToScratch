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


func prefillMessageBody(completion: (String) -> Void) {
    
    createNewMatch { (matchID) -> Void in
        
        let object: BranchUniversalObject = BranchUniversalObject(title: "messageFill")
        object.title = "test title"
        object.addMetadataKey("matchObjectID", value: "sdf9809sdf")
        
        let linkProperties: BranchLinkProperties = BranchLinkProperties()
        linkProperties.channel = "in-app"
        linkProperties.addControlParam("matchObject", withValue: "matchID")
        
        object.registerView()
        
        object.getShortUrlWithLinkProperties(linkProperties) { (url, error) -> Void in
            
            if error == nil {
                
                completion(url)
                
            } else if error != nil {
                
                print(error.localizedDescription)
                
            }
            
        }
        
        
    }
    
}




















