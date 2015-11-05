//
//  GameBoardViewController.swift
//  
//
//  Created by Philip Ondrejack on 10/30/15.
//
//

import Foundation
import UIKit
import CoreLocation
import Parse
import ParseUI
import Bolts

var usersCurrentLocationData = CLLocation()

class GameBoardViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var swipeToMaps: UISwipeGestureRecognizer!
    
    @IBOutlet var swipeToProfile: UISwipeGestureRecognizer!
    
    var orderingQuestionLabel1 = UILabel()
    var orderingQuestionLabel2 = UILabel()
    var orderingQuestionLabel3 = UILabel()
    var orderingQuestionLabel4 = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColor
        
        setFonts(self.view)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.checkForUser()
        
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    
    var hideStatusBar = false
    
    override func prefersStatusBarHidden() -> Bool {
        
        
        return hideStatusBar
    }
    
    
    @IBAction func unwindToGameBoardViewController(segue: UIStoryboardSegue) {
        

        
    }
    
    //////Login and User
    ///////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    
    var userCurrentLocation: String?
    var userOldLocation: String?
    
    
    func checkForUser() {
        
        if PFUser.currentUser() == nil {
            
            var loginStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            var loginViewController: LoginViewController = storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
            
            
        } else if PFUser.currentUser() != nil {
            
            println("user doesn't equal nil")
            
            PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user, error) -> Void in
                
                if error == nil && user != nil {
                    
                    self.startLocation()

                    
                } else if error != nil && user != nil {
                    
                    self.startLocation()

                    
                }
                
            })
            
            println("user logged in already")
        }
        
    }
    
    
    //////Location
    ///////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    
    
    let locationManager = CLLocationManager()
    var currentLocation: String?
    var currentLocationObject: PFObject?
    var questionObjectsForLocation: [PFObject]?
    var locationTimer = NSTimer()
    
    
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
        
        var newestLocation = locations.last as! CLLocation
        usersCurrentLocationData = newestLocation
        locationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(newestLocation, completionHandler: {(placemarks, error: NSError?) -> Void in
         
            if error != nil {
                
                NSLog(error!.localizedDescription)
                println("error in getting placemarks")
                
                
            } else if error == nil {
                
                let locationPlacemarks = placemarks.last as! CLPlacemark
                var subLocality = String()
                var locationString = String()
                
                if let subLocality = locationPlacemarks.subLocality {
                    
                    locationString = ("\(locationPlacemarks.subLocality), \(locationPlacemarks.administrativeArea)")
                    println("the location has a sublocality: \(locationString)")
                    
                } else {
                    
                    locationString = ("\(locationPlacemarks.locality), \(locationPlacemarks.administrativeArea)")
                    println("the location does not have a sublocality: \(locationString)")

                    
                }
                
                if locationString != self.currentLocation {
                    
                    if self.currentLocation != nil {
                        
                        ////////////////Show activity indicator: "You've moved to a new area"

                    } else {
                        
                        ////////////////Show activity indicator: "Tidying up the place"
                        
                    }
                    
                    self.currentLocation = locationString
                    
                    queryForSingleObjectInBackgroundWithBlock(LocationClass, locality, locationString, { (locationObject: PFObject?, parseError: NSError?) -> Void in
                        
                        if parseError?.code == 101 {
                            
                            queryForSingleObjectInBackgroundWithBlock(LocationClass, objectId, defaultLocationObject, { (defaultLocationObject: PFObject?, parseError: NSError?) -> Void in
                                
                                saveNewLocationObject(defaultLocationObject!, locationString, { (success, newObject) -> Void in
                                    
                                    if success {
                                        
                                        self.currentLocationObject = newObject
                                        
                                        addAndSubtractUserFromLocationCount(self.currentLocationObject!)
                                        
                                        drawCityLabel(self.view, self.currentLocationObject!)
                                        
                                        let questionIDs = separateObjectIDs(self.currentLocationObject!)
                                        
                                        queryForMultipleObjectsInBackgroundWithBlock(QuestionClass, objectId, questionIDs) { (questionObjects, error) -> Void in
                                            
                                            if error != nil {
                                                
                                                NSLog(error!.localizedDescription)
                                                println("error in query for question objects")
                                                
                                            } else if error == nil {
                                                
                                                self.questionObjectsForLocation = questionObjects
                                                
                                                drawButtons(self.view, self, "presentQuestion", { () -> Void in
                                                    
                                                    populateGameBoard(self.view, questionObjects, questionIDs, self.currentLocationObject!)
                                                    
                                                })
                                                
                                            }
                                            
                                        }
                                        
                                    } else if success == false {
                                        
                                        println("did not pass through new location object")
                                    }
                                    
                                })
                                
                                //populate board -> stop spinner

                                println("currentLocationObject is defaultLocationObject")
                                
                            })
                            
                        } else if locationObject != nil && error == nil {
                            
                            self.currentLocationObject = locationObject
                            
                            addAndSubtractUserFromLocationCount(self.currentLocationObject!)
                            
                            drawCityLabel(self.view, self.currentLocationObject!)
                            
                            let questionIDs = separateObjectIDs(self.currentLocationObject!)
                            
                            queryForMultipleObjectsInBackgroundWithBlock(QuestionClass, objectId, questionIDs) { (questionObjects, error) -> Void in
                                
                                if error != nil {
                                    
                                    NSLog(error!.localizedDescription)
                                    println("error in query for question objects")
                                    
                                } else if error == nil {
                                    
                                    self.questionObjectsForLocation = questionObjects
                                    
                                    drawButtons(self.view, self, "presentQuestion:", { () -> Void in
                                        
                                        populateGameBoard(self.view, questionObjects, questionIDs, self.currentLocationObject!)
                                        
                                    })
                                    
                                }
                                
                            }
                            
                            println("currentLocationObject is not the defaultLocationObject")

                        }
                        
                        
                        
                    })
                    
                } else if locationString == self.currentLocation {
                    
                    println("location is the same")
                    
                }

            }
            
        })
    
    }

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        NSLog(error!.localizedDescription)
        println("Error" + error.localizedDescription)
        
    }
    
    
    
    
    func presentQuestion(sender: AnyObject?) {
        
        let tagNumber = sender!.tag
        let questionID = self.currentLocationObject?.valueForKey("Q\(tagNumber - 1)") as! String
        let questionObjects = self.questionObjectsForLocation as [PFObject]!
        var questionToPresent: PFObject?
        
        for item in questionObjects {
            
            let id: String = item.objectId!
            
            if id == questionID {
                
                questionToPresent = item
                
            }
            
        }
                
        let type = questionToPresent?.valueForKey(questionType) as! Int
        let questionString = questionToPresent?.valueForKey(questionAsk) as! String
        let category = questionToPresent?.valueForKey(questionCategory) as! String
        let image: PFFile? = questionToPresent?.valueForKey(questionImage) as! PFFile?
        let answersNeeded = questionToPresent?.valueForKey(numberOfAnswers) as! Int
        var answerArray = questionToPresent?.valueForKey(questionAnswers) as! NSMutableArray
        
        if answersNeeded > 1 {
            
            for index in 0...answersNeeded {
                
                let answerGroupToAdd = questionToPresent?.valueForKey("qAnswers\(index + 1)") as! [String]
                answerArray.insertObject(answerGroupToAdd, atIndex: answerArray.count)
                
            }
            
        }
        
        
        questionObjectFromGameBoardSend = questionToPresent
        
        displayQuestionContainer(self, questionToPresent!, type) { (presentingContainerView: UIView) -> Void in
            
//            self.swipeToMaps.numberOfTouchesRequired = 100
//            self.swipeToProfile.numberOfTouchesRequired = 100
            
            switch(type) {
                
            case 1:
                
                println("single answer")
                
            case 2:
                
                println("multiple choice")
                
                multipleChoiceQuestion(self, presentingContainerView, questionToPresent!, { () -> Void in
                    
                    animateContainerView(self, presentingContainerView)
                })
                
            case 3:
                
                multipleChoiceQuestionWithImage(self, presentingContainerView, questionToPresent!, { () -> Void in
                    
                    animateContainerView(self, presentingContainerView)
                    
                })
                
                println("multiple answer")
                
            case 4:
                
                println("ordering")
                
                orderingQuestion(presentingContainerView, self.orderingQuestionLabel1, self.orderingQuestionLabel2, self.orderingQuestionLabel3, self.orderingQuestionLabel4, { () -> Void in
                    
                    animateContainerView(self, presentingContainerView)
                    
                })
                
            case 5:
                
                println("number range")
                
                
            default:
                
                println("error loading question display function")
                
                
            }
            
        }
        
        self.hideStatusBar = true
        
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    
    
    var labelThatIsBeingDraggedOrigin = CGPoint()
    var labelThatIsBeingDragged = UILabel()

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
        
        touchesBeganForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
        
    }
    
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    
        
        touchesMovedForOrderingQuestion(self.view, &labelThatIsBeingDragged, touches)
        
        
    }
    
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
    
        touchesEndedForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
        
    
    }
    
    
    
    func checkAnswerHandler() {
        
        checkAnswerSubmitted()
        
        
    }
    
    
    
    
    
}
