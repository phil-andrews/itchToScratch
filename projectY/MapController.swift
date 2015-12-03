//
//  LocationStanding.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/19/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Mapbox


class BlackController: UIViewController, UITextViewDelegate, MGLMapViewDelegate {
    
    var mapView: MGLMapView!
    var timer = NSTimer()
    
    var count = 0
    
    let cityNameLabel = UILabel()
    let cityRankLabel = UILabel()
    
    var totalCities = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createMap { () -> Void in

            
        }
        
        cityNameLabel.hidden = true
        cityRankLabel.hidden = true
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.populateMap()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        self.mapView.removeFromSuperview()
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    var annoCount = 0
    
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        var markerToReturn = mapView.dequeueReusableAnnotationImageWithIdentifier("\(self.annoCount)")
        let markerImage =  self.setAnnotationImage()
        markerToReturn = MGLAnnotationImage(image: markerImage, reuseIdentifier: "\(self.annoCount)")
        
        ++annoCount
        
        return markerToReturn
        
    }
    
    
    
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        
        self.cityNameLabelandRankCallout(annotation)
        self.queryForTopPlayersInLocationObject(annotation, completion: { (topUsers, locationID) -> Void in
            self.queryForTopPlayersProfilePictures(topUsers, locationID: locationID, completion: { (sortedPlayerPics, topUsers) -> Void in
                
                
                self.queryForProfilePicturesData(sortedPlayerPics!, topUsers: topUsers, completion: { (pictureArray) -> Void in
                    
                    print("queryForTopPlayersProfilePictures done")
                    print(pictureArray)
                    
                })
                
                
                
                
            })
            
        })
        
        
    }
    
    
    func mapView(mapView: MGLMapView, regionWillChangeAnimated animated: Bool) {
        
        if cityNameLabel.hidden == false {
            
            cityNameLabel.hidden = true
            cityRankLabel.hidden = true
            
        }
        
        print("region did change")
        
    }
    
    func goBack(sender: UIButton) {
        
        performSegueWithIdentifier("swipeRightToMain", sender: sender)
        
    }

    
    func createMap(completion: () -> Void) {
        
        let styleURL = NSURL(string: "asset://styles/dark-v8.json")
        mapView = MGLMapView(frame: self.view.bounds, styleURL: styleURL)
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        mapView.setCenterCoordinate(usersCurrentLocationData.coordinate, zoomLevel: 0.1, animated: true)
        
        mapView.zoomEnabled = true
        mapView.attributionButton.hidden = true
        mapView.logoView.hidden = true
        mapView.delegate = self
        
        let backButton = UIButton(frame: CGRectMake(15.0, 15.0, 44.0, 44.0))
        backButton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        view.addSubview(mapView)
        view.addSubview(backButton)
        
        completion()
        
        
    }
    
    
    func populateMap() {
        
        
        self.queryForAllLocation { (locationAnswerCount, locationArrayNames, locationArrayGeoPoints, sortedLocations) -> Void in
            
            for index in 0..<locationAnswerCount.count {
                
                let point = MGLPointAnnotation()
                let centerGeoPoints = locationArrayGeoPoints[index]
                point.coordinate = centerGeoPoints
                
                let pointTitle: String = locationArrayNames[index] as! String
                
                point.title = pointTitle.lowercaseString
                
                for index in 0..<sortedLocations.count {
                    
                    if sortedLocations[index] == pointTitle {
                        
                        self.count = index
                        
                    }
                    
                }
                
                let pointSubTitle = String(self.count)
                point.subtitle = pointSubTitle
                
                self.mapView.addAnnotation(point)
                
                
            }
            
        }
        
        
        
        
    }
    
    
    
    func queryForAllLocation(completion: (locationAnswerCount: NSMutableArray, locationArrayNames: NSMutableArray, locationArrayGeoPoints: [CLLocationCoordinate2D], sortedLocations: [String]) -> Void) {
        
        let locationArrayCount = NSMutableArray()
        let locationArrayNames = NSMutableArray()
        var locationArrayGeoPoints = [CLLocationCoordinate2D]()
        var locationDict = [String: Int]()
        
        let query = PFQuery(className: LocationClass)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    for location in objects {
                        
                        let questionsDone: NSArray = location.valueForKey(usedQuestionObjects) as! NSArray
                        let questionsTotal: Int = questionsDone.count
                        let locationName: String = location.valueForKey(locality) as! String
                        let parseGeoPoints = location.valueForKey(geoPoint) as! PFGeoPoint
                        let clGeoPoint = CLLocationCoordinate2DMake(parseGeoPoints.latitude, parseGeoPoints.longitude)
                        
                        
                        locationArrayCount.addObject(questionsTotal)
                        locationArrayNames.addObject(locationName)
                        locationArrayGeoPoints.append(clGeoPoint)
                        
                        
                    }
                    
                    for index in 0..<locationArrayCount.count {
                        
                        let locality = locationArrayNames[index] as! String
                        let localityCount = locationArrayCount[index] as! Int
                        
                        locationDict[locality] = localityCount
                        
                    }
                    
                    
                    let sortedLocations = locationDict.sortedKeysByValue(>)
                    
                    self.totalCities = locationArrayCount.count
                    
                    completion(locationAnswerCount: locationArrayCount, locationArrayNames: locationArrayNames, locationArrayGeoPoints: locationArrayGeoPoints, sortedLocations: sortedLocations)
                    
                
                }
                
            }
            
        }
    
    }
    
    
    func setAnnotationImage() -> UIImage {
        
        var markerImage = UIImage()
        
        let arrayIndex = Double(self.count)
        let totalCitiesDouble = Double(self.totalCities)
        
        let percentile = (100 * (arrayIndex - 0.5)) / totalCitiesDouble
        

        switch(percentile) {
            
        case _ where percentile <= 5:
            
            markerImage = markerNine!
            
        case _ where percentile <= 15:
            
            markerImage = markerSeven!
            
        case _ where percentile <= 25:
            
            markerImage = markerSix!
            
        case _ where percentile <= 35:
            
            markerImage = markerFive!
            
        case _ where percentile <= 45:
            
            markerImage = markerFour!
            
        case _ where percentile <= 55:
            
            markerImage = markerThree!
            
        case _ where percentile <= 65:
            
            markerImage = markerTwo!
            
        case _ where percentile <= 75:
            
            markerImage = markerOne!
            
        case _ where percentile <= 85:
            
            markerImage = markerZero!
            
        case _ where percentile <= 95:
            
            markerImage = markerSeven!
            
        default:
            
            print("default annotation set")
            
            markerImage = markerZero!
            
        }
        
        
        switch(self.count) {
            
            
        case 0:
            
            markerImage = markerCurrentLeader!
            
        case 1:
            
            markerImage = markerCurrentRunnerUp!
            
            
        case 2:
            
            markerImage = markerCurrentThirdPlace!
            
        default:
            
            break
            
        }
        
        
        return markerImage
        
    }
    
    ////// Annotation Callout Functions //////////////////////////////////////////////////////

    
    func cityNameLabelandRankCallout(annotation: MGLAnnotation) {
        
        let city: String?? = annotation.title
        let rank: String?? = annotation.subtitle
        
        print(rank)
        
        var cityName = String()
        var cityRank = String()
        
        if let a = city, b = a {
            
            cityName = b
            
        }
        
        if let c = rank, d = c {
            
            cityRank = d
            print(cityRank)
            
        }
        
        self.view.addSubview(cityNameLabel)
        self.view.addSubview(cityRankLabel)
        
        drawPercentageRectOffView(cityNameLabel, masterView: self.view, heightPercentage: 8, widthPercentage: 100)
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let viewHeightPercentage = viewHeight/100
        
        cityNameLabel.frame.offsetInPlace(dx: 0.0, dy: viewHeightPercentage * 92)
        
        cityNameLabel.text = ("    \(self.separatedPlaceName(cityName))")
        cityNameLabel.font = robotoLight22
        cityNameLabel.textAlignment = .Left
        cityNameLabel.numberOfLines = 0
        cityNameLabel.textColor = lightColoredFont
        cityNameLabel.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
        let rankToInt: Int = Int(cityRank)! + 1
        
        cityRankLabel.text = addOrdinalIndicator(rankToInt)
        cityRankLabel.font = robotoMedium24
        cityRankLabel.textColor = rankTextColor(rankToInt)
        cityRankLabel.textAlignment = .Right
        cityRankLabel.frame = CGRectMake(viewWidth/2, cityNameLabel.frame.minY, (viewWidth/2 - 15), cityNameLabel.frame.height)
        
        print("control tapped")
        
        cityRankLabel.hidden = false
        cityNameLabel.hidden = false
        
    }
    
    
    func drawProfilePictures(profileImages: [UIImage]) {
        
        
        
        
    }
    
    
    
    
    func queryForProfilePicturesData(sortedPlayersPictureFiles: [PFFile], topUsers: [String]?, completion: (pictureArray: [UIImage]?) -> Void) {
        
        if topUsers == nil {
            
            completion(pictureArray: nil)
            
            return
            
        }
        
        print(sortedPlayersPictureFiles)
        
        if sortedPlayersPictureFiles.count == 0 {
            
            completion(pictureArray: nil)
            
            return
            
        }
        
        var pictureArray = [UIImage]()
        
        var count = 1
        
        for index in 0..<sortedPlayersPictureFiles.count {
            
            let imageFile = sortedPlayersPictureFiles[index] as PFFile
            
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                    
                } else if error == nil {
                    
                    let image = UIImage(data: data!)
                    pictureArray.append(image!)
                    
                }
                
                if count == sortedPlayersPictureFiles.count {
                    
                    print(pictureArray)
                    
                    completion(pictureArray: pictureArray)
                }
                
                ++count
                
            })
            
            
        }
        
    }
    
    
    
    
    
    func queryForTopPlayersProfilePictures(topUsers: [String]?, locationID: String?, completion: (sortedPlayerPics: [PFFile]?, topUsers: [String]?) -> Void) {
        
        var topPlayersDict = [PFFile: Int]()
        
        if topUsers == nil {
            
            completion(sortedPlayerPics: nil, topUsers: nil)
            
            print("top users does equal nil")
            
            return
            
        } else if topUsers != nil {
        
            print("top users doesn't equal nil")
            
            let query = PFUser.query()
            query?.whereKey(objectId, containedIn: topUsers!)
            query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                    
                } else if error == nil {
                    
                    if let objects = objects as? [PFObject] {
                        
                        for object in objects {
                            
                                let userPlacesAnswered = object.valueForKey(whereUserAnswered) as! [NSArray]
                            
                            for item in userPlacesAnswered {
                                
                                if item[0] as! String == locationID! {
                                    
                                    let numberOfAnsweredQuestions = item.count as Int
                                    
                                    let userProfilePicture = object.valueForKey(profilePic) as! PFFile
                                    
                                    topPlayersDict[userProfilePicture] = numberOfAnsweredQuestions
                                    
                                    let dict = topPlayersDict.sortedKeysByValue(>)
                                    print(dict)
                                    
                                    completion(sortedPlayerPics: dict, topUsers: topUsers)
                                    
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                
            })
        
        }
    }
    
    
    
    
    func queryForTopPlayersInLocationObject(annotation: MGLAnnotation, completion: (topUsers: [String]?, locationID: String?) -> Void) {
        
        let pfGeoCoords = PFGeoPoint(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
            let query = PFQuery(className: LocationClass)
            query.whereKey(geoPoint, equalTo: pfGeoCoords)
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                    
                } else if error == nil {
                    
                    let locationObject = objects?.first as! PFObject
                    let topPlayers = locationObject.valueForKey(topPlayersForArea) as! [String]
                    let locationID = locationObject.objectId as String?
                    
                    print(topPlayers.count)
                    
                    if topPlayers.count == 0 {
                        
                        completion(topUsers: nil, locationID: nil)
                        
                        return
                        
                    } else if topPlayers.count != 0 {
                        
                        if topPlayers.count <= 5 {
                            
                            completion(topUsers: topPlayers, locationID: locationID)
                            
                            return
                            
                        } else if topPlayers.count > 5 {
                            
                            var playerArrayToReturn = [String]()
                            
                            for index in 0...4 {
                                
                                playerArrayToReturn.append(topPlayers[index])
                                
                            }
                            
                            completion(topUsers: playerArrayToReturn, locationID: locationID)

                            
                            
                        }
                        
                        
                    }
                    
                }
                
                
            })
        
    }
    
    
    
    
    
    
    
    /////// Text Aesthetic /////////////////////////////////////////////////////
    
    func separatedPlaceName(string: String) -> String {
        
        var returnString = String()
        
        if listMatches("\\w+\\s\\w+\\b\\s\\w+", inString: string).count != 0 {
            
            let matched = listMatches("\\w+\\s\\w+\\b\\s\\w+", inString: string)
            returnString = matched[0]
            return returnString
            
        }
        
        if listMatches("\\w+\\s\\w+", inString: string).count != 0 {
            
            let matched = listMatches("\\w+\\s\\w+", inString: string)
            returnString = matched[0]
            return returnString
            
        }
        
        if listMatches("\\w+", inString: string).count != 0 {
            
            let matched = listMatches("\\w+", inString: string)
            returnString = matched[0]
            return returnString
            
        }
        
        returnString = string
        
        return returnString
        
    }
    
    
    
    func rankTextColor(rank: Int) -> UIColor {
        
        var colorToReturn = UIColor()
        
        let ranking = Double(rank)
        let totalCitiesDouble = Double(self.totalCities)
    
        let percentile = (100 * (ranking - 0.5)) / totalCitiesDouble
        
        print(percentile)
        
        
        switch(percentile) {
            
        case _ where percentile <= 5:
            
            colorToReturn = highestColor
            
        case _ where percentile <= 15:
            
            colorToReturn = highColor
            
        case _ where percentile <= 25:
            
            colorToReturn = midColor
            
        case _ where percentile <= 35:
            
            colorToReturn = lowColor
            
        case _ where percentile <= 45:
            
            colorToReturn = lowestColor
            
        case _ where percentile <= 55:
            
            colorToReturn = lowestColor
            
        case _ where percentile <= 65:
            
            colorToReturn = lowestColor
            
        case _ where percentile <= 75:
            
            colorToReturn = lowestColor
            
        case _ where percentile <= 85:
            
            colorToReturn = lowestColor
            
        case _ where percentile <= 95:
            
            colorToReturn = lowestColor
            
        default:
            
            print("default color set")
            
            colorToReturn = lowestColor
            
        }
        
            
        switch(rank) {
            
            
        case 1:
            
            colorToReturn = yellowColor
            
        case 2:
            
            colorToReturn = highestColor
            
        case 3:
            
            colorToReturn = highestColor
            
        default:
            
            break
            
        }
    
        return colorToReturn


    }

}