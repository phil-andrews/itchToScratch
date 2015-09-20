//
//  YellowController.swift
//  projectY
//
//  Created by Philip Ondrejack on 5/31/15.
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

let userQuestionObjectsToBlock = PFUser.currentUser()?.valueForKey(questionsAnswered) as! NSMutableArray


class BlueController: UIViewController, CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet weak var constraintContentViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var constraintContentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintCityLabelVerticalSpace: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    var currentLocation: String = String()
    
    var currentLocationObject: PFObject?
    var currentLocationObjectID: String = String()
    var oldLocationObjectID: String = String()
    
    var usedObjectIDs: [String] = [String]()
    var questionObjectIDsForLocation: [String] = [String]()
    var pfQuestionObjects: [PFObject] = [PFObject]()
    
    var refreshTimer = NSTimer()
    var logoutTimer = NSTimer()
    var locationTimer = NSTimer()
    
    let segueToImageQuestion = "loadDetailViewWithImage"
    
    var goalToHit = 5
    var ghost = false
    var ghostVelocity = 1.0
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet var buttonOutlets: [UIButton]!
    
    @IBOutlet var overlayImageView: [UIImageView]!
    
    @IBOutlet var lockImages: [SpringImageView]!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var wrapView: UIView!
    @IBAction func returnToMaster(sender: UIStoryboardSegue) {}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.backgroundColor = backgroundColor
        self.wrapView.backgroundColor = UIColor.clearColor()
        
        self.cityLabel.textColor = UIColor.redColor()
        
        SwiftSpinner.show("Getting your location", animated: true)
        
        self.setButtonProperties()
        
        if self.currentLocationObject != nil  {
            
            self.cellHighlightingCall(self.currentLocationObject!, animation: false)
        }
        
        println(self.constraintContentViewWidth)
        
        setFonts(self.view)
        self.setConstraints()
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.checkForUser()
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        
    }
    
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // *MARK Login ////////////////////////////////////////////////////
    
    
    
    func checkForUser() {
        
        if PFUser.currentUser() == nil {
            self.loginFunc()
            
        } else if PFUser.currentUser() != nil {
            
            PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user, error) -> Void in
                
                if error == nil {
                    
                    self.startLocation()
                    self.refreshAnswerTimerCall()
                    self.locationTimerCall()
                    
                }
                
            })
            
            println("user logged in already")
        }
        
        if self.loginFunc() {
            self.setDisplayName()
        } else {
            println("display name already set")
        }
        
    }
    
    
    
    func loginFunc() -> Bool {
        
        if (PFUser.currentUser() == nil) {
            
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.fields = PFLogInFields.Default
                | PFLogInFields.Facebook
                | PFLogInFields.Twitter
            
            loginViewController.logInView?.backgroundColor = backgroundColor
            loginViewController.preferredContentSize.height = self.view.bounds.height
            loginViewController.preferredContentSize.width = self.view.bounds.width

            let loginBG = makeBackground()
            
            loginViewController.logInView?.addSubview(loginBG)
            loginViewController.logInView?.sendSubviewToBack(loginBG)
            
            loginViewController.logInView?.logo = nil
            
            
            let signupViewController = PFSignUpViewController()
            signupViewController.fields = PFSignUpFields.Default
            signupViewController.signUpView?.additionalField?.placeholder = "confirm password"
            signupViewController.signUpView?.additionalField?.secureTextEntry = true
            
            signupViewController.signUpView?.backgroundColor = backgroundColor
            signupViewController.preferredContentSize.height = self.view.bounds.height
            signupViewController.preferredContentSize.width = self.view.bounds.width
            
            let signUpBG = makeBackground()
            
            signupViewController.signUpView?.addSubview(signUpBG)
            signupViewController.signUpView?.sendSubviewToBack(signUpBG)
            
            signupViewController.signUpView?.logo = nil
            
            loginViewController.signUpController = signupViewController
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
            
            signupViewController.delegate = self
            
        }
        
        return true
        
    }
    
    
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            
            return true
            
        } else {
            
            return false
        }
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.startLocation()
        self.refreshAnswerTimerCall()
        self.locationTimerCall()
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to log in...")
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        
        let signUpViewController = PFSignUpViewController()
        
        if let password = info["password"] as? String {
            
            signUpController.signUpView?.passwordField?.backgroundColor = UIColor.redColor()
            return count(password.utf16) >= 8
        }
        return false
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.startLocation()
        self.refreshAnswerTimerCall()
        self.locationTimerCall()
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up...")
    }
    
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed sign up.")
    }
    
    
    func returnFacebookUserData()
    {
        let user = PFUser.currentUser()
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
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
    
    
    
    func setDisplayName() {
        
        let user = PFUser.currentUser()
        let userName: String? = user?.username as String?
        let twitToken = PFTwitterUtils.twitter()?.authToken
        
        if PFUser.currentUser() != nil && PFTwitterUtils.twitter()?.authToken != nil {
            println(twitToken)
            println("user logged in with Twitter")
            self.returnTwitterUserData()
            
        } else if PFUser.currentUser() != nil && (FBSDKAccessToken.currentAccessToken() != nil) {
            println("user logged in with Facebook")
            self.returnFacebookUserData()
            
        } else if PFUser.currentUser() != nil && (FBSDKAccessToken.currentAccessToken() == nil && PFTwitterUtils.twitter()?.authToken == nil) {
            user?.setObject(userName!, forKey: "displayName")
            
            user?.saveInBackground()
            
            println("user logged in without social media")
            
        }
        
    }
    
    
    func addUserToLocation() {
        
        let user = PFUser.currentUser()
        let userID = user?.objectId
        let query = PFQuery(className: LocationClass)
        query.getObjectInBackgroundWithId(self.currentLocationObjectID, block: { (locationObj: PFObject?, error) -> Void in
            
            if error == nil {
                
                if let locationObj = locationObj as PFObject? {
                    
                    var visitedUsers: NSMutableArray = locationObj.valueForKey(allVisitedUsers) as! NSMutableArray
                    
                    if visitedUsers.containsObject(userID!) == false {
                        
                        println("user is now a visited user at \(self.currentLocation)")
                        
                        visitedUsers.addObject(userID!)
                        
                        locationObj.setValue(visitedUsers, forKey: allVisitedUsers)
                        locationObj.incrementKey(totalUserCount)
                        
                    }
                    
                    let oldLocation = user?.valueForKey(usersOldLocation) as! String
                    println(oldLocation)
                    println(self.currentLocationObjectID)
                    
                    if oldLocation != self.currentLocationObjectID {
                        
                        println("hubba")
                        locationObj.incrementKey(usersLoggedInAtLocation)
                        
                        
                    }
                    
                    var usersVisitedLocations: [String] = user?.valueForKey(visitedLocations) as! [String]
                    
                    for item in usersVisitedLocations {
                        
                        if item == self.currentLocationObjectID {
                            
                            break
                            
                        } else {
                            
                            user?.addUniqueObject(self.currentLocationObjectID, forKey: visitedLocations)
                            
                            user?.saveInBackground()
                        }
                    }
                    
                    if locationObj.isDirty() == true {
                        
                        println("bubba")
                        locationObj.saveInBackground()
                        
                    }
                    
                }
                
            } else if error != nil {
                
                println(error?.localizedDescription)
                println("error in add user to locatoin")
            }
            
        })
        
    }
    
    
    
    func removeUserFromOldLocation() {
        println("remove user ran")
        let user = PFUser.currentUser()
        let userID = user?.objectId
        let oldLocation: String? = user?.valueForKey(usersOldLocation) as? String
        println("Remove User - This is the old location: \(oldLocation)")
        println("Remove User - This is the new locaiton: \(self.currentLocationObjectID)")
        
        if oldLocation?.isEmpty == false && oldLocation != self.currentLocationObjectID {
            
            let query = PFQuery(className: LocationClass)
            query.getObjectInBackgroundWithId(oldLocation!, block: { (locationObj: PFObject?, error) -> Void in
                
                if error == nil {
                    
                    if let locationObj = locationObj as PFObject? {
                        
                        locationObj.incrementKey(usersLoggedInAtLocation, byAmount: -1)
                        
                        user?.setValue(self.currentLocationObjectID, forKey: usersOldLocation)
                        
                        println("Removing user from old location: \(oldLocation)")
                        locationObj.saveInBackground()
                        user?.saveInBackground()
                        
                    }
                    
                }
                
            })
            
        } else if oldLocation?.isEmpty == true {
            
            user?.setValue(self.currentLocationObjectID, forKey: usersOldLocation)
            user?.saveInBackground()
            
            return
        }
    }
    
    
    
    // *MARK Location ////////////////////////////////////////////////////
    
    
    
    func startLocation() {
        
        println("location ran")
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.locationManager.requestWhenInUseAuthorization()
            println("auth not determined")
            
        } else if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            println("auth determined")
            
        }
        
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        
        var currentLocation = locations.last as! CLLocation
        locationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                
                println("Error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let location = placemarks.last as! CLPlacemark
                self.isLocationSet(self.locationInfo(location), completion: { (result) -> Void in
                    
                    if result == true {
                        
                        
                        self.checkForExisitngAndThenFetchLocationOrDefault2({ (IDs, locationObj) -> Void in
                            
                            println("test test")
                            println(self.currentLocationObjectID)
                            
                            
                        })
                        
                    } else {
                        
                        println("location setting handler did not work or location is already set")
                    }
                    
                })
            }
        })
    }
    
    
    
    func locationInfo(placemark: CLPlacemark) -> Bool {
        
        println(self.currentLocation)
        
        var location = ("\(placemark.locality), \(placemark.administrativeArea)")
        
        if location != self.currentLocation {
            
            SwiftSpinner.show("Getting your location", animated: true)
            
            println("location is not the same. The new location is: \(location)")
            
            currentLocation = ("\(placemark.locality), \(placemark.administrativeArea)")
            
            self.setCityLabelLayout()
            self.cityLabel.text = self.currentLocation
            self.cityLabel.textAlignment = .Center
            self.cityLabel.textColor = lightColoredFont
//            self.constraintCityLabelVerticalSpace.constant = 25

            
            
            return true
            
        } else {
            
            println("location is the same. Location is: \(self.currentLocation)")
            
            return false
        }
        
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error" + error.localizedDescription)
        
    }
    
    
    func isLocationSet(locationInfoFunction: Bool, completion: (result: Bool) -> Void) {
        
        if locationInfoFunction == true {
            completion(result: true)
            
        } else {
            completion(result: false)
            
        }
        
    }
    
    
    func locationTimerCall() {
        
        self.delay(30.0, closure: { () -> () in
            
            self.locationTimer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("startLocation"), userInfo: nil, repeats: true)
            self.locationTimer.fire()
            
        })
        
        
    }
    
    
    
    // *MARK Navigation ////////////////////////////////////////////////////
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "loadDetailViewWithImage" {
        
            var upcoming: QuestionDetail = segue.destinationViewController as! QuestionDetail
            
            self.providesPresentationContextTransitionStyle = true
            self.definesPresentationContext = true
            self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            
            let objectPlace = sender!.tag as Int
            println(objectPlace)
            
            for item in self.pfQuestionObjects {
                
                let questionObject = self.currentLocationObject?.valueForKey("Q\(objectPlace)") as! String
                
                if item.valueForKey(objectId) as! String == questionObject {
                    
                    upcoming.parseObject = item as PFObject
                    
                    break
                    
                }
                
            }
            
            upcoming.locationObject = currentLocationObject!
            upcoming.objectPlace = objectPlace
            
        }
        
    }
    
    
    
    func handleButtonPress(sender: UIButton) {
        
        self.performSegueWithIdentifier(segueToImageQuestion, sender: sender)
        
    }
    
    
    
    
    // *MARK Queries ////////////////////////////////////////////////////
    
    
    
    func checkForExisitngAndThenFetchLocationOrDefault2(completion: (IDs: [String], locationObj: PFObject) -> Void) {
        
        self.queryForLocationObject2(LocationClass, whereKey: locality, equals: self.currentLocation, defaultCompletion: { (locationObj: PFObject?) -> Void in
            
            if locationObj != nil {
                println("the object ID for this locaiton is\(locationObj?.objectId)")
                
                self.currentLocationObject = locationObj!
                
                self.currentLocationObjectID = locationObj!.objectId! as String
                
                self.getQuestionObjectIDsAndFullObjects(locationObj!, completion: { () -> Void in
                    
                    self.populateButtons()
                    self.setGoalToHit()
                    self.addUserToLocation()
                    self.removeUserFromOldLocation()
                    
                    completion(IDs: self.questionObjectIDsForLocation, locationObj: self.currentLocationObject!)
                    
                })
                
                
            } else if locationObj == nil {
                println("there are no objects at this location")
                
                self.queryForLocationObject2(LocationClass, whereKey: objectId, equals: defaultLocationObject, defaultCompletion: { (locationObj: PFObject?) -> Void in
                    
                    self.currentLocationObject = locationObj!
                    
                    self.currentLocationObjectID = locationObj!.objectId! as String
                    
                    self.getQuestionObjectIDsAndFullObjects(locationObj!, completion: { () -> Void in
                        
                        self.saveNewLocationObject(locationObj!)
                        self.populateButtons()
                        self.setGoalToHit()
                        
                        
                    })
                    
                    
                })
                
            }
            
            
        })
        
    }
    
    
    func queryForLocationObject2(parseClassName: String, whereKey: String, equals: String, defaultCompletion: (locationObj: PFObject?) -> Void) {
        
        let query = PFQuery(className: parseClassName)
        query.whereKey(whereKey, equalTo: equals)
        query.findObjectsInBackgroundWithBlock { (locationObject, error) -> Void in
            
            if error == nil && locationObject?.count != 0 {
                
                if let locationObject = locationObject as? [PFObject] {
                    
                    let defaultObject: PFObject = locationObject[0]
                    
                    defaultCompletion(locationObj: defaultObject)
                    
                }
                
            } else if locationObject?.count == 0 {
                
                defaultCompletion(locationObj: nil)
                
            } else if error != nil {
                
                println(error?.localizedDescription)
                println("error in queryForLocationObject")
                
            }
        }
    }
    
    
    
    func getQuestionObjectIDsAndFullObjects(locationObj: PFObject, completion: () -> Void) {
        
        
        for number in 0...39 {
            
            println(number)
            
            var objectID = locationObj.valueForKey("Q\(number)") as! String
            
            println(objectID)
            
            self.questionObjectIDsForLocation.append(objectID)
            
        }
        
        
        let query = PFQuery(className: QuestionClass)
        query.whereKey(objectId, containedIn: self.questionObjectIDsForLocation)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    self.pfQuestionObjects = objects
                    
                    completion()
                    
                }
                
            } else if error != nil {
                
                println(error?.localizedDescription)
                
            }
            
        }
        
    }
    
    
    
    func setButton(button: UIButton, questionObjectID: String, animation: Bool) {
        
        self.overlayImageView[button.tag].hidden = true
        self.lockImages[button.tag].hidden = !animation
        button.userInteractionEnabled = true
        
        for question in self.pfQuestionObjects {
            
            if question.objectId == questionObjectID {
                
                let imageFile = question.valueForKey(questionImage) as? PFFile
                let answerNumber = self.currentLocationObject?.valueForKey("ans\(button.tag)") as! Int
                
                if imageFile != nil {
                    
                    imageFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                        
                        if error == nil {
                            
                            button.enabled = true
                            button.setBackgroundImage(UIImage(data: data!), forState: .Normal)
                            button.setBackgroundImage(UIImage(data: data!), forState: .Disabled)

                            self.checkUsersAnsweredQuestions(button, objectID: question.objectId!)
                            self.cellHighlighting(answerNumber, cell: button, animation: animation)
                            
                        } else if error != nil {
                            
                            println(error!.localizedDescription)
                            
                        }
                        
                    })
                    
                } else if imageFile == nil {
                    
                    button.enabled = true
                    button.setBackgroundImage(UIImage(named: noQuestionImage), forState: .Normal)
                    button.setBackgroundImage(UIImage(named: noQuestionImage), forState: .Disabled)
                    self.checkUsersAnsweredQuestions(button, objectID: question.objectId!)
                    self.cellHighlighting(answerNumber, cell: button, animation: animation)
                    
                }
            }
        }
        
        if button.tag == 39 {
            
            SwiftSpinner.hide(completion: nil)
            
        }
        
    }
    
    
    
    func populateButtons() {
        
        let Q0 = self.currentLocationObject?.valueForKey("Q0") as! String
        let Q1 = self.currentLocationObject?.valueForKey("Q1") as! String
        let Q2 = self.currentLocationObject?.valueForKey("Q2") as! String
        let Q3 = self.currentLocationObject?.valueForKey("Q3") as! String
        let Q4 = self.currentLocationObject?.valueForKey("Q4") as! String
        let Q5 = self.currentLocationObject?.valueForKey("Q5") as! String
        let Q6 = self.currentLocationObject?.valueForKey("Q6") as! String
        let Q7 = self.currentLocationObject?.valueForKey("Q7") as! String
        let Q8 = self.currentLocationObject?.valueForKey("Q8") as! String
        let Q9 = self.currentLocationObject?.valueForKey("Q9") as! String
        let Q10 = self.currentLocationObject?.valueForKey("Q10") as! String
        let Q11 = self.currentLocationObject?.valueForKey("Q11") as! String
        let Q12 = self.currentLocationObject?.valueForKey("Q12") as! String
        let Q13 = self.currentLocationObject?.valueForKey("Q13") as! String
        let Q14 = self.currentLocationObject?.valueForKey("Q14") as! String
        let Q15 = self.currentLocationObject?.valueForKey("Q15") as! String
        let Q16 = self.currentLocationObject?.valueForKey("Q16") as! String
        let Q17 = self.currentLocationObject?.valueForKey("Q17") as! String
        let Q18 = self.currentLocationObject?.valueForKey("Q18") as! String
        let Q19 = self.currentLocationObject?.valueForKey("Q19") as! String
        let Q20 = self.currentLocationObject?.valueForKey("Q20") as! String
        let Q21 = self.currentLocationObject?.valueForKey("Q21") as! String
        let Q22 = self.currentLocationObject?.valueForKey("Q22") as! String
        let Q23 = self.currentLocationObject?.valueForKey("Q23") as! String
        let Q24 = self.currentLocationObject?.valueForKey("Q24") as! String
        let Q25 = self.currentLocationObject?.valueForKey("Q25") as! String
        let Q26 = self.currentLocationObject?.valueForKey("Q26") as! String
        let Q27 = self.currentLocationObject?.valueForKey("Q27") as! String
        let Q28 = self.currentLocationObject?.valueForKey("Q28") as! String
        let Q29 = self.currentLocationObject?.valueForKey("Q29") as! String
        let Q30 = self.currentLocationObject?.valueForKey("Q30") as! String
        let Q31 = self.currentLocationObject?.valueForKey("Q31") as! String
        let Q32 = self.currentLocationObject?.valueForKey("Q32") as! String
        let Q33 = self.currentLocationObject?.valueForKey("Q33") as! String
        let Q34 = self.currentLocationObject?.valueForKey("Q34") as! String
        let Q35 = self.currentLocationObject?.valueForKey("Q35") as! String
        let Q36 = self.currentLocationObject?.valueForKey("Q36") as! String
        let Q37 = self.currentLocationObject?.valueForKey("Q37") as! String
        let Q38 = self.currentLocationObject?.valueForKey("Q38") as! String
        let Q39 = self.currentLocationObject?.valueForKey("Q39") as! String
        
        self.setButton(buttonOutlets[0], questionObjectID: Q0, animation: false)
        self.setButton(buttonOutlets[1], questionObjectID: Q1, animation: false)
        self.setButton(buttonOutlets[2], questionObjectID: Q2, animation: false)
        self.setButton(buttonOutlets[3], questionObjectID: Q3, animation: false)
        self.setButton(buttonOutlets[4], questionObjectID: Q4, animation: false)
        self.setButton(buttonOutlets[5], questionObjectID: Q5, animation: false)
        self.setButton(buttonOutlets[6], questionObjectID: Q6, animation: false)
        self.setButton(buttonOutlets[7], questionObjectID: Q7, animation: false)
        self.setButton(buttonOutlets[8], questionObjectID: Q8, animation: false)
        self.setButton(buttonOutlets[9], questionObjectID: Q9, animation: false)
        self.setButton(buttonOutlets[10], questionObjectID: Q10, animation: false)
        self.setButton(buttonOutlets[11], questionObjectID: Q11, animation: false)
        self.setButton(buttonOutlets[12], questionObjectID: Q12, animation: false)
        self.setButton(buttonOutlets[13], questionObjectID: Q13, animation: false)
        self.setButton(buttonOutlets[14], questionObjectID: Q14, animation: false)
        self.setButton(buttonOutlets[15], questionObjectID: Q15, animation: false)
        self.setButton(buttonOutlets[16], questionObjectID: Q16, animation: false)
        self.setButton(buttonOutlets[17], questionObjectID: Q17, animation: false)
        self.setButton(buttonOutlets[18], questionObjectID: Q18, animation: false)
        self.setButton(buttonOutlets[19], questionObjectID: Q19, animation: false)
        self.setButton(buttonOutlets[20], questionObjectID: Q20, animation: false)
        self.setButton(buttonOutlets[21], questionObjectID: Q21, animation: false)
        self.setButton(buttonOutlets[22], questionObjectID: Q22, animation: false)
        self.setButton(buttonOutlets[23], questionObjectID: Q23, animation: false)
        self.setButton(buttonOutlets[24], questionObjectID: Q24, animation: false)
        self.setButton(buttonOutlets[25], questionObjectID: Q25, animation: false)
        self.setButton(buttonOutlets[26], questionObjectID: Q26, animation: false)
        self.setButton(buttonOutlets[27], questionObjectID: Q27, animation: false)
        self.setButton(buttonOutlets[28], questionObjectID: Q28, animation: false)
        self.setButton(buttonOutlets[29], questionObjectID: Q29, animation: false)
        self.setButton(buttonOutlets[30], questionObjectID: Q30, animation: false)
        self.setButton(buttonOutlets[31], questionObjectID: Q31, animation: false)
        self.setButton(buttonOutlets[32], questionObjectID: Q32, animation: false)
        self.setButton(buttonOutlets[33], questionObjectID: Q33, animation: false)
        self.setButton(buttonOutlets[34], questionObjectID: Q34, animation: false)
        self.setButton(buttonOutlets[35], questionObjectID: Q35, animation: false)
        self.setButton(buttonOutlets[36], questionObjectID: Q36, animation: false)
        self.setButton(buttonOutlets[37], questionObjectID: Q37, animation: false)
        self.setButton(buttonOutlets[38], questionObjectID: Q38, animation: false)
        self.setButton(buttonOutlets[39], questionObjectID: Q39, animation: false)
        
    }
    
    
    
    func saveLocationObject() {
        
        self.currentLocationObject?.setValue(self.questionObjectIDsForLocation, forKey: currentObjectsForLocation)
        self.currentLocationObject?.saveInBackground()
        
    }
    
    
    
    func saveNewLocationObject(defaultObjectForNewLocation: PFObject) {
        
        
        println("should be saving")
        
        let newLocationObject = PFObject(className: LocationClass)
        newLocationObject[locality] = self.currentLocation
        newLocationObject[allVisitedUsers] = [""]
        newLocationObject[usersLoggedInAtLocation] = 0
        newLocationObject[usedQuestionObjects] = self.questionObjectIDsForLocation
        
        var count = 0
        
        while count < 40 {
            
            newLocationObject["ans\(count)"] = 0
            newLocationObject["Q\(count)"] = self.currentLocationObject?.valueForKey("Q\(count)") as! String
            count = count + 1
            
        }
        
        
        newLocationObject.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                
                println("new location object saved")
                
                self.currentLocationObject = newLocationObject
                self.currentLocationObjectID = newLocationObject.objectId!
                self.addUserToLocation()
                self.removeUserFromOldLocation()
                
            } else if error != nil {
                
                println(error)
                println("error in saveNewLocationObject")
                
            }
            
        }
        
    }
 
    
    func refreshUser() {
        
        let user = PFUser.currentUser()
        let query = PFUser.query()
        let userObjectID = user?.objectId
        query?.getObjectInBackgroundWithId(userObjectID!)
        
        
        
    }
    
    
    func refreshAnswerNumbers() {
        
        let query = PFQuery(className: LocationClass)
        query.whereKey(locality, equalTo: self.currentLocation)
        query.findObjectsInBackgroundWithBlock { (locationObj, error) -> Void in
            
            println(self.currentLocation)
            
            if error != nil {
                
                println("problem in refreshAnswerNumbers: \(error)")
                
            } else if error == nil {
                
                if let locationObj = locationObj as? [PFObject] {
                    
                    let object = locationObj[0]
                    let buttonsThatMatch: NSMutableArray = []
                    
                    for number in 0...39 {
                        
                        let currentObject = self.currentLocationObject?.valueForKey("Q\(number)") as! String
                        let fetchedObject = object.valueForKey("Q\(number)") as! String
                        
                        if currentObject != fetchedObject {
                            
                            buttonsThatMatch.addObject(number)
                            
                        }
                    }
                    
                    if buttonsThatMatch.count != 0 {
                        
                        println("there are buttons that had new fetched objID's : \(buttonsThatMatch)")
                        
                        //animate completed cells 
                        //populate new question Objects
                        
                        return
                        
                    }
                    
                    if buttonsThatMatch.count == 0 {
                        
                        println("no buttons had new fetched objID's")
                        
                        self.currentLocationObject = object
                        
                        self.cellHighlightingCall(self.currentLocationObject!, animation: true)
                        
                        self.checkForMatchingCells(self.goalToHit, locationObject: self.currentLocationObject)
                        
                        if self.ghost == true {
                            
                            self.ghostCall()
                            
                        }
                        
                    }
                    
                    
                }
            
            }
            
        }
        
        
    }

    
    
    func refreshAnswerTimerCall() {
        
        self.delay(20.0, closure: { () -> () in
            
            self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: Selector("refreshAnswerNumbers"), userInfo: nil, repeats: true)
            self.refreshTimer.fire()
            
        })
        
        
    }
    
    
    
    // *MARK Cell Highlighting ////////////////////////////////////////////////////
    
    
    
    func setGoalToHit() {
        
        let numberOfCurrentUsers = self.currentLocationObject?.valueForKey(usersLoggedInAtLocation) as! Double
        
        switch(numberOfCurrentUsers) {
            
        case 1, 2:
            
            self.goalToHit = 5
            self.ghost = true
            self.ghostVelocity = 1.0

        case 3, 4:
            
            self.goalToHit = 5
            self.ghost = true
            self.ghostVelocity = 0.5
            
        case 5:
            
            self.goalToHit = 5
            self.ghost = true
            self.ghostVelocity = 0.25
            
        case 6...10000 :
            
            var goalToHitWithRemainder = (numberOfCurrentUsers / 2.5)
            self.goalToHit = Int(goalToHitWithRemainder)
            self.ghost = false
            
        default :
            
            self.goalToHit = 5
            self.ghost = true
            self.ghostVelocity = 0.5
            
        }
        
        println(self.goalToHit)
        
    }
    
    
    func ghostCall() {
        
        println("ghost was called")
        
        switch(self.ghostVelocity) {
            
        case 0.5:
            
            var randomGen = Int(arc4random_uniform(2))

            if randomGen == 0 {
                
                return
                
            } else if randomGen == 1 {
                
                break
            }
            
        case 0.25:
            
            var randomGen = Int(arc4random_uniform(3))
            
            if randomGen == 0 | 1 | 2{
                
                return
                
            } else if randomGen == 3 {
                
                break
            }
            
        default:
            
            break
            
        }
        
        
        let query = PFQuery(className: LocationClass)
        query.getObjectInBackgroundWithId(self.currentLocationObjectID, block: { (object: PFObject?, error) -> Void in
            
            if error != nil {
                
                println(error?.localizedDescription)
                
            }
            
            if error == nil {
                
                if let object = object as PFObject? {
                
                    var randomGen = Int(arc4random_uniform(40))
                    
                    println("this is the random answer number: \(randomGen)")
                    
                    object.incrementKey("ans\(randomGen)")
                    
                    object.saveInBackground()
                    
                }
                
            }
            
        })
        
    }
    
    
    
    func checkUsersAnsweredQuestions(button: UIButton, objectID: String) {
        
        let user = PFUser.currentUser()
        let cell = self.lockImages[button.tag]
        let overLay = self.overlayImageView[button.tag]
        overLay.hidden = true
        
        cell.clipsToBounds = true
        button.clipsToBounds = true
        
        var image = UIImage(named: answeredCorrectMid)
        
        let answerNumber = self.currentLocationObject?.valueForKey("ans\(button.tag)") as! Int
        let percentage = Int(Double(answerNumber) / Double(self.goalToHit) * 100)
        
        switch(percentage) {
            
        case 0...20:
            
            image = UIImage(named: answeredCorrectLowest)
            
        case 21...40:
            
            image = UIImage(named: answeredCorrectLow)

        case 41...60:
            
            image = UIImage(named: answeredCorrectMid)
            
        case 61...80:
            
            image = UIImage(named: answeredCorrectHigh)
            
        case 81...99:
            
            image = UIImage(named: answeredCorrectHighest)
            
        default:
            
            image = UIImage(named: answeredCorrectMid)

            
        }
        
        
        let usersAnsweredQuestions = userQuestionObjectsToBlock

        if usersAnsweredQuestions.containsObject(objectID) {
            
            button.enabled = false
            cell.userInteractionEnabled = false
            cell.image = image
            
            if cell.hidden == true {
                
                cell.hidden = false
                
                cell.center.x -= cell.bounds.width
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    cell.center.x += cell.bounds.width
                    
                })
                
            }
            
        }
        
    }
    
    
    func cellHighlighting(answerNumberItem: Int, cell: UIButton, animation: Bool) {
        
        let percentage = Int(Double(answerNumberItem) / Double(self.goalToHit) * 100)
        
        let imageView2 = UIImageView(image: UIImage(named: allDone))
        let imageView3 = UIImageView(image: UIImage(named: lowestCountOverlay))
        let imageView4 = UIImageView(image: UIImage(named: lowCountOverlay))
        let imageView5 = UIImageView(image: UIImage(named: midCountOverlay))
        let imageView6 = UIImageView(image: UIImage(named: highCountOverlay))
        let imageView7 = UIImageView(image: UIImage(named: highestCountOverlay))
        
        switch(percentage) {
            
        case 0 :
            
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clearColor().CGColor
            cell.userInteractionEnabled = true
            
            
        case 1...20:
            
            if self.lockImages[cell.tag].hidden == false {
                
                cell.layer.borderWidth = 0.0
                
                break
                
            }
            
            if cell.layer.borderWidth == 0 && animation == true {
                
                self.popAnimation(cell.tag, overlayImage: lowestCountOverlay, completion: { () -> Void in
                    
                    cell.layer.borderWidth = 1.0
                    cell.layer.borderColor = lowestColor.CGColor
              })

            } else if animation == false {
                
                cell.layer.borderWidth = 1.0
                cell.layer.borderColor = lowestColor.CGColor
                
            }

            cell.userInteractionEnabled = true
            
        case 21...40:
            
            if self.lockImages[cell.tag].hidden == false {
                
                cell.layer.borderWidth = 0.0
                
                break
                
            }
            
            if cell.layer.borderWidth <= 1.0 && animation == true  {
                
                self.popAnimation(cell.tag, overlayImage: lowCountOverlay, completion: { () -> Void in
                    
                    cell.layer.borderColor = lowColor.CGColor
                    cell.layer.borderWidth = 1.5
                    
                })
                
            } else if animation == false {
                
                cell.layer.borderColor = lowColor.CGColor
                cell.layer.borderWidth = 1.5
                
            }
            
            cell.userInteractionEnabled = true

            
        case 41...60:
            
            if self.lockImages[cell.tag].hidden == false {
                
                cell.layer.borderWidth = 0.0
                
                break
                
            }
            
            if cell.layer.borderWidth <= 1.5 && animation == true {
                
                self.popAnimation(cell.tag, overlayImage: midCountOverlay, completion: { () -> Void in
                    
                    cell.layer.borderColor = midColor.CGColor
                    cell.layer.borderWidth = 2.0
                    
                })
                
            } else if animation == false {
                
                cell.layer.borderColor = midColor.CGColor
                cell.layer.borderWidth = 2.0
                
            }
            
            cell.userInteractionEnabled = true

        case 61...80:
            
            if self.lockImages[cell.tag].hidden == false {
                
                cell.layer.borderWidth = 0.0
                
                break
                
            }
            
            if cell.layer.borderWidth <= 2.0 && animation == true {
                
                self.popAnimation(cell.tag, overlayImage: highCountOverlay, completion: { () -> Void in
                    
                    cell.layer.borderColor = highColor.CGColor
                    cell.layer.borderWidth = 2.5
                    
                })
                
            } else if animation == false {
                
                cell.layer.borderColor = highColor.CGColor
                cell.layer.borderWidth = 2.5
                
            }

            cell.userInteractionEnabled = true
            
        case 81...99:
            
            if self.lockImages[cell.tag].hidden == false {
                
                cell.layer.borderWidth = 0.0
                
                break
                
            }
            
            if cell.layer.borderWidth <= 2.5 && animation == true {
                
                self.popAnimation(cell.tag, overlayImage: highestCountOverlay, completion: { () -> Void in
                    
                    cell.layer.borderColor = highestColor.CGColor
                    cell.layer.borderWidth = 2.5
                    
                })
                
            } else if animation == false {
                
                cell.layer.borderColor = highestColor.CGColor
                cell.layer.borderWidth = 2.5
                
            }

            cell.userInteractionEnabled = true
            
        case 100...10000:

            cell.layer.borderWidth = 0
            cell.userInteractionEnabled = false
            
            self.lockImages[cell.tag].hidden = false
            self.lockImages[cell.tag].image = UIImage(named: allDone)
                
            
        default:
                
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clearColor().CGColor
            
            
        }
        
    }

    
    
    func cellHighlightingCall(locationObj: PFObject, animation: Bool) {
        
        for number in 0...39 {
            
            let answerNumber = locationObj.valueForKey("ans\(number)") as! Int
            let questionID = locationObj.valueForKey("Q\(number)") as! String
            
            self.checkUsersAnsweredQuestions(buttonOutlets[number], objectID: questionID)

            self.cellHighlighting(answerNumber, cell: buttonOutlets[number], animation: animation)
            
        }
        
    }
    
    
    
    
    // *MARK Cell Matching ////////////////////////////////////////////////////
    
    
    
    func checkForMatchingCells(numberToHit: Int, locationObject: PFObject?) {
        
        var includedIndexes = [9,10,11,12,13,14,15,18,19,20,21,22,23,26,27,28,29,30,30]
        
        var match: Bool = false
        
        outerLoop: for master: Int in includedIndexes {
            
            var minusOne = Int(master - 1)
            var plusOne = Int(master + 1)
            var minusSeven = Int(master - 7)
            var plusSeven = Int(master + 7)
            var minusEight = Int(master - 8)
            var plusEight = Int(master + 8)
            var minusNine = Int(master - 9)
            var plusNine = Int(master + 9)
            
            //            println("\(minusOne) \(plusOne) \(minusSeven) \(plusSeven) \(minusEight) \(plusEight) \(minusNine) \(plusNine)")
            
            self.checkAnswers(master, cell1: minusOne, cell2: minusNine, cell3: minusEight, goal: numberToHit, locationObject: locationObject!, match: &match)
            
            if match == true {
                
                self.cellMatchAnimation(master, cell2: minusOne, cell3: minusNine, cell4: minusEight)
                
                
                self.setGoalToHit()
                self.getNewQuestionsForMatchingCells(master, cell2: minusOne, cell3: minusNine, cell4: minusEight, completion: { () -> Void in
                    
                        self.checkForMatchingCells(self.goalToHit, locationObject: self.currentLocationObject)
                    
                    })
                
                match = false
                break outerLoop
            }
            
            self.checkAnswers(master, cell1: minusOne, cell2: plusSeven, cell3: plusEight, goal: numberToHit, locationObject: locationObject!, match: &match)
            
            if match == true {
                
                self.cellMatchAnimation(master, cell2: minusOne, cell3: plusSeven, cell4: plusEight)

      
                self.setGoalToHit()
                self.getNewQuestionsForMatchingCells(master, cell2: minusOne, cell3: plusSeven, cell4: plusEight, completion: { () -> Void in
                    
                    self.checkForMatchingCells(self.goalToHit, locationObject: self.currentLocationObject)
                    
                    
                })
                
                match = false
                break outerLoop
            }
            
            self.checkAnswers(master, cell1: plusOne, cell2: minusSeven, cell3: minusEight, goal: numberToHit, locationObject: locationObject!, match: &match)
            
            if match == true {
                
                self.cellMatchAnimation(master, cell2: plusOne, cell3: minusSeven, cell4: minusEight)

                
                self.setGoalToHit()
                self.getNewQuestionsForMatchingCells(master, cell2: plusOne, cell3: minusSeven, cell4: minusEight, completion: { () -> Void in
                    
                    self.checkForMatchingCells(self.goalToHit, locationObject: self.currentLocationObject)
                    
                })
                
                match = false
                
                break outerLoop
            }
            
            self.checkAnswers(master, cell1: plusOne, cell2: plusNine, cell3: plusEight, goal: numberToHit, locationObject: locationObject!, match: &match)
            
            if match == true {
                
                self.cellMatchAnimation(master, cell2: plusOne, cell3: plusNine, cell4: plusEight)
                
                self.setGoalToHit()
                self.getNewQuestionsForMatchingCells(master, cell2: plusOne, cell3: plusNine, cell4: plusEight, completion: { () -> Void in
                    
                    self.checkForMatchingCells(self.goalToHit, locationObject: self.currentLocationObject)
                    
                })
                
                match = false
                
                break outerLoop
            }
            
        }
        
    }
    
    
    
    
    func checkAnswers(masterCell: Int, cell1: Int, cell2: Int, cell3: Int, goal: Int, locationObject: PFObject, inout match: Bool ) {
        
        let answers = questionObjectIDsForLocation
        
        var button1 = locationObject.valueForKey("ans\(masterCell)") as! Int
        var button2 = locationObject.valueForKey("ans\(cell1)") as! Int
        var button3 = locationObject.valueForKey("ans\(cell2)") as! Int
        var button4 = locationObject.valueForKey("ans\(cell3)") as! Int
        
        if button1 >= goal && button2 >= goal && button3 >= goal && button4 >= goal {
            
            match = true
            
            println("these cells match: \(masterCell, cell1, cell2, cell3)")
            
            
        }
        
    }
    
    
    
    func getNewQuestionsForMatchingCells(cell1: Int, cell2: Int, cell3: Int, cell4: Int, completion: () -> Void) {
        
        let query = PFQuery(className: QuestionClass)
        let excludeIDs = self.currentLocationObject?.valueForKey(usedQuestionObjects) as! [AnyObject]
        query.whereKey(objectId, notContainedIn: excludeIDs)
        query.limit = 4
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error != nil {
                
                println(error?.localizedDescription)
                
            } else if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    self.currentLocationObject?.addObjectsFromArray(objects, forKey: usedQuestionObjects)
                    self.updateLocationObjectAndSetButtonsAfterMatch(cell1, cell2: cell2, cell3: cell3, cell4: cell4, objects: objects, completion: { () -> Void in
                        
                            completion()
                        
                    })
                    
                }
                
            }
            
        }

    }
    
    
    
    func updateLocationObjectAndSetButtonsAfterMatch(cell1: Int, cell2: Int, cell3: Int, cell4: Int, objects: [PFObject], completion: () -> Void) {
      
        let query = PFQuery(className: LocationClass)
        query.getObjectInBackgroundWithId(self.currentLocationObjectID, block: { (locationObj: PFObject?, error) -> Void in
            
            let currentObject1 = self.currentLocationObject?.valueForKey("Q\(cell1)") as! String
            let currentObject2 = self.currentLocationObject?.valueForKey("Q\(cell2)") as! String
            let currentObject3 = self.currentLocationObject?.valueForKey("Q\(cell3)") as! String
            let currentObject4 = self.currentLocationObject?.valueForKey("Q\(cell4)") as! String
            
            let newObject1 = locationObj?.valueForKey("Q\(cell1)") as! String
            let newObject2 = locationObj?.valueForKey("Q\(cell2)") as! String
            let newObject3 = locationObj?.valueForKey("Q\(cell3)") as! String
            let newObject4 = locationObj?.valueForKey("Q\(cell4)") as! String
            
            println(newObject1)
            println(newObject2)
            println(newObject3)
            println(newObject4)

            if currentObject1 != newObject1 || currentObject2 != newObject2 || currentObject3 != newObject3 || currentObject4 != newObject4 {
                
                self.currentLocationObject = locationObj
                self.checkForMatchingCells(self.goalToHit, locationObject: self.currentLocationObject)
                
                return
                
            }
            
            self.currentLocationObject = locationObj
            
            self.currentLocationObject?.setValue(objects[0].objectId, forKey: "Q\(cell1)")
            self.currentLocationObject?.setValue(objects[1].objectId, forKey: "Q\(cell2)")
            self.currentLocationObject?.setValue(objects[2].objectId, forKey: "Q\(cell3)")
            self.currentLocationObject?.setValue(objects[3].objectId, forKey: "Q\(cell4)")
            
            self.currentLocationObject?.setValue(0, forKey: "ans\(cell1)")
            self.currentLocationObject?.setValue(0, forKey: "ans\(cell2)")
            self.currentLocationObject?.setValue(0, forKey: "ans\(cell3)")
            self.currentLocationObject?.setValue(0, forKey: "ans\(cell4)")
            
            self.currentLocationObject?.addObject(objects[0].objectId!, forKey: usedQuestionObjects)
            self.currentLocationObject?.addObject(objects[1].objectId!, forKey: usedQuestionObjects)
            self.currentLocationObject?.addObject(objects[2].objectId!, forKey: usedQuestionObjects)
            self.currentLocationObject?.addObject(objects[3].objectId!, forKey: usedQuestionObjects)
            
            self.currentLocationObject?.saveInBackground()
            
            self.getQuestionObjectIDsAndFullObjects(self.currentLocationObject!, completion: { () -> Void in
                
                let objectIDOne = self.currentLocationObject?.valueForKey("Q\(cell1)") as! String
                let objectIDTwo = self.currentLocationObject?.valueForKey("Q\(cell2)") as! String
                let objectIDThree = self.currentLocationObject?.valueForKey("Q\(cell3)") as! String
                let objectIDFour = self.currentLocationObject?.valueForKey("Q\(cell4)") as! String
                
                println(cell1)
                println(cell2)
                println(cell3)
                println(cell4)
                
                println(objectIDOne)
                println(objectIDTwo)
                println(objectIDThree)
                println(objectIDFour)
                
                self.setButton(self.buttonOutlets[cell1], questionObjectID: objectIDOne, animation: true)
                self.setButton(self.buttonOutlets[cell2], questionObjectID: objectIDTwo, animation: true)
                self.setButton(self.buttonOutlets[cell3], questionObjectID: objectIDThree, animation: true)
                self.setButton(self.buttonOutlets[cell4], questionObjectID: objectIDFour, animation: true)
                
                completion()
                
                
            })
            
        })
        
        
    }
    


    
    // *MARK Utility ////////////////////////////////////////////////////
    
    
    func setButtonProperties() {
        
        var count = 0
        
        for item in buttonOutlets {
        
            item.titleLabel?.textColor = UIColor.clearColor()
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 2.0
            item.layer.borderWidth = 0.0
            item.tag = count
            item.addTarget(self, action: Selector("handleButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
            item.addSubview(self.lockImages[count])
            
            count = count + 1
        }

        
        for item in overlayImageView {
            
            item.hidden = true
            
        }
        
        for item in lockImages {
            
            item.hidden = true
            
        }
        
        
    }
    
    
    
    func popAnimation(indexNumber: Int, overlayImage: String, completion: () -> Void) {
        
        let image = self.overlayImageView[indexNumber]
        image.hidden = false
        image.alpha = 0.0
        
        var randomGen = Double(arc4random_uniform(9))

        
        UIView.animateWithDuration(0.35, delay: randomGen, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            
            image.image = UIImage(named: overlayImage)
            image.alpha = 1.0
            
            
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    
                        completion()
                        image.hidden = false
                        image.image = UIImage(named: overlayImage)
                        image.alpha = 0.0
        
                    
                    }, completion: { (Bool) -> Void in
                        
                })
 
        })
    
    }
    
    
    func cellMatchAnimation(cell1: Int, cell2: Int, cell3: Int, cell4: Int) {

        let cellArray = [cell1, cell2, cell3, cell4]
        
        for cell in cellArray {
            
            self.lockImages[cell].hidden = false
            self.lockImages[cell].image = nil
            //self.lockImages[cell].backgroundColor = lowestColor
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                self.lockImages[cell].layer.backgroundColor = lowColor.CGColor
                
                
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    
                    self.lockImages[cell].layer.backgroundColor = midColor.CGColor
                    
                }, completion: { (Bool) -> Void in
                    
                    
                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                        
                        self.lockImages[cell].layer.backgroundColor = highColor.CGColor
                        
                    }, completion: { (Bool) -> Void in
                        
                        
                        UIView.animateWithDuration(1.0, animations: { () -> Void in
                            
                            self.lockImages[cell].layer.backgroundColor = highestColor.CGColor
                            
                        }, completion: { (Bool) -> Void in
                            
                            var count = 0
                            
                            for cell in cellArray {
                                
                                ++count
                                
                                if self.buttonOutlets[cell].enabled == false {
                                    
                                    self.cellMatchAnimation(cell1, cell2: cell2, cell3: cell3, cell4: cell4)
                                 
                                    
                                    break
                                }
                                
                                if count == 4 {
                                    
                                    for cell in cellArray {
                                        
                                        self.lockImages[cell].layer.backgroundColor = UIColor.clearColor().CGColor
                                        self.lockImages[cell].hidden = true
                                    }
                                    
                                }
                                
                            }
                            
                        })
                        
                    })
                    
                })
                
            })
            
        }

    }

    
    func setConstraints() {
        
        let viewHeight = self.view.frame.height
        
        switch(viewHeight) {
            
        case 480:
            
            self.constraintContentViewWidth.constant = -35
            self.constraintContentViewHeight.constant = 0
            self.cityLabel.font = font1
            
        default:
            
            break
            
        }
        
        
    }
    
    func setCityLabelLayout() {
        
        let viewHeight = self.view.frame.height
        
        println(viewHeight)
        
        switch(viewHeight) {
            
        case 0...500:
            
            self.constraintCityLabelVerticalSpace.constant = 2
            self.cityLabel.font = robotoLight14
            
            println(23)
            
        case 501...568:
            self.constraintCityLabelVerticalSpace.constant = 6
            self.cityLabel.font = robotoLight16
            
            println(44)
            
        case 600...667:
            self.constraintCityLabelVerticalSpace.constant = 10
            self.cityLabel.font = robotoLight18
            
        case 668...736:
            self.constraintCityLabelVerticalSpace.constant = 15
            self.cityLabel.font = robotoLight20
            
            println(88)
            
        default:
            
            break
            
        }
        
        
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    

    
    
    
}



