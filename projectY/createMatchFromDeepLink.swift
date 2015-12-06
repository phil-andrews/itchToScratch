//
//  createMatchFromDeepLink.swift
//  projectY
//
//  Created by Philip Ondrejack on 12/5/15.
//  Copyright © 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse


func ifNeededCreatMatchFromDeepLink(completion: () -> ()) {

    print("checking deep link")
    
    let delegateInstance = UIApplication.sharedApplication().delegate as! AppDelegate
    let linkUserID = delegateInstance.deepLinkChallengeUser
    let linkUserName = delegateInstance.deepLinkChallengeUserDisplayName
    
    if linkUserID != nil && PFUser.currentUser() != nil {
        
        print("does not equal nil")
        
        createNewMatch(globalUser!.objectId, challengedUserID: linkUserID, challengedUserDisplayName: linkUserName, completion: { (matchID) -> Void in
            
            let query = PFUser.query()
            query?.getObjectInBackgroundWithId(linkUserID!, block: { (cUser, error) -> Void in
                
                cUser?.addObject(matchID, forKey: userCurrentMatchesKey)
                cUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    // notify challenging user that their match is ready
                    
                    completion()
                    
                })
                
            })
            
        })
        
    } else if linkUserID == nil {
        
        completion()
    }

}