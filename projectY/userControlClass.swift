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



















func logoutFunc(view: UIView!, loginDelegate: PFLogInViewControllerDelegate, signupDelegate: PFSignUpViewControllerDelegate, viewController: UIViewController) {
    
    PFUser.logOutInBackgroundWithBlock { (error) -> Void in
        
        if error == nil {
            
            let loggedOutView = UIImageView()
            loggedOutView.hidden = true
            drawPercentageRectOffView(loggedOutView, view, 100, 100)
            loggedOutView.image = UIImage(named: logoutNotification)
            view.addSubview(loggedOutView)
            
            loggedOutView.center.y -= view.frame.height
            loggedOutView.hidden = false
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                loggedOutView.center.y += view.frame.height
                
                }, completion: { (Bool) -> Void in
                    
                    delay(2.5, { () -> () in
                        
                        loginFunc(view, loginDelegate, signupDelegate, viewController)
                        
                    })
                    
                    delay(2.6, { () -> () in
                        
                        loggedOutView.removeFromSuperview()
                        
                    })
                    
            })
            
        }
        
    }
    
    
}


func loginFunc(view: UIView, loginDelegate: PFLogInViewControllerDelegate, signupDelegate: PFSignUpViewControllerDelegate, viewController: UIViewController) -> Bool {
    
    let loginViewController = PFLogInViewController()
    loginViewController.delegate = loginDelegate
    loginViewController.fields = PFLogInFields.Default
        | PFLogInFields.Facebook
        | PFLogInFields.Twitter
    
    loginViewController.logInView?.backgroundColor = backgroundColor
    loginViewController.preferredContentSize.height = view.bounds.height
    loginViewController.preferredContentSize.width = view.bounds.width
    
    let loginBG = makeBackground()
    
    loginViewController.logInView?.addSubview(loginBG)
    loginViewController.logInView?.sendSubviewToBack(loginBG)
    
    loginViewController.logInView?.logo = nil
    
    
    let signupViewController = PFSignUpViewController()
    signupViewController.fields = PFSignUpFields.Default
    
    signupViewController.signUpView?.backgroundColor = backgroundColor
    signupViewController.preferredContentSize.height = view.bounds.height
    signupViewController.preferredContentSize.width = view.bounds.width
    
    let signUpBG = makeBackground()
    
    signupViewController.signUpView?.addSubview(signUpBG)
    signupViewController.signUpView?.sendSubviewToBack(signUpBG)
    
    signupViewController.signUpView?.logo = nil
    
    loginViewController.signUpController = signupViewController
    
    viewController.presentViewController(loginViewController, animated: true, completion: nil)
    
    signupViewController.delegate = signupDelegate
    
    return true
    
}


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
    