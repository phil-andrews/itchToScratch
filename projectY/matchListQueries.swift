//
//  matchListQueries.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse

func queryForLiveMatches(completion: ([PFObject]?) -> ()) {
    
    let query = PFQuery(className: MatchClassKey)
    let userMatches = PFUser.currentUser()?.valueForKey(userCurrentMatchesKey) as! [String]
    
    print(userMatches)
    
    if userMatches.count == 0 {
        
        completion([])
        
    }
    
    query.whereKey(objectId, containedIn: userMatches)
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


func queryForNewMatch(viewController: UIViewController, completion: (PFObject?) -> Void) {
    
    // start activity indicator
    
    let query = PFQuery(className: MatchClassKey)
    query.whereKey(player2IdKey, equalTo: "pending")
    query.getFirstObjectInBackgroundWithBlock { (newMatchObject: PFObject?, error) -> Void in
        
        if error == nil && newMatchObject == nil {
        
                completion(nil)
            
                //matchVC will run this query three times before it creates a new match
    
        } else if error == nil && newMatchObject != nil {

            if newMatchObject?.valueForKey(player2IdKey) as! String == "pending" {
                
                let p2ID = globalUser?.objectId
                let p2DisplayName = globalUser?.valueForKey(displayName)
                newMatchObject?.setValue(p2ID, forKey: player2IdKey)
                newMatchObject?.setValue(p2DisplayName, forKey: player2UserName)
                newMatchObject?.setValue("first", forKey: whosTurnKey)
                newMatchObject?.saveInBackground()
                
                var userMatchesArray = globalUser!.valueForKey(userCurrentMatchesKey) as! [String]
                userMatchesArray.append((newMatchObject?.objectId)!)
                
                globalUser?.setValue(userMatchesArray, forKey: userCurrentMatchesKey)
                
                globalUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    if success && error == nil {
                        
                        completion(newMatchObject)
                        
                        //completion will now launch match in matchVC

                    } else if error != nil {
                        
                        NSLog(error!.localizedDescription)
                    }
                    
                    
                })
                
                //stop activity indicator
                
                let creatingUser = newMatchObject?.valueForKey(player1IdKey) as! String
                let query = PFUser.query()
                query?.getObjectInBackgroundWithId(creatingUser, block: { (userObject, error) -> Void in
                    
                    userObject?.addObject(newMatchObject!.objectId!, forKey: userCurrentMatchesKey)
                    userObject?.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        if success && error == nil {
                            
                            //alert the player who created that their match is ready

                        }
                        
                    })
                    
                })
            
            }

            
        } else if error != nil {
            
            // error log to parse
            // check internet connection, display error
            
            completion(nil)
            
            NSLog(error!.localizedDescription)
            
        }
        
        
    }
    
}



func createNewMatch(matchCreator: String?, challengedUserID: String?, challengedUserDisplayName: String?, completion: (matchID: String) -> Void) {
    
    let newMatch = PFObject(className: MatchClassKey)
    newMatch[whosTurnKey] = "pending"
    newMatch[player1IdKey] = matchCreator!
    newMatch[player2IdKey] = challengedUserID!
    newMatch[player1UserName] = globalUser?.valueForKey(displayName)
    newMatch[player2UserName] = challengedUserDisplayName!
    newMatch[player1HelpsKey] = ["zoom", "takeTwo", "stopper"]
    newMatch[player2HelpsKey] = ["zoom", "takeTwo", "stopper"]
    newMatch[player2CategoryWinsKey] = []
    newMatch[player1CategoryWinsKey] = []
    
    newMatch.saveInBackgroundWithBlock { (success, error) -> Void in
        
        if error == nil && success == true {
            
            PFUser.currentUser()?.addObject(newMatch.objectId!, forKey: userCurrentMatchesKey)
            PFUser.currentUser()?.saveInBackground()
            completion(matchID: newMatch.objectId!)
            
        } else if error != nil {
            
            completion(matchID: "mcLovinHasLeftTheBuilding")
            
            print(error?.localizedDescription)
            
        } else if success == false {
            
            completion(matchID: "mcLovinHasLeftTheBuilding")
            
        }
        
    }
    
}



func queryForFullQuestionObjects(matchesArray: [PFObject], completion: ([String: [PFObject]]) -> ()) {
    
    var questionObjectsToPassBackArray = [String: [PFObject]]()
    
    for index in 0..<matchesArray.count {
        
        let indexToPassBackTo = matchesArray[index].valueForKey(objectId) as! String
        
        var count = 1
        
        var qObjectsToQueryFor = [String()]
        
        while count <= 16 {
            
            let qObject = matchesArray[index].valueForKey("q\(count)") as! String
            
            qObjectsToQueryFor.append(qObject)
            
            ++count
            
        }
    
        queryForMultipleObjectsInBackgroundWithBlock(QuestionClass, keyType: objectId, objectIdentifers: qObjectsToQueryFor, completion: { (objectsToPassBack, error) -> Void in
            
            if error == nil {
                
                questionObjectsToPassBackArray[indexToPassBackTo] = objectsToPassBack
                
            } else if error != nil {
                
                NSLog(error!.localizedDescription)
                
            }
            
            if index == (matchesArray.count - 1) {
                
                completion(questionObjectsToPassBackArray)
                
            }
            
        })
        
    }
    
}



