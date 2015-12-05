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


func checkForUser(viewController: UIViewController, completion: () -> ()) {
    
    if PFUser.currentUser() == nil {
        
        let loginViewController: LoginViewController = viewController.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
        
        viewController.presentViewController(loginViewController, animated: true, completion: nil)
        
    } else if PFUser.currentUser() != nil {
        
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (userObject, error) -> Void in
            
            if error == nil {
                
                user = userObject as? PFUser
                
                ifNeededCreatMatchFromDeepLink({ () -> () in
                    
                    completion()

                })
                
                
            } else if error != nil {
                
                NSLog((error?.localizedDescription)!)
                
                completion()
                
            }
            
            print("user logged in already")

        })
        
    }
    
}



func initializeUser(completion: (success: Bool?, error: NSError?) -> Void) {
    
    print("initialize user ran")
    
    let user = PFUser.currentUser()
    let userName: String? = user?.username as String?
    let twitToken = PFTwitterUtils.twitter()?.authToken
    
    if PFUser.currentUser() != nil && PFTwitterUtils.twitter()?.authToken != nil {
        print(twitToken)
        print("user logged in with Twitter")
        returnTwitterUserData()
        
    } else if PFUser.currentUser() != nil && (FBSDKAccessToken.currentAccessToken() != nil) {
        print("user logged in with Facebook")
        returnFacebookUserData()
        
    } else if PFUser.currentUser() != nil && (FBSDKAccessToken.currentAccessToken() == nil && PFTwitterUtils.twitter()?.authToken == nil) {
        user?.setObject(userName!, forKey: "displayName")
        print("user logged in without social media")
        
    }
    
    user?.setObject([], forKey: questionsAnswered)
    user?.setObject([], forKey: geographyCategory)
    user?.setObject([], forKey: scienceCategory)
    user?.setObject([], forKey: sportsCategory)
    user?.setObject([], forKey: musicCategory)
    user?.setObject([], forKey: historyCategory)
    user?.setObject([], forKey: moneyCategory)
    user?.setObject([], forKey: productsCategory)
    user?.setObject([], forKey: peopleCategory)
    user?.setObject([], forKey: questionWithImageCategory)
    user?.setObject([], forKey: questionJustTextCategory)
    user?.setObject([], forKey: moviesCategory)
    
    let defaultProPic = UIImage(named: defaultProfilePic)
    let image = UIImagePNGRepresentation(defaultProPic!)
    let imageFile = PFFile(name: "profilePic.png", data: image!)
    user?.setValue(imageFile, forKey: profilePic)
    
    user?.saveInBackgroundWithBlock({ (bool, error) -> Void in
        
        if error != nil && bool == false {
            
            print(error!.localizedDescription)
            
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
            print("Error in graph request: \(error!.localizedDescription)")
        }
        else
        {
            let userName : String? = result.valueForKey("name") as? String
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
    
    
    print(userName)
}
    