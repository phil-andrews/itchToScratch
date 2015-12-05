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
    
    if deepLinkChallengeUser != nil {
        
        print("does not equal nil")
        
        createNewMatch(user?.objectId, challengedUserID: deepLinkChallengeUser, challengedUserDisplayName: deepLinkChallengeUserDisplayName, completion: { (matchID) -> Void in
            
            let query = PFUser.query()
            query?.getObjectInBackgroundWithId(deepLinkChallengeUser!, block: { (cUser, error) -> Void in
                
                cUser?.addObject(matchID, forKey: userCurrentMatchesKey)
                cUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    // notify challenging user that their match is ready
                    
                    completion()
                    
                })
                
            })
            
        })
        
    } else if deepLinkChallengeUser == nil {
        
        completion()
    }

}