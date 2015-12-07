////
////  loginFunctions.swift
////  projectY
////
////  Created by Philip Ondrejack on 9/12/15.
////  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
////
//
import Foundation
import UIKit
import Parse
import ParseUI
import Bolts
//
//
//func queryForSingleObjectInBackgroundWithBlock(className: String, typeOfKey: String, equalToValue: String, completion: (PFObject?, NSError?) -> Void) {
//    
//    var objectToReturn: PFObject?
//    var errorToReturn: NSError?
//    
//    let query = PFQuery(className: className)
//    query.whereKey(typeOfKey, equalTo: equalToValue)
//    query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
//        
//        if error == nil {
//            
//            print("no error")
//            
//            objectToReturn = object!
//            errorToReturn = nil
//            
//            completion(objectToReturn, errorToReturn)
//            
//        } else if error?.code == 101 {
//            
//            print("101 error")
//            
//            errorToReturn = error
//            objectToReturn = nil
//            
//            completion(objectToReturn, errorToReturn)
//            
//            
//        } else if error != nil && error?.code != 101 {
//            
//            NSLog(error!.localizedDescription)
//            print("error in getting object from queryForObjectInBackgroundWithBlock")
//            
//        }
//        
//        
//    }
//    
//
//}
//
//
//
//func addAndSubtractUserFromLocationCount(currentLocationObject: PFObject) {
//    
//    print("add user ran")
//    
//    let userObject: PFObject? = PFUser.currentUser()
//    let oldLocation: String? = userObject?.valueForKey(usersOldLocation) as? String
//    
//    if oldLocation != nil {
//        
//        queryForSingleObjectInBackgroundWithBlock(LocationClass, typeOfKey: objectId, equalToValue: oldLocation!, completion: { (object: PFObject?, error) -> Void in
//            
//            if let object = object as PFObject? {
//                
//                if error == nil {
//                    
//                    let currentUsers = object.valueForKey(usersLoggedInAtLocationArray) as! NSMutableArray
//                    let userID = userObject?.objectId as String!
//                    
//                    if currentUsers.containsObject(userID) {
//                        
//                        currentUsers.removeObject(userID)
//                        object.setValue(currentUsers, forKey: usersLoggedInAtLocationArray)
//                        object.incrementKey(usersLoggedInAtLocationCount, byAmount: -1)
//                        object.saveInBackground()
//                        
//                    }
//                    
//                } else if error != nil {
//                    
//                    NSLog(error!.localizedDescription)
//                    print("could not log user out of previous area")
//                }
//                
//            }
//            
//        })
//        
//    }
//
//    
//    let currentLocationObjectID = currentLocationObject.objectId as String!
//    queryForSingleObjectInBackgroundWithBlock(LocationClass, typeOfKey: objectId, equalToValue: currentLocationObjectID) { (object: PFObject?, error: NSError?) -> Void in
//        
//        if let object = object as PFObject? {
//            
//            if error == nil {
//                
//                let currentUsers = object.valueForKey(usersLoggedInAtLocationArray) as! NSMutableArray
//                let userID = userObject?.objectId as String!
//                
//                print(currentUsers)
//                print(userID)
//                
//                if currentUsers.containsObject(userID) == false {
//                    
//                    currentUsers.addObject(userID)
//                    object.incrementKey(usersLoggedInAtLocationCount, byAmount: 1)
//                    object.saveInBackground()
//                    
//                    
//                }
//                
//            } else if error != nil {
//                
//                NSLog(error!.localizedDescription)
//                
//                print("could not add user to currentUsersAtlocation")
//                
//            }
//            
//        }
//        
//    }
//    
//    PFUser.currentUser()?.setValue(currentLocationObject.objectId, forKey: usersOldLocation)
//    PFUser.currentUser()?.saveInBackground()
//    
//}
//
//
//func saveNewLocationObject(defaultObjectForNewLocation: PFObject, currentLocalityString: String, completion: (Bool, PFObject) -> Void) {
//    
//    
//    print("should be saving")
//    
//    let newLocationObject = PFObject(className: LocationClass)
//    
//    newLocationObject[geoPoint] = PFGeoPoint(location: usersCurrentLocationData)
//    newLocationObject[locality] = currentLocalityString
//    newLocationObject[allVisitedUsers] = [""]
//    newLocationObject[usersLoggedInAtLocationCount] = 0
//    newLocationObject[usersLoggedInAtLocationArray] = [""]
//    newLocationObject[usedQuestionObjects] = defaultObjectForNewLocation.valueForKey(usedQuestionObjects)
//    
//    var count = 0
//    
//    while count < 40 {
//        
//        newLocationObject["ans\(count)"] = 0
//        newLocationObject["Q\(count)"] = defaultObjectForNewLocation.valueForKey("Q\(count)") as! String
//        count = count + 1
//        
//    }
//    
//    newLocationObject.saveInBackgroundWithBlock { (success, error) -> Void in
//        
//        if error != nil {
//            
//            NSLog(error!.localizedDescription)
//            
//            print("could not save new location object")
//        } else if error == nil && success {
//            
//            completion(success, newLocationObject)
//            
//        }
//        
//    }
//    
//}
//
//
//
func queryForMultipleObjectsInBackgroundWithBlock(className: String, keyType: String, objectIdentifers: [String], completion: ([PFObject], NSError?) -> Void) {
    
    let query = PFQuery(className: className)
    query.whereKey(keyType, containedIn: objectIdentifers)
    query.findObjectsInBackgroundWithBlock { (objects, error: NSError?) -> Void in
        
        if let objects = objects as? [PFObject] {
            
            if error == nil {
                
                completion(objects, nil)
                
            } else if error != nil {
                
                completion(objects, error)
                
            }
            
        }
        
    }
    
    
}
//
//
//
func queryForImage(file: PFFile, completion: (UIImage) -> Void){
    
    file.getDataInBackgroundWithBlock { (data, error) -> Void in
        
        if error == nil {
            
            let imageData = data
            let image = UIImage(data: imageData!)
            completion(image!)
            
        }
        
    }
    
}


func queryForAndReturnProfilePicture(oID: String, completion: (UIImage) -> Void) {
    
    let query = PFUser.query()
    query?.getObjectInBackgroundWithId(oID, block: { (userObject, error) -> Void in
        
        if error == nil {
            
            let userImageFile = userObject?.valueForKey(profilePic) as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
                
                if error == nil {
                    
                    let image = UIImage(data: imageData!)
                    
                    completion(image!)
                    
                } else if error != nil || imageData == nil {
                    
                    let image = UIImage(named: defaultProfilePic)
                    
                    NSLog(error!.localizedDescription)
                    
                    completion(image!)
                }
                
            })
            
        } else if error != nil {
            
            let image = UIImage(named: defaultProfilePic)
            
            NSLog(error!.localizedDescription)
            
            completion(image!)
            
        }
        
        
    })
    
    
    
    
    
    
}


//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
