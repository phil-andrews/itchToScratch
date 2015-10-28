//
//  userControlClass.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/14/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Parse
import ParseUI
import Bolts
import FBSDKCoreKit
import FBSDKLoginKit


func initializeUser(completion: (success: Bool?, error: NSError?) -> Void) {
    
    println("initialize user ran")
    
    let user = PFUser.currentUser()
    let userName: String? = user?.username as String?
    let twitToken = PFTwitterUtils.twitter()?.authToken
    let nameToDisplay = user?.valueForKey(displayName) as! String?
    
    if PFUser.currentUser() != nil && PFTwitterUtils.twitter()?.authToken != nil {
        println(twitToken)
        println("user logged in with Twitter")
        returnTwitterUserData()
        
    } else if PFUser.currentUser() != nil && (FBSDKAccessToken.currentAccessToken() != nil) {
        println("user logged in with Facebook")
        returnFacebookUserData()
        
    } else if PFUser.currentUser() != nil && (FBSDKAccessToken.currentAccessToken() == nil && PFTwitterUtils.twitter()?.authToken == nil) {
        user?.setObject(userName!, forKey: "displayName")
        println("user logged in without social media")
        
    }
    
    user?.setObject([], forKey: visitedLocations)
    user?.setObject([], forKey: questionsAnswered)
    user?.setObject([], forKey: whereUserAnswered)
    user?.setObject([], forKey: geographyCategory)
    user?.setObject([], forKey: scienceCategory)
    user?.setObject([], forKey: sportsCategory)
    user?.setObject([], forKey: televisionCategory)
    user?.setObject([], forKey: musicCategory)
    user?.setObject([], forKey: historyCategory)
    user?.setObject([], forKey: moneyCategory)
    user?.setObject([], forKey: productsCategory)
    user?.setObject([], forKey: peopleCategory)
    user?.setObject([], forKey: questionWithImageCategory)
    user?.setObject([], forKey: questionJustTextCategory)
    user?.setObject([], forKey: moviesCategory)
    
    let defaultProPic = UIImage(named: defaultProfilePic)
    let image = UIImagePNGRepresentation(defaultProPic)
    let imageFile = PFFile(name: "profilePic.png", data: image)
    user?.setValue(imageFile, forKey: profilePic)
    
    user?.saveInBackgroundWithBlock({ (bool, error) -> Void in
        
        if error != nil && bool == false {
            
            println(error!.localizedDescription)
            
            completion(success: false, error: error)
            
        } else if bool == true && error != nil {
            
            completion(success: true, error: error)
            
        } else if bool == true && error == nil {
            
            completion(success: true, error: nil)
            
        }
        
    })
    
}


func returnFacebookUserData()
{
    let user = PFUser.currentUser()
    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
        
        if ((error) != nil)
        {
            // Process error
            println("Error in graph request: \(error!.localizedDescription)")
        }
        else
        {
            let userName : String? = result.valueForKey("name") as? String
            let userEmail : String? = result.valueForKey("email") as? String
            let gender: String? = result.valueForKey("gender") as? String
            
            user?.setObject(userName!, forKey: "displayName")
            user?.setObject(gender!, forKey: "gender")
            
            user?.saveInBackground()
            
            
            
        }
    })
    
}



func returnTwitterUserData() {
    
    let user = PFUser.currentUser()
    let userName: String? = PFTwitterUtils.twitter()?.screenName as String?
    
    user?.setObject(userName!, forKey: "displayName")
    
    user?.saveInBackground()
    
    
    println(userName)
}
    