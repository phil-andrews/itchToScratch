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
var questionObjectFromGameBoardSend: PFObject?
var currentLocationObject: PFObject?

var reloadGameBoard = true

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
      
        if reloadGameBoard == true {
        
        self.checkForUser()
        
            reloadGameBoard = false
            
        }
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
            
            let loginViewController: LoginViewController = storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
            
            
        } else if PFUser.currentUser() != nil {
            
            print("user doesn't equal nil")
            
            PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user, error) -> Void in
                
                if error == nil && user != nil {
                    
                    self.startLocation()

                    
                } else if error != nil && user != nil {
                    
                    self.startLocation()

                    
                }
                
            })
            
            print("user logged in already")
        }
        
    }
    
    
    //////Location
    ///////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    
    
    let locationManager = CLLocationManager()
    var currentLocation: String?
    var questionObjectsForLocation: [PFObject]?
    var locationTimer = NSTimer()
    
    
    func startLocation() {
        
        print("location ran")
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.locationManager.requestWhenInUseAuthorization()
            print("auth not determined")
            
        } else if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            print("auth determined")
            
        }
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newestLocation = locations.last as CLLocation!
        usersCurrentLocationData = newestLocation
        locationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(newestLocation, completionHandler: {(placemarks, error: NSError?) -> Void in
         
            if error != nil {
                
                NSLog(error!.localizedDescription)
                print("error in getting placemarks")
                
                
            } else if error == nil {
                
                let locationPlacemarks = placemarks!.last as CLPlacemark!
                var locationString = String()
                
                if locationPlacemarks.subLocality != nil {
                    
                    locationString = ("\(locationPlacemarks.subLocality), \(locationPlacemarks.administrativeArea)")
                    print("the location has a sublocality: \(locationString)")
                    
                } else if locationPlacemarks.subLocality == nil {
                    
                    locationString = ("\(locationPlacemarks.locality), \(locationPlacemarks.administrativeArea)")
                    print("the location does not have a sublocality: \(locationString)")

                    
                }
                
                if locationString != self.currentLocation {
                    
                    if self.currentLocation != nil {
                        
                        ////////////////Show activity indicator: "You've moved to a new area"

                    } else {
                        
                        ////////////////Show activity indicator: "Tidying up the place"
                        
                    }
                    
                    self.currentLocation = locationString
                    
                    queryForSingleObjectInBackgroundWithBlock(LocationClass, typeOfKey: locality, equalToValue: locationString, completion: { (locationObject: PFObject?, parseError: NSError?) -> Void in
                        
                        if parseError?.code == 101 {
                            
                            queryForSingleObjectInBackgroundWithBlock(LocationClass, typeOfKey: objectId, equalToValue: defaultLocationObject, completion: { (defaultLocationObject: PFObject?, parseError: NSError?) -> Void in
                                
                                saveNewLocationObject(defaultLocationObject!, currentLocalityString: locationString, completion: { (success, newObject) -> Void in
                                    
                                    if success {
                                        
                                        currentLocationObject = newObject
                                        
                                        addAndSubtractUserFromLocationCount(currentLocationObject!)
                                        
                                        drawCityLabel(self.view, locationObject: currentLocationObject!)
                                        
                                        let questionIDs = separateObjectIDs(currentLocationObject!)
                                        
                                        queryForMultipleObjectsInBackgroundWithBlock(QuestionClass, keyType: objectId, objectIdentifers: questionIDs) { (questionObjects, error) -> Void in
                                            
                                            if error != nil {
                                                
                                                NSLog(error!.localizedDescription)
                                                print("error in query for question objects")
                                                
                                            } else if error == nil {
                                                
                                                self.questionObjectsForLocation = questionObjects
                                                
                                                drawButtons(self.view, vc: self, action: "presentQuestion", completion: { () -> Void in
                                                    
                                                    populateGameBoard(self.view, parseObjects: questionObjects, sortedObjectIDs: questionIDs, locationObject: currentLocationObject!)
                                                    
                                                })
                                                
                                            }
                                            
                                        }
                                        
                                    } else if success == false {
                                        
                                        print("did not pass through new location object")
                                    }
                                    
                                })
                                
                                //populate board -> stop spinner

                                print("currentLocationObject is defaultLocationObject")
                                
                            })
                            
                        } else if locationObject != nil && error == nil {
                            
                            currentLocationObject = locationObject
                            
                            addAndSubtractUserFromLocationCount(currentLocationObject!)
                            
                            drawCityLabel(self.view, locationObject: currentLocationObject!)
                            
                            let questionIDs = separateObjectIDs(currentLocationObject!)
                            
                            queryForMultipleObjectsInBackgroundWithBlock(QuestionClass, keyType: objectId, objectIdentifers: questionIDs) { (questionObjects, error) -> Void in
                                
                                if error != nil {
                                    
                                    NSLog(error!.localizedDescription)
                                    print("error in query for question objects")
                                    
                                } else if error == nil {
                                    
                                    self.questionObjectsForLocation = questionObjects
                                    
                                    drawButtons(self.view, vc: self, action: "presentQuestion:", completion: { () -> Void in
                                        
                                        populateGameBoard(self.view, parseObjects: questionObjects, sortedObjectIDs: questionIDs, locationObject: currentLocationObject!)
                                        
                                    })
                                    
                                }
                                
                            }
                            
                            print("currentLocationObject is not the defaultLocationObject")

                        }
                        
                        
                        
                    })
                    
                } else if locationString == self.currentLocation {
                    
                    print("location is the same")
                    
                }

            }
            
        })
    
    }

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        NSLog(error.localizedDescription)
        print("Error" + error.localizedDescription)
        
    }
    
    
    
    
    func presentQuestion(sender: AnyObject?) {
        
        let tagNumber = sender!.tag
        let questionID = currentLocationObject?.valueForKey("Q\(tagNumber - 1)") as! String
        let questionObjects = self.questionObjectsForLocation as [PFObject]!
        var questionToPresent: PFObject?
        
        for item in questionObjects {
            
            let id: String = item.objectId!
            
            if id == questionID {
                
                questionToPresent = item
                
            }
            
        }
                
        let type = questionToPresent?.valueForKey(questionType) as! Int
        let image: PFFile? = questionToPresent?.valueForKey(questionImageKey) as! PFFile?
        
        questionObjectFromGameBoardSend = questionToPresent
        
        
        switch(type) {
            
        case 1:
            
            print("single answer")
            
            let singleAnswerNoImageViewController: SingleAnswerViewController = storyboard?.instantiateViewControllerWithIdentifier("singleAnswerVC") as! SingleAnswerViewController
            
            self.presentViewController(singleAnswerNoImageViewController, animated: true, completion: nil)
            
            
        case 2:
            
            print("multiple choice")
            
            let multipleChoiceVC: MultipleChoiceViewController = storyboard?.instantiateViewControllerWithIdentifier("multipleChoiceViewController") as! MultipleChoiceViewController
            
            self.presentViewController(multipleChoiceVC, animated: true, completion: nil)
          
        case 3:
            
            queryForImage(image!, completion: { (imageFile: UIImage?) -> Void in
                
                print("multiple choice")
                
                let multipleChoiceVC: MultipleChoiceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleChoiceViewController") as! MultipleChoiceViewController
                
                multipleChoiceVC.questionImageFile = imageFile
                
                self.navigationController?.pushViewController(multipleChoiceVC, animated: true)
                
            })
            
        case 4:
            
            
            let orderingVC: OrderingQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("orderingQuestionViewController") as! OrderingQuestionViewController
            
            self.presentViewController(orderingVC, animated: true, completion: nil)
            
            
        case 5:
            
            let rangeVC: RangeQuestionViewController = storyboard?.instantiateViewControllerWithIdentifier("rangeViewController") as! RangeQuestionViewController
            
            
            self.presentViewController(rangeVC, animated: true, completion: nil)
            
            
        case 6:
            
            queryForImage(image!, completion: { (imageFile) -> Void in
                
                print("multiple choice")
                
                let singleAnswerWithImage: SingleAnswerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("singleAnswerVC") as! SingleAnswerViewController
                
                singleAnswerWithImage.questionImageFile = imageFile
                
                self.presentViewController(singleAnswerWithImage, animated: true, completion: nil)
                
            })
            
        case 7:
            
            let multipleAnswerNoImage: MultipleAnswerNoImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleAnswerNoImageVC") as! MultipleAnswerNoImageViewController
            
            self.presentViewController(multipleAnswerNoImage, animated: true, completion: nil)
            
        case 8:
            
            queryForImage(image!, completion: { (imageFile) -> Void in
                
                let multipleAnswerWithImage: MultipleAnswerWithImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleAnswerWithImageVC") as! MultipleAnswerWithImageViewController
                
                multipleAnswerWithImage.questionImageFile = imageFile
                
                self.presentViewController(multipleAnswerWithImage, animated: true, completion: nil)
                
            })
            
        case 9:
            
            queryForImage(image!, completion: { (imageFile) -> Void in
                
                let multipleAnswerWithOrder: MultipleAnswerWithOrderViewController = self.storyboard?.instantiateViewControllerWithIdentifier("multipleAnswerWithOrderVC") as! MultipleAnswerWithOrderViewController
                
                multipleAnswerWithOrder.questionImageFile = imageFile
                
                self.presentViewController(multipleAnswerWithOrder, animated: true, completion: nil)
                
            })
            
            
        default:
            
            break
            
        }
        
        
    }
    
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        print("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestion(sender, viewController: self)
        
    }
    
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        print("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestion(self, sender: sender, codeTag: nil)
        
        
    }

    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        switch(textField.tag) {
            
        case 8001:
            
            animateDropDownAnswerLabelToOriginalPosition(self, dropDownLabelTag: 802, delayAmount: 0.0, completion: { () -> Void in
                
                
            })
            
            
        default:
            
            break
            
        }
        
        
    }
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text!.isEmpty {
            
            return false
            
        }
        
        let tag = textField.tag
        
        switch(tag) {
            
        case 1001:
            
            print("single answer question")
            
            checkSingleAnswer(self, answerInputField: textField, completion: { (correct: Bool) -> Void in
    
                if correct {
                    
                    let containerView = self.view.viewWithTag(999)
                    
                    dismissContainerView(containerView!, completion: { () -> Void in
                        
                        
                    })
                    
                }
                
            })
            
        case 7001:
            
//            println("multiple answer no image")
            
            checkMultpleAnswerNoImageQuestion(self, answerInputField: textField, answerLabelStartTag: 702, submittedCount: &submittedCount, unhiddenAnswerLabelTags: &unhiddenAnswerLabelTags, completion: { () -> Void in
                
                
            })
            
            
        case 8001:
            
            //meryl streprintln("multiple answer with image")
            
            checkMultpleAnswerWithImageQuestion(self, answerInputField: textField, dropDownLabelTag: 802, indicatorLightStartingTag: 8111, submittedCount: &submittedCount, unhiddenAnswerLabelTags: &unhiddenAnswerLabelTags, completion: { () -> Void in
                
                
                
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        if answerSubmitted == true {
            
            return
            
        }
        
        switch(self.typeForHandler) {
            
  //      case 4:
            
//            let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
//            
//            touchesBeganForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
            
        case 5:
                        
            touchesBeganForRangeQuestion(self.view, touches: touches, buttonOverlay: rangeButtonViewOverlay, horizontalRangeBar: rangeHorizontalBar, previousRangeBarLocation: &previousRangeBarLocation)
                        
        default:
            
            break
            
        }
        
        
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if answerSubmitted == true {
            
            return
            
        }
        
        switch(self.typeForHandler) {
            
    //    case 4:
            
//            touchesMovedForOrderingQuestion(self.view, &labelThatIsBeingDragged, touches)
            
 //       case 5:
            
//            touchesMovedForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, rangeLabel, verticalScaleLine, &previousRangeBarLocation)

            
            
        default:
            
            break
            
        }
    
        
        
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
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
            
            print("ordering question")
        
            checkOrderingQuestion(self, completion: { () -> Void in
                
                
                
            })
            
            
        case 7001:
            
            print("multiple answer no image question")
        
        
        
        default:
        
        break
        
            
        }
    }
    
    
}
