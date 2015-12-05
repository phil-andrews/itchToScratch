//
//  AppDelegate.swift
//  projectY
//
//  Created by Philip Ondrejack on 5/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
import FBSDKCoreKit
import FBSDKLoginKit
import Mapbox
import Branch

var deepLinkChallengeUser: String?
var deepLinkChallengeUserDisplayName: String?

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let appIdKey = "QfexECoKFE2BuzQRnfkNrCM82I6Ew3LTa3MiXG0V"
    let appClientKey = "UI1IZR60wgiCltXAligcTfIep59jKRK9cvuIpB8M"
    
    let twitterConsumerKey = "uCanrRSD93IscWZ3wrx2Oz5ST"
    let twitterConsumerSecret = "KwM8sgiBmHc64QvnUAaupjxKx9FrbFNSXWTpyNyYqcSsGLP690"
    
    let mapboxKey = "pk.eyJ1IjoicGhpbG9uZHJlamFjayIsImEiOiJjaWV6dWczMngxZWtmc2VrcmZlZmJmcG5vIn0.3joKi4D-TfzkRZtIWVZY_g"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Parse.setApplicationId(appIdKey, clientKey: appClientKey)
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        PFTwitterUtils.initializeWithConsumerKey(twitterConsumerKey,  consumerSecret:twitterConsumerSecret)
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        MGLAccountManager.setAccessToken(mapboxKey)
                
        let branch: Branch = Branch.getInstance()
        branch.initSessionWithLaunchOptions(launchOptions, andRegisterDeepLinkHandler: { params, error in
            if (error == nil) {
                if let params = params as NSDictionary? {
                    
                    let opponent = params.valueForKey(deepLinkChallenge) as! String?
                    let opponentDisplayName = params.valueForKey(sendingUserDisplayName) as! String?
                    
                    print(opponent)
                    print(opponentDisplayName)
                    
                    if opponent != nil {
                        
                        deepLinkChallengeUser = opponent
                        deepLinkChallengeUserDisplayName = opponentDisplayName
                        
                    }
                    
                }
                
                
            }
            
        })
        

        return true
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        //print(url.host)
        
        if (!Branch.getInstance().handleDeepLink(url)) {
            
            FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
            
        } else {
            
            _ = Branch.getInstance().getLatestReferringParams()
            
            
        }
        
        return true

    }
    


    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        FBSDKAppEvents.activateApp()
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

