//
//  LoginViewController.swift
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


class LoginViewController: UIViewController, UITextFieldDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    ///colors
    
    let textFieldActiveBackgroundColor = backgroundColor
    let textFieldInactiveBackgroundColor = lightColoredFont
    
    ///login variables
    
    var facebookButton = UIButton()
    var twitterButton = UIButton()
    var spacerImage = UIImageView()
    var errorLabel = UILabel()
    var userNameField = UITextField()
    var passwordField = UITextField()
    var forgotPasswordEntryField = UITextField()
    var loginButton = UIButton()
    var forgotPasswordButton = UIButton()
    var signupWithEmail = UIButton()
    var cancelLoginButton = UIButton()
    
    
    ///email signup variables
    
    
    var userNameSignupField = UITextField()
    var passwordSignupField = UITextField()
    var passwordConfirmationSignupField = UITextField()
    var emailSignupField = UITextField()
    var registerButton = UIButton()
    var cancelRegisterButton = UIButton()

    
    
    
    let background = makeBackground()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        self.view.addSubview(background)
        setFonts(self.view)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.makeSizesAddSubviews { () -> Void in
            
            self.loginSectionMake()
            
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        println("text field did return")
        
        if loginButton.alpha == 1.0 {
            
            self.emailLoginPressed()
            
        }
        
        if registerButton.alpha == 1.0 {
            
            self.signupWithEmailPressed()
            
        }
        
        
        return true
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if facebookButton.alpha == 1.0 {
            
            didBeginEnteringLoginInformation()
            
        }
        
        textField.returnKeyType = .Go
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        

        
    }
    
    
    
    
    
    
    func makeSizesAddSubviews(completion: () -> Void) {
        
        drawPercentageRectOffView(facebookButton, self.view, 7.1, 78.44)
        drawPercentageRectOffView(twitterButton, self.view, 7.1, 78.44)
        drawPercentageRectOffView(spacerImage, self.view, 3.35, 88.75)
        drawPercentageRectOffView(errorLabel, self.view, 2.81, 78.44)
        drawPercentageRectOffView(userNameField, self.view, 7.1, 78.44)
        drawPercentageRectOffView(passwordField, self.view, 7.1, 78.44)
        drawPercentageRectOffView(loginButton, self.view, 7.1, 78.44)
        drawPercentageRectOffView(forgotPasswordButton, self.view, 2.81, 34.69)
        drawPercentageRectOffView(signupWithEmail, self.view, 2.81, 34.69)
        drawPercentageRectOffView(cancelLoginButton, self.view, 2.81, 34.69)

        
        self.view.addSubview(facebookButton)
        self.view.addSubview(twitterButton)
        self.view.addSubview(spacerImage)
        self.view.addSubview(errorLabel)
        self.view.addSubview(userNameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginButton)
        self.view.addSubview(forgotPasswordButton)
        self.view.addSubview(signupWithEmail)
        self.view.addSubview(cancelLoginButton)

        
        drawPercentageRectOffView(userNameSignupField, self.view, 7.1, 78.44)
        drawPercentageRectOffView(passwordSignupField, self.view, 7.1, 78.44)
        drawPercentageRectOffView(passwordConfirmationSignupField, self.view, 7.1, 78.44)
        drawPercentageRectOffView(emailSignupField, self.view, 7.1, 78.44)
        drawPercentageRectOffView(registerButton, self.view, 7.1, 78.44)
        drawPercentageRectOffView(cancelRegisterButton, self.view, 2.81, 34.69)
        
        self.view.addSubview(userNameSignupField)
        self.view.addSubview(passwordSignupField)
        self.view.addSubview(passwordConfirmationSignupField)
        self.view.addSubview(emailSignupField)
        self.view.addSubview(registerButton)
        self.view.addSubview(cancelRegisterButton)

        completion()
        
        
    }
    
    
    func loginSectionMake() {
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let viewHeightPercent = viewHeight/100
        let viewWidthPercent = viewWidth/100
        
        self.forgotPasswordButton.setTitle("forgot password?", forState: .Normal)
        self.forgotPasswordButton.titleLabel?.font = robotoLight14
        self.forgotPasswordButton.titleLabel?.textColor = lightColoredFont
        self.forgotPasswordButton.titleLabel?.textAlignment = .Center
        self.forgotPasswordButton.sizeToFit()
        self.forgotPasswordButton.addTarget(self, action: Selector("forgotPasswordPressed"), forControlEvents: .TouchUpInside)
        
        self.signupWithEmail.setTitle("signup with email", forState: .Normal)
        self.signupWithEmail.titleLabel?.font = robotoLight14
        self.signupWithEmail.titleLabel?.textColor = lightColoredFont
        self.signupWithEmail.titleLabel?.textAlignment = .Center
        self.signupWithEmail.sizeToFit()
        self.signupWithEmail.addTarget(self, action: Selector("signupWithEmailPressed"), forControlEvents: .TouchUpInside)
        self.signupWithEmail.enabled = true
        
        
        let facebookButtonYOffset = viewHeightPercent * 15.85
        facebookButton.frame.offset(dx: centerXAlignment(facebookButton, self.view), dy: facebookButtonYOffset)
        
        
        let errorLabelYOffset = self.facebookButton.frame.minY - (viewHeightPercent * 5)
        errorLabel.frame.offset(dx: centerXAlignment(self.errorLabel, self.view), dy: errorLabelYOffset)
        
        
        let twitterButtonYOffest = self.facebookButton.frame.maxY + (viewHeightPercent * 3.5)
        twitterButton.frame.offset(dx: centerXAlignment(twitterButton, self.view), dy: twitterButtonYOffest)
        
        
        let spacerImageYOffset = self.twitterButton.frame.maxY + (viewHeightPercent * 9.5)
        spacerImage.frame.offset(dx: centerXAlignment(spacerImage, self.view), dy: spacerImageYOffset)
        
        
        let userNameFieldYOffset = self.spacerImage.frame.maxY + (viewHeightPercent * 9.5)
        userNameField.frame.offset(dx: centerXAlignment(userNameField, self.view), dy: userNameFieldYOffset)
        
        
        let passwordFieldYOffset = userNameField.frame.maxY + (viewHeightPercent * 1.58)
        passwordField.frame.offset(dx: centerXAlignment(passwordField, self.view), dy: passwordFieldYOffset)
        
        
        let loginButtonYOffset = passwordField.frame.maxY + (viewHeightPercent * 1.58)
        loginButton.frame.offset(dx: centerXAlignment(loginButton, self.view), dy: loginButtonYOffset)
        
        
        let forgotPasswordButtonYOffset = loginButton.frame.maxY + (viewHeightPercent * 1.58)
        forgotPasswordButton.frame.offset(dx: centerXAlignment(forgotPasswordButton, self.view), dy: forgotPasswordButtonYOffset)
        
        
        let signupWithEmailYOffset = forgotPasswordButton.frame.maxY
        signupWithEmail.frame.offset(dx: centerXAlignment(signupWithEmail, self.view), dy: signupWithEmailYOffset)
        
        
        self.facebookButton.setImage(UIImage(named: facebookSignInImage), forState: .Normal)
        self.facebookButton.addTarget(self, action: Selector("facebookLogin"), forControlEvents: .TouchUpInside)
        self.facebookButton.backgroundColor = facebookColor
        self.facebookButton.layer.cornerRadius = 4.0
        self.facebookButton.tag = 1
        
        self.twitterButton.setImage(UIImage(named: twitterSignInImage), forState: .Normal)
        self.twitterButton.addTarget(self, action: Selector("twitterLogin"), forControlEvents: .TouchUpInside)
        self.twitterButton.backgroundColor = lowColor
        self.twitterButton.layer.cornerRadius = 4.0
        self.twitterButton.tag = 2
        
        self.spacerImage.image = UIImage(named: loginSpacerImage)
        self.spacerImage.contentMode = .ScaleAspectFit
        
        self.errorLabel.textColor = redColor
        self.errorLabel.textAlignment = .Center
        self.errorLabel.font = robotoRegular18
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.5
        
        let textFieldPadding = UIView()
        textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
        
        self.userNameField.delegate = self
        self.userNameField.leftView = textFieldPadding
        self.userNameField.leftViewMode = UITextFieldViewMode.Always
        self.userNameField.layer.cornerRadius = 4.0
        self.userNameField.textColor = backgroundColor
        self.userNameField.font = robotoRegular18
        self.userNameField.attributedPlaceholder = self.attributedPlaceHolderString("email")
        self.userNameField.backgroundColor = textFieldInactiveBackgroundColor
        
        let passwordFieldPadding = UIView()
        passwordFieldPadding.frame = CGRectMake(0, 0, 8, 40)
        
        self.passwordField.delegate = self
        self.passwordField.leftViewMode = UITextFieldViewMode.Always
        self.passwordField.leftView = passwordFieldPadding
        self.passwordField.secureTextEntry = true
        self.passwordField.layer.cornerRadius = 4.0
        self.passwordField.textColor = backgroundColor
        self.passwordField.font = robotoLight18
        self.passwordField.attributedPlaceholder = self.attributedPlaceHolderString("password")
        self.passwordField.backgroundColor = textFieldInactiveBackgroundColor

        self.loginButton.backgroundColor = midColor
        self.loginButton.layer.cornerRadius = 4.0
        self.loginButton.setTitle("login", forState: .Normal)
        self.loginButton.setTitleColor(backgroundColor, forState: .Normal)
        self.loginButton.titleLabel?.textAlignment = .Center
        self.loginButton.titleLabel?.font = robotoLight18
        self.loginButton.titleLabel?.textColor = backgroundColor
        self.loginButton.addTarget(self, action: Selector("emailLoginPressed"), forControlEvents: .TouchUpInside)
        self.loginButton.tag = 3
        
        let passwordConfirmationFieldPadding = UIView()
        passwordConfirmationFieldPadding.frame = CGRectMake(0, 0, 8, 40)
        
        self.passwordConfirmationSignupField.delegate = self
        self.passwordConfirmationSignupField.leftViewMode = UITextFieldViewMode.Always
        self.passwordConfirmationSignupField.leftView = passwordConfirmationFieldPadding
        self.passwordConfirmationSignupField.secureTextEntry = true
        self.passwordConfirmationSignupField.layer.cornerRadius = 4.0
        self.passwordConfirmationSignupField.textColor = backgroundColor
        self.passwordConfirmationSignupField.backgroundColor = textFieldInactiveBackgroundColor
        self.passwordConfirmationSignupField.attributedPlaceholder = self.attributedPlaceHolderString("password")
        self.passwordConfirmationSignupField.alpha = 0.0
        
        let emailSignupFieldPassing = UIView()
        emailSignupFieldPassing.frame = CGRectMake(0, 0, 8, 40)
        
        self.emailSignupField.delegate = self
        self.emailSignupField.leftViewMode = UITextFieldViewMode.Always
        self.emailSignupField.leftView = emailSignupFieldPassing
        self.emailSignupField.layer.cornerRadius = 4.0
        self.emailSignupField.textColor = backgroundColor
        self.emailSignupField.font = robotoRegular18
        self.emailSignupField.backgroundColor = textFieldInactiveBackgroundColor
        self.emailSignupField.attributedPlaceholder = self.attributedPlaceHolderString("password")
        self.emailSignupField.alpha = 0.0
        
        
        self.registerButton.backgroundColor = lowColor
        self.registerButton.layer.cornerRadius = 4.0
        self.registerButton.setTitle("register", forState: .Normal)
        self.registerButton.setTitleColor(backgroundColor, forState: .Normal)
        self.registerButton.titleLabel?.textAlignment = .Center
        self.registerButton.titleLabel?.font = robotoLight18
        self.registerButton.titleLabel?.textColor = backgroundColor
        self.registerButton.addTarget(self, action: Selector("signUpWithEmailSubmitted"), forControlEvents: .TouchUpInside)
        self.registerButton.alpha = 0.0
        self.registerButton.tag = 4

        
        
    }

    
    
    func facebookLogin() {
        
        errorLabel.text = ""
        
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                
                if user.isNew {
                    
                    initializeUser({ (success, error: NSError?) -> Void in
                        
                        if success == true {
                            
                            let pictureRequest = FBSDKGraphRequest(graphPath: "me/picture?type=normal&redirect=false", parameters: nil)
                            pictureRequest.startWithCompletionHandler({
                                (connection, result, error: NSError!) -> Void in
                                if error == nil {

                                    println("this is the result: \(result)")
                                    
                                        let data = result.objectForKey("data") as! NSDictionary
                                        let dataURL = data.objectForKey("url") as! String
                                        let pictureURL = NSURL(string: dataURL)
                                        println(pictureURL)
                                    
                                        let requestURL = NSURLRequest(URL: pictureURL!)
                                    
                                        NSURLConnection.sendAsynchronousRequest(requestURL, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                                            if error == nil {
                                                
                                                var picture = PFFile(data: data)
                                                
                                                user.setValue(picture, forKey: profilePic)
                                                
                                                user.saveInBackgroundWithBlock({ (success, error) -> Void in
                                                    
                                                    if error == nil {
                                                        
                                                        self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                                                        
                                                    }
                                                    
                                                })
                                                
                                            }
                                            
                                        })

                                } else {
                                    
                                    //confirm login, redirect to profile picture picker
                                    
                                    println("this is the error: \(error?.localizedDescription)")
                                }
                            })
                            
                        }
                        
                        if error != nil {
                            
                            self.errorLabel.text = error!.localizedDescription
                            
                            NSLog(error!.localizedDescription)
                            
                        }
                        
                    })
                    
                    println("User signed up and logged in through Facebook!")
                    
                } else {
                    
                    self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                    
                    println("User logged in through Facebook!")
                    
                }
            } else {
                
                println("Uh oh. The user cancelled the Facebook login.")
            }
            
        }
        
    }
    
    
    
    func twitterLogin() {
        
        errorLabel.text = ""
        
        PFTwitterUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                
                SquaresActivityIndicator().replaceButtonWithActivityIndicator(self.view, button: self.twitterButton, percentageSize: 7, borderWidth: 2.0)
                
                if user.isNew {
                    
                    initializeUser({ (success, error) -> Void in
                        
                        if success == true {
                            
                            let verify = NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
                            var request = NSMutableURLRequest(URL: verify!)
                            PFTwitterUtils.twitter()!.signRequest(request)
                            var response: NSURLResponse?
                            var error: NSError?
                            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
                            
                                if error == nil {
                                    
                                    let result = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &error) as! NSDictionary
                                    
                                    println(result)
                                    
                                    let profileImageURLString = result.objectForKey("profile_image_url_https") as! String
                                    
                                    let hiResUrlString = profileImageURLString.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                                    
                                    let twitterPhotoUrl = NSURL(string: hiResUrlString)
                                    let imageData = NSData(contentsOfURL: twitterPhotoUrl!)
                                    let twitterImage: PFFile = PFFile(data: imageData!)
                                    
                                    user.setValue(twitterImage, forKey: profilePic)
                                    
                                    user.saveInBackgroundWithBlock({ (success, error) -> Void in
                                        
                                        if error == nil {
                                            
                                            SquaresActivityIndicator().stopIndicator(self.view)
                                            
                                            self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                                            
                                        } else if error != nil {
                                            
                                        println(error?.localizedDescription)
                                            
                                        }
                                        
                                        
                                    })
                                }
                            
                        }
                        
                        if error != nil {
                            
                            NSLog(error!.localizedDescription)
                            self.errorHandlingAndLabelText(error!.code)
                            
                            SquaresActivityIndicator().stopIndicator(self.view)
                            
                            self.twitterButton.alpha = 1.0

                        }
                        
                    })
                    
                    print("User signed up and logged in with Twitter!")
                    
                } else {
                    
                    SquaresActivityIndicator().stopIndicator(self.view)
                    
                    self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                    
                    print("User logged in with Twitter!")
                    
                }
                
            } else {
                
                
                print("Uh oh. The user cancelled the Twitter login.")
                
            }
        }
        
    }
    
    
    
    var errorLabelOrigin = CGPoint()
    var userNameFieldOrigin = CGPoint()
    var passwordFieldOrigin = CGPoint()
    var forgotPasswordButtonOrigin = CGPoint()
    var loginButtonOrigin = CGPoint()
    var cancelRegisterButtonOrigin = CGPoint()
    
    
    
    func didBeginEnteringLoginInformation() {
        
        errorLabel.text = ""
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let viewHeightPercentage = viewHeight/100
        let viewWidthPercentage = viewWidth/100
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.spacerImage.alpha = 0.0
            
        })
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            self.twitterButton.alpha = 0.0
            
        })
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.facebookButton.alpha = 0.0
            
        })
        
        self.signupWithEmail.alpha = 0.0
        
        errorLabelOrigin = self.errorLabel.frame.origin
        userNameFieldOrigin = self.userNameField.frame.origin
        passwordFieldOrigin = self.passwordField.frame.origin
        forgotPasswordButtonOrigin = self.forgotPasswordButton.frame.origin
        loginButtonOrigin = self.loginButton.frame.origin
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            let loginObjectsOffsets = self.userNameField.frame.origin.y - self.facebookButton.frame.origin.y + (viewHeightPercentage * 5)
            
            self.userNameField.frame.origin.y -= loginObjectsOffsets
            self.passwordField.frame.origin.y -= loginObjectsOffsets
            self.loginButton.frame.origin.y -= loginObjectsOffsets
            self.forgotPasswordButton.frame.origin.y -= loginObjectsOffsets
            self.forgotPasswordButton.frame.origin.x = self.userNameField.frame.minX
            
            self.userNameField.layer.cornerRadius = 2.0
            self.passwordField.layer.cornerRadius = 2.0
            
            
        }) { (Bool) -> Void in
            
            let errorLabelOffset = (self.userNameField.frame.minY - (viewHeightPercentage * 5))
            self.errorLabel.frame.origin = CGPoint(x: self.errorLabel.frame.origin.x, y: errorLabelOffset)
            
            styleButton(self.cancelLoginButton, .Normal, UIColor.clearColor(), lightColoredFont, "cancel", 0.0)
            self.cancelLoginButton.titleLabel?.font = robotoLight14
            self.cancelLoginButton.titleLabel?.textAlignment = .Center
            self.cancelLoginButton.sizeToFit()
            self.cancelLoginButton.alpha = 0.0
            let cancelLoginButtonYOffset = self.forgotPasswordButton.frame.origin.y
            let cancelLoginButtonXOffset = self.loginButton.frame.maxX - self.cancelLoginButton.frame.width
            self.cancelLoginButton.frame.offset(dx: cancelLoginButtonXOffset, dy: cancelLoginButtonYOffset)
            self.cancelLoginButton.addTarget(self, action: Selector("cancelLoginButtonPressed"), forControlEvents: .TouchUpInside)
            
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.cancelLoginButton.alpha = 1.0
                
            })
            
        }

        
    }
    

    
    func forgotPasswordPressed() {
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let viewHeightPercentage = viewHeight/100
        let viewWidthPercentage = viewWidth/100
        
        errorLabel.text = ""
        
        if forgotPasswordButton.frame.minY > self.view.frame.midY {
            
            errorLabelOrigin = self.errorLabel.frame.origin
            userNameFieldOrigin = self.userNameField.frame.origin
            passwordFieldOrigin = self.passwordField.frame.origin
            forgotPasswordButtonOrigin = self.forgotPasswordButton.frame.origin
            loginButtonOrigin = self.loginButton.frame.origin
            
        }
        
        self.forgotPasswordButton.alpha = 0.0
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.spacerImage.alpha = 0.0
            
        })
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            self.twitterButton.alpha = 0.0
            
        })
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.facebookButton.alpha = 0.0
            
        })
        
        self.signupWithEmail.alpha = 0.0
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.passwordField.frame.origin = self.userNameField.frame.origin
            
        }) { (Bool) -> Void in
            
            self.passwordField.alpha = 0.0
            
            let yOffset = self.facebookButton.frame.maxY

            self.loginButton.setTitle("reset password", forState: .Normal)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.userNameField.frame.origin.y = yOffset
                
                let loginButtonOffset = yOffset + (self.userNameField.frame.height + (viewHeightPercentage * 2.11))
                self.loginButton.frame.origin.y = loginButtonOffset
                self.loginButton.backgroundColor = highestColor
                
            }, completion: { (Bool) -> Void in
                
                self.loginButton.removeTarget(self, action: Selector("emailLoginPressed"), forControlEvents: .TouchUpInside)
                self.loginButton.addTarget(self, action: Selector("forgotPasswordSubmitted"), forControlEvents: .TouchUpInside)
                
                let errorLabelOffset = (self.userNameField.frame.minY - (viewHeightPercentage * 5))
                self.errorLabel.frame.origin = CGPoint(x: self.errorLabel.frame.origin.x, y: errorLabelOffset)
                
                styleButton(self.cancelLoginButton, .Normal, UIColor.clearColor(), lightColoredFont, "cancel", 0.0)
                self.cancelLoginButton.titleLabel?.font = robotoLight14
                self.cancelLoginButton.titleLabel?.textAlignment = .Center
                self.cancelLoginButton.sizeToFit()
                let cancelForgotPasswordButtonYOffset = self.loginButton.frame.maxY + (viewHeightPercentage * 2.58)
                let cancelForgotPasswordButtonXOffset = centerXAlignment(self.cancelLoginButton, self.view)
                self.cancelLoginButton.frame.origin = CGPoint(x: cancelForgotPasswordButtonXOffset, y: cancelForgotPasswordButtonYOffset)
                self.cancelLoginButton.addTarget(self, action: Selector("cancelLoginButtonPressed"), forControlEvents: .TouchUpInside)
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    
                    self.cancelLoginButton.alpha = 1.0
                    
                })
                
            })
            
        }
        
    }
    
    
    
    func cancelLoginButtonPressed() {
        
        self.userNameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        self.errorLabel.text = ""
        
        println(self.loginButton.titleLabel?.text)
        
        self.userNameField.layer.borderWidth = 0.0
        self.passwordField.layer.borderWidth = 0.0
        
        if self.loginButton.titleLabel?.text == "reset password" {
            
            self.loginButton.removeTarget(self, action: Selector("forgotPasswordSubmitted"), forControlEvents: .TouchUpInside)
            self.loginButton.addTarget(self, action: Selector("emailLoginPressed"), forControlEvents: .TouchUpInside)
            self.loginButton.setTitle("login", forState: .Normal)
            self.loginButton.backgroundColor = midColor
            
        }
        
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.cancelLoginButton.alpha = 0.0
            
        })
        
        self.cancelLoginButton.setTitle("cancel", forState: .Normal)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.spacerImage.alpha = 1.0
            self.signupWithEmail.alpha = 1.0
            self.facebookButton.alpha = 1.0
            self.twitterButton.alpha = 1.0
            
        })
        
        self.passwordField.alpha = 1.0
        
        delay(0.2, { () -> () in
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                self.forgotPasswordButton.alpha = 1.0
                
            })
            
        })
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.errorLabel.frame.origin = self.errorLabelOrigin
            self.userNameField.frame.origin = self.userNameFieldOrigin
            self.passwordField.frame.origin = self.passwordFieldOrigin
            self.forgotPasswordButton.frame.origin = self.forgotPasswordButtonOrigin
            self.loginButton.frame.origin = self.loginButtonOrigin
            self.loginButton.backgroundColor = midColor
            self.loginButton.alpha = 1.0
            
        }) { (Bool) -> Void in
            
            self.cancelLoginButton.frame.origin = CGPoint(x: 0, y: 0)
            
        }
        
    }
    
    
    
    func forgotPasswordSubmitted() {
        
        self.loginButton.alpha = 0.0
        
        errorLabel.text = ""
        
        if userNameField.text.isEmpty {
            
            userNameField.layer.borderColor = redColor.CGColor
            userNameField.layer.borderWidth = 2.0
            
            errorLabel.text = "enter your email"
            
            return
            
        } else if userNameField.text.isEmpty != true {
            
            PFUser.requestPasswordResetForEmailInBackground(userNameField.text)
            
            PFUser.requestPasswordResetForEmailInBackground(userNameField.text, block: { (Bool, error) -> Void in
                
                if error != nil {
                    
                    let code = error?.code
                    
                    self.errorHandlingAndLabelText(code!)
                    
                    println(code)
                    
                } else if error == nil {
                    
                    self.loginButton.hidden == true
                    
                    self.errorLabel.textColor = highColor
                    self.errorLabel.text = "a password reset has been sent"
                    
                    delay(0.75, { () -> () in
                        
                        self.cancelLoginButtonPressed()
                        
                    })
                    
                }
                
                
            })

        }
        
    }
    
    
    
    func emailLoginPressed() {
        
        errorLabel.text = ""
        
        let userName = userNameField.text
        let passWord = passwordField.text
        
        
        if userNameField.text.isEmpty {
            
            userNameField.layer.borderColor = redColor.CGColor
            userNameField.layer.borderWidth = 2.0
            errorLabel.hidden = false
            errorLabel.text = "what's your username?"
            
            return
        }
        
        if passwordField.text.isEmpty {
            
            passwordField.layer.borderColor = redColor.CGColor
            passwordField.layer.borderWidth = 2.0
            errorLabel.hidden = false
            errorLabel.text = "what's your password?"
            
            return
        }
        
        loginButton.enabled = false
        loginButton.backgroundColor = backgroundColor
        
        SquaresActivityIndicator().replaceButtonWithActivityIndicator(self.view, button: self.loginButton, percentageSize: 7, borderWidth: 2.0)
            
            PFUser.logInWithUsernameInBackground(userName, password: passWord) { (user, error: NSError?) -> Void in
                
                if user != nil && error == nil {
                    
                    SquaresActivityIndicator().stopIndicator(self.view)
                    
                    self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                    println("case 1")
                    
                    
                }
                
                if user != nil && error != nil {
                    
                    SquaresActivityIndicator().stopIndicator(self.view)

                    self.loginButton.alpha = 1.0
                    
                    NSLog(error!.localizedDescription)
                    println("case 2")
                    
                    self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                    
                }
                
                if user == nil && error != nil {
                    
                    println("case 3")
                    
                    SquaresActivityIndicator().stopIndicator(self.view)
                    
                    self.loginButton.alpha = 1.0

                    self.loginButton.enabled = true
                    self.loginButton.backgroundColor = midColor
                    self.errorHandlingAndLabelText(error!.code)
                    
                }
            }
        
        
    }
    
    
    
    func signupWithEmailPressed() {
        
        errorLabel.text = ""
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let viewHeightPercentage = viewHeight/100
        let viewWidthPercentage = viewWidth/100
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.spacerImage.alpha = 0.0
            self.loginButton.alpha = 0.0
            self.cancelLoginButton.alpha = 0.0
            self.forgotPasswordButton.alpha = 0.0
            self.signupWithEmail.alpha = 0.0
            
        })
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.twitterButton.alpha = 0.0
            
        })
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.facebookButton.alpha = 0.0
            
        })
        
        self.errorLabelOrigin = self.errorLabel.frame.origin
        self.userNameFieldOrigin = self.userNameField.frame.origin
        self.passwordFieldOrigin = self.passwordField.frame.origin
        
        self.userNameField.attributedPlaceholder = self.attributedPlaceHolderString("username")

        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            let userNamefieldOffset = self.facebookButton.frame.origin.y - (viewHeightPercentage * 4)
            let passwordFieldOffset = userNamefieldOffset + (self.passwordField.frame.height) + (viewHeightPercentage * 1.5)
            
            self.userNameField.frame.origin.y = userNamefieldOffset
            self.passwordField.frame.origin.y = passwordFieldOffset
            
        }) { (Bool) -> Void in
            
            let errorLabelOffset = (self.userNameField.frame.minY + (viewHeightPercentage * 2))
            self.errorLabel.frame.origin = CGPoint(x: 0.0, y: errorLabelOffset)
            
            self.passwordConfirmationSignupField.frame.origin = self.passwordField.frame.origin
            
            self.passwordConfirmationSignupField.alpha = 1.0
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                let passwordConfirmationSignupFieldOffset = self.passwordField.frame.height + (viewHeightPercentage * 1.5)
                
                self.passwordConfirmationSignupField.frame.offset(dx: 0.0, dy: passwordConfirmationSignupFieldOffset)
                
                
            }, completion: { (Bool) -> Void in
                
                self.emailSignupField.frame.origin = self.passwordConfirmationSignupField.frame.origin
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    
                    self.emailSignupField.alpha = 1.0
                    
                    let emailSignupFieldYOffset = self.passwordConfirmationSignupField.frame.height + (viewHeightPercentage * 1.5)
                    
                    self.emailSignupField.frame.offset(dx: 0.0, dy: emailSignupFieldYOffset)
                    
                    
                }, completion: { (Bool) -> Void in
                    
                    self.registerButton.frame.origin = self.emailSignupField.frame.origin
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        
                        self.registerButton.alpha = 1.0
                        
                        let registerButtonYOffset = self.emailSignupField.frame.height + (viewHeightPercentage * 1.5)
                        
                        self.registerButton.frame.offset(dx: 0.0, dy: registerButtonYOffset)
                        
                        
                    }, completion: { (Bool) -> Void in
                        
                        styleButton(self.cancelRegisterButton, .Normal, UIColor.clearColor(), lightColoredFont, "cancel", 0.0)
                        self.cancelRegisterButton.titleLabel?.font = robotoLight14
                        self.cancelRegisterButton.titleLabel?.textAlignment = .Center
                        self.cancelRegisterButton.sizeToFit()
                        self.cancelRegisterButtonOrigin = self.cancelRegisterButton.frame.origin
                        let cancelRegisterButtonYOffset = self.registerButton.frame.maxY + (viewHeightPercentage * 1.35)
                        let cancelRegisterButtonXOffset = centerXAlignment(self.cancelRegisterButton, self.view)
                        self.cancelRegisterButton.frame.offset(dx: cancelRegisterButtonXOffset, dy: cancelRegisterButtonYOffset)
                        self.cancelRegisterButton.addTarget(self, action: Selector("cancelRegisterPressed"), forControlEvents: .TouchUpInside)
                        self.cancelRegisterButton.alpha = 1.0

                        
                    })
                    
                    
                    
                })
                
            })
            
        }
        
    }
    
    
    func signUpWithEmailSubmitted() {
        
        errorLabel.text = ""
        
        if passwordField.text != passwordConfirmationSignupField.text {
            
            passwordConfirmationSignupField.layer.borderColor = redColor.CGColor
            passwordField.layer.borderColor = redColor.CGColor
            
            passwordConfirmationSignupField.layer.borderWidth = 2.0
            passwordField.layer.borderWidth = 2.0
            
            errorLabel.text = "passwords do not match"
            
            return
            
        }
        
        
        registerButton.backgroundColor = backgroundColor
        registerButton.enabled = false
        
        SquaresActivityIndicator().replaceButtonWithActivityIndicator(self.view, button: registerButton, percentageSize: 7, borderWidth: 2.0)
        
        var user = PFUser()
        user.username = emailSignupField.text
        user.password = passwordConfirmationSignupField.text
        user.email = emailSignupField.text
        user["displayName"] = userNameField.text
        
        user.signUpInBackgroundWithBlock {
            
            (success: Bool, error: NSError?) -> Void in
            
            if let error = error {
                
                SquaresActivityIndicator().stopIndicator(self.view)
                
                self.registerButton.enabled = true
                self.registerButton.backgroundColor = lowColor
                let errorString = error.userInfo?["error"] as? NSString
                self.errorHandlingAndLabelText(error.code)
                
            } else if success == true {
                
                SquaresActivityIndicator().stopIndicator(self.view)
                
                self.performSegueWithIdentifier("unwindFromLoginToGameBoardController", sender: self)
                
                
            }
        }
    }
    
    
    
    func cancelRegisterPressed() {
        
        errorLabel.text = ""
        
        self.userNameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.passwordConfirmationSignupField.resignFirstResponder()
        self.emailSignupField.resignFirstResponder()
        self.errorLabel.text = ""
        
        self.userNameField.attributedPlaceholder = self.attributedPlaceHolderString("email")

        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.registerButton.alpha = 0.0
            self.passwordConfirmationSignupField.alpha = 0.0
            self.emailSignupField.alpha = 0.0
            self.cancelRegisterButton.alpha = 0.0
            
        }) { (Bool) -> Void in
            
            self.cancelRegisterButton.frame.origin = self.cancelRegisterButtonOrigin
            
        }
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            
        })
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.spacerImage.alpha = 1.0
            self.signupWithEmail.alpha = 1.0
            self.facebookButton.alpha = 1.0
            self.twitterButton.alpha = 1.0
            
        })
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.userNameField.frame.origin = self.userNameFieldOrigin
            self.passwordField.frame.origin = self.passwordFieldOrigin
            self.loginButton.alpha = 1.0
            self.forgotPasswordButton.alpha = 1.0
            self.signupWithEmail.alpha = 1.0
            
            
            }) { (Bool) -> Void in
                
                self.registerButton.frame.origin = CGPoint(x: 0, y: 0)
                
                
        }
        
        
        
    }

    
    
    func errorHandlingAndLabelText(error: Int) {
        
        let errorCode = error
        
        errorLabel.textColor = redColor
        
        switch(errorCode) {
            
        case 101:
            
            errorLabel.text = "username and password don't match"
            
        case 125:
            
            errorLabel.text = "that's not a real email address"
            
        case 200:
            
            userNameField.layer.borderWidth = 2.0
            userNameField.layer.borderColor = UIColor.redColor().CGColor
            errorLabel.text = "what's your username?"
            
        case 201:
            
            passwordField.layer.borderWidth = 2.0
            passwordField.layer.borderColor = UIColor.redColor().CGColor
            errorLabel.text = "what's your password?"
            
        case 202:
            
            userNameField.layer.borderWidth = 2.0
            userNameField.layer.borderColor = UIColor.redColor().CGColor
            errorLabel.text = "choose a different username"
            
        case 203:
            
            emailSignupField.layer.borderWidth = 2.0
            emailSignupField.layer.borderColor = UIColor.redColor().CGColor
            errorLabel.text = "this email has an account"
            
        case 204:
            
            emailSignupField.layer.borderWidth = 2.0
            emailSignupField.layer.borderColor = UIColor.redColor().CGColor
            errorLabel.text = "what's your email?"
            
        case 205:
            
            emailSignupField.layer.borderWidth = 2.0
            emailSignupField.layer.borderColor = UIColor.redColor().CGColor
            errorLabel.text = "we can't find this email"
            
        default:
            
            errorLabel.text = "try again"
            
        }
 
        
    }

    
    func attributedPlaceHolderString(string: String) -> NSAttributedString {
        
        let font = UIFont(name: "Roboto-Light", size: 16.0) ?? UIFont.systemFontOfSize(18.0)
        
        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        
        return attributedString
    }
    
    
    
}