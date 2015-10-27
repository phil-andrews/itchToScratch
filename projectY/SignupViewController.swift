//
//  SignupViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/16/15.
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



class SignupViewController: UIViewController, UITextFieldDelegate, PFSignUpViewControllerDelegate {
    
   var errorLabel: UILabel!
    
   var userNameTextField: UITextField!
    
   var passwordTextField: UITextField!
    
   var passwordConfirmTextField: UITextField!
    
   var emailTextField: UITextField!
    
   var signupButton: UIButton!
   func signupButtonPress(sender: AnyObject) {
        
        self.signupWithEmail()
        
    }
    var cancelButton: UIButton!
    
    func cancelButtonPress(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        emailTextField.delegate = self
        
        self.view.backgroundColor = backgroundColor
        let background = makeBackground()
        self.view.addSubview(background)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    func signupWithEmail() {
        
        let userName = userNameTextField.text
        let password = passwordTextField.text
        let passwordConfirm = passwordConfirmTextField.text
        let email = emailTextField.text
        
        if password != passwordConfirm {
            
            self.errorLabel.hidden = false
            self.errorLabel.text = "passwords don't match"
            
            return
            
        }
        
        signupButton.enabled = false
        signupButton.titleLabel?.text = ""
        
        
        var user = PFUser()
        
        user.username = userName
        user.password = password
        user.email = email
        
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            
            if let error = error {
                
                let errorString = error.userInfo?["error"] as? String
                self.errorLabel.text = errorString
                self.errorLabel.hidden = false
                
            } else if success {
                
                initializeUser({ (success, error) -> Void in
                    
                    if success == true {
                        
                        //hide button
                        //stop activity indicator
                        //show checkmark
                        
                    self.performSegueWithIdentifier("unwindFromSignUpToGameBoardController", sender: self)
                        
                        //begin welcome coachmarks
                        
                    }
                    
                    if error != nil {
                        
                        NSLog(error!.localizedDescription)
                        
                    }
                    
                    
                })
                
            }
            
        }
        
    }
    
}
