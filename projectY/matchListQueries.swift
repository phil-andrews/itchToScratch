//
//  matchListQueries.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse

func queryForLiveMatches(completion: ([PFObject]) -> ()) {
    
    let query = PFQuery(className: MatchClassKey)
    query.findObjectsInBackgroundWithBlock { (matches, error) -> Void in
        
        if error == nil {
            
            if let matches = matches as? [PFObject] {
                
                completion(matches)
                
            }
            
        } else if error != nil {
            
            NSLog(error!.localizedDescription)
            
        }
        
    }
    
}


func queryForNewMatch(completion: (PFObject?) -> Void) {
    
    var count = 0
    
    let query = PFQuery(className: MatchClassKey)
    query.whereKey(player2IdKey, equalTo: "nil")
    query.getFirstObjectInBackgroundWithBlock { (newMatchObject: PFObject?, error) -> Void in
        
        if error == nil && newMatchObject == nil {
        
            if count < 2 {
                
                queryForNewMatch({ (matchObject) -> Void in
                    
                    
                    
                })
                
            }
            
            ++count
            
        } else if error == nil && newMatchObject != nil {

            if newMatchObject?.valueForKey(player2IdKey) as! String == "nil" {
                
                newMatchObject?.setValue(PFUser.currentUser()?.objectId, forKey: player2IdKey)
                newMatchObject?.saveInBackground()
                
                
            }
            
            //add user to player2ID
            //add matchObject to user, launch match
            //add matchObject to user who created
            
        } else if error != nil {
            
            // error log to parse
            // check internet connection, display error
            
            NSLog(error!.localizedDescription)
            
        }
        
        
    }
    
}










