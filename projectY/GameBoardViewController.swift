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

class GameBoardViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    @IBOutlet var swipeToMaps: UISwipeGestureRecognizer!
    
    @IBOutlet var swipeToProfile: UISwipeGestureRecognizer!
    
    //Range
    
    var rangeButtonViewOverlay = UIView()
    var rangeHorizontalBar = UIView()
    var rangeLabel = UILabel()
    
    
    
    /////////////////////////    /////////////////////////    /////////////////////////    /////////////////////////



    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColor
        
        setFonts(self.view)
        
        self.checkForUser()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
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
        let questionString = questionToPresent?.valueForKey(questionAskKey) as! String
        let category = questionToPresent?.valueForKey(questionCategoryKey) as! String
        let image: PFFile? = questionToPresent?.valueForKey(questionImageKey) as! PFFile?
        let answersNeeded = questionToPresent?.valueForKey(numberOfAnswersKey) as! Int
        var answerArray = questionToPresent?.valueForKey(questionAnswersKey) as! NSMutableArray

        
        questionObjectFromGameBoardSend = questionToPresent
        
        
        switch(type) {
            
        case 1:
            
            println("single answer")
            
            var singleAnswerNoImageViewController: SingleAnswerViewController = storyboard?.instantiateViewControllerWithIdentifier("singleAnswerVC") as! SingleAnswerViewController
            
            self.presentViewController(singleAnswerNoImageViewController, animated: true, completion: nil)
            
            
        case 2:
            
            println("multiple choice")
            
            var multipleChoiceVC: MultipleChoiceViewController = storyboard?.instantiateViewControllerWithIdentifier("multipleChoiceViewController") as! MultipleChoiceViewController
            
            self.presentViewController(multipleChoiceVC, animated: true, completion: nil)
          
        case 3:
            
            queryForImage(image!, { (imageFile) -> Void in
                
                println("multiple choice")
                
                var multipleChoiceVC: MultipleChoiceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleChoiceViewController") as! MultipleChoiceViewController
                
                multipleChoiceVC.questionImageFile = imageFile
                
                self.presentViewController(multipleChoiceVC, animated: true, completion: nil)
                
            })
            
        case 4:
            
            
            var orderingVC: OrderingQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("orderingQuestionViewController") as! OrderingQuestionViewController
            
            self.presentViewController(orderingVC, animated: true, completion: nil)
            
            
        case 5:
            
            var rangeVC: RangeQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("rangeViewController") as! RangeQuestionViewController
            
            self.presentViewController(rangeVC, animated: true, completion: nil)
            
            
        case 6:
            
            queryForImage(image!, { (imageFile) -> Void in
                
                println("multiple choice")
                
                var singleAnswerWithImage: SingleAnswerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("singleAnswerVC") as! SingleAnswerViewController
                
                singleAnswerWithImage.questionImageFile = imageFile
                
                self.presentViewController(singleAnswerWithImage, animated: true, completion: nil)
                
            })
            
        case 7:
            
            var multipleAnswerNoImage: MultipleAnswerNoImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleAnswerNoImageVC") as! MultipleAnswerNoImageViewController
            
            self.presentViewController(multipleAnswerNoImage, animated: true, completion: nil)
            
        case 8:
            
            queryForImage(image!, { (imageFile) -> Void in
                
                var multipleAnswerWithImage: MultipleAnswerWithImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleAnswerWithImageVC") as! MultipleAnswerWithImageViewController
                
                multipleAnswerWithImage.questionImageFile = imageFile
                
                self.presentViewController(multipleAnswerWithImage, animated: true, completion: nil)
                
            })
            
        case 9:
            
            queryForImage(image!, { (imageFile) -> Void in
                
                var multipleAnswerWithOrder: MultipleAnswerWithOrderViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleAnswerWithOrderVC") as! MultipleAnswerWithOrderViewController
                
                multipleAnswerWithOrder.questionImageFile = imageFile
                
                self.presentViewController(multipleAnswerWithOrder, animated: true, completion: nil)
                
            })
            
            
        default:
            
            break
            
        }
        
        
//        displayQuestionContainer(self, questionToPresent!, type) { (presentingContainerView: UIView) -> Void in
//            
////            self.swipeToMaps.numberOfTouchesRequired = 100
////            self.swipeToProfile.numberOfTouchesRequired = 100
//            
//            switch(type) {
//                
//            case 1:
//                
//                println("single answer")
//                
//                var singleAnswerStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                
//                var singleAnswerNoImageViewController: SingleAnswerNoImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("singleAnswerNoImage") as! SingleAnswerNoImageViewController
//                
//                self.presentViewController(singleAnswerNoImageViewController, animated: true, completion: nil)
//                
//                
//            case 2:
//                
//                println("multiple choice")
//                
//                multipleChoiceQuestion(self, presentingContainerView, questionToPresent!, { () -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                    })
//                    
//                })
//                
//            case 3:
//                
//                multipleChoiceQuestionWithImage(self, presentingContainerView, questionToPresent!, { () -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                    })
//                })
//                
//                println("multiple answer")
//                
//            case 4:
//                
//                println("ordering")
//                
//                self.typeForHandler = 4
//                
//                orderingQuestion(self, presentingContainerView, self.orderingQuestionLabel1, self.orderingQuestionLabel2, self.orderingQuestionLabel3, self.orderingQuestionLabel4, { () -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                    })
//                })
//                
//            case 5:
//                
//                println("number range")
//                
//                self.typeForHandler = 5
//                
//                rangeQuestion(presentingContainerView, self.rangeButtonViewOverlay, self.rangeHorizontalBar, self.rangeLabel, { (verticalLine) -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                    })
//                    
//                    self.verticalScaleLine = verticalLine
//                    
//                    
//                })
//                
//            case 6:
//                
//                singleAnswerQuestionWithImage(self, presentingContainerView, self, { (answerInputField: UITextField) -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                        
//                        if self.view.frame.height > 480 {
//                            
//                            answerInputField.becomeFirstResponder()
//                            
//                        }
//                        
//                        
//                    })
//                    
//                })
//                
//            case 7:
//                
//                println("multiple answer question no image")
//
//                
//                multipleAnswerQuestionNoImage(presentingContainerView, self, { (answerInputField: UITextField) -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                        
//                        answerInputField.becomeFirstResponder()
//                        
//                    })
//                    
//                })
//                
//            case 8:
//                
//                multipleAnswerQuestionWithImage(self, self, presentingContainerView, textFieldTag: 8001, textFieldQuestionButtonTag: 8002, questionLabelTag: 801, dropDownAnswerLabelTag: 802, imageViewTag: 803, startingLightTag: 8111, callKeybardButtonTag: 8003, { (answerInputField: UITextField) -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//
//                        
//                    })
//                
//                })
//                
//            case 9:
//                
//                multipleAnswerQuestionWithImage(self, self, presentingContainerView, textFieldTag: 9001, textFieldQuestionButtonTag: 9002, questionLabelTag: 901, dropDownAnswerLabelTag: 902, imageViewTag: 903, startingLightTag: 9111, callKeybardButtonTag: 9003, { (textField) -> Void in
//                    
//                    animateContainerView(self, presentingContainerView, { () -> Void in
//                        
//                        
//                    })
//                    
//                })
//                
//            default:
//                
//                println("error loading question display function")
//                
//                
//            }
        
//        }
        
//        self.hideStatusBar = true
//        
//        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        println("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestion(sender, self)
        
    }
    
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        println("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestion(self, sender, nil)
        
        
    }

    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        switch(textField.tag) {
            
        case 8001:
            
            animateDropDownAnswerLabelToOriginalPosition(self, 802, 0.0, { () -> Void in
                
                
            })
            
            
        default:
            
            break
            
        }
        
        
    }
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text.isEmpty {
            
            return false
            
        }
        
        let tag = textField.tag
        
        switch(tag) {
            
        case 1001:
            
            println("single answer question")
            
            checkSingleAnswer(self, textField, { (correct: Bool) -> Void in
    
                if correct {
                    
                    let containerView = self.view.viewWithTag(999)
                    
                    dismissContainerView(containerView!, { () -> Void in
                        
                        
                    })
                    
                }
                
            })
            
        case 7001:
            
//            println("multiple answer no image")
            
            checkMultpleAnswerNoImageQuestion(self, textField, 702, &submittedCount, &unhiddenAnswerLabelTags, { () -> Void in
                
                
            })
            
            
        case 8001:
            
            //meryl streprintln("multiple answer with image")
            
            checkMultpleAnswerWithImageQuestion(self, textField, 802, 8111, &submittedCount, &unhiddenAnswerLabelTags, { () -> Void in
                
                
                
            })
            
            
            
        default:
            
            break
            
        }
        
        
        return true
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        textField.text = "  "
        
        return true
    }
    
    //Ordering
    
    var typeForHandler = Int()
    var labelThatIsBeingDraggedOrigin = CGPoint()
    var labelThatIsBeingDragged = UILabel()

    //Range
    
    var verticalScaleLine = UIView()
    var previousRangeBarLocation = CGPoint()
    
    var answerSubmitted = false
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
       
        if answerSubmitted == true {
            
            return
            
        }
        
        switch(self.typeForHandler) {
            
  //      case 4:
            
//            let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
//            
//            touchesBeganForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
            
        case 5:
                        
            touchesBeganForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, &previousRangeBarLocation)
                        
        default:
            
            break
            
        }
        
        
    }
    
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if answerSubmitted == true {
            
            return
            
        }
        
        switch(self.typeForHandler) {
            
    //    case 4:
            
//            touchesMovedForOrderingQuestion(self.view, &labelThatIsBeingDragged, touches)
            
        case 5:
            
            touchesMovedForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, rangeLabel, verticalScaleLine, &previousRangeBarLocation)

            
            
        default:
            
            break
            
        }
    
        
        
        
    }
    
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if answerSubmitted == true {
            
            return
            
        }
        
        switch(self.typeForHandler) {
            
  //      case 4:
            
//            let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
//            
//            touchesEndedForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
            
            
            
        default:
            
            break
            
        }
        
    }
    
    
    
    
    func checkNonTextInputQuestion(sender: AnyObject?) {
        
        self.answerSubmitted = true
        
        let tag = sender!.tag
        
        switch(tag) {
            
        case 4001:
            
            println("ordering question")
        
            checkOrderingQuestion(self, { () -> Void in
                
                
                
            })
            
            
        case 7001:
            
            println("multiple answer no image question")
        
        
        
        default:
        
        break
        
            
        }
    }
    
    
}
