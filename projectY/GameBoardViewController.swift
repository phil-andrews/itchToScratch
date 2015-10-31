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
                                                    
                                                    populateGameBoard(self.view, questionObjects, self.currentLocationObject!)
                                                    
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
                                    
                                    drawButtons(self.view, self, "presentQuestion", { () -> Void in
                                        
                                        populateGameBoard(self.view, questionObjects, self.currentLocationObject!)
                                        
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
    
    
    
    
    func presentQuestion() {
        
        
        
        
    }
    
    
    
    
    
}
