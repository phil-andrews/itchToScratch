//
//  Accounts.swift
//  projectY
//
//  Created by Philip Ondrejack on 8/28/15.
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
import Charts

class Accounts: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, ChartViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var viewLoaded = false

    @IBOutlet weak var constraintProfilePicTrailingToView: NSLayoutConstraint!
    @IBOutlet weak var contraintProfilePicToTopOfView: NSLayoutConstraint!
    @IBOutlet weak var constraintPieChartToProfilePic: NSLayoutConstraint!

    @IBOutlet weak var profilePictureRing1: UIView!
    @IBOutlet weak var profilePictureRing2: UIView!
    @IBOutlet weak var profilePicture: UIButton!
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    var userObject: PFObject?
    
    @IBOutlet weak var questionCategoryChart: PieChartView!
    @IBOutlet weak var categoryChartCategoryLabel: UILabel!
    @IBOutlet weak var categoryChartNumberLabel: UILabel!
    
    @IBOutlet weak var categoryChartCenterButton: UIButton!
    
    @IBOutlet weak var categoryChartBackgroundCenterColor: UIView!

    @IBOutlet weak var totalAnswerLabel: UILabel!
    
    @IBAction func logOutButton(sender: AnyObject) {
        
        PFUser.logOut()
        
        self.checkForUser()
        
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var childView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.directionalLockEnabled = true
        self.scrollView.pagingEnabled = true
        
        
        self.scrollView.addSubview(self.refreshControl)
        self.scrollView.backgroundColor = UIColor.clearColor()
        
        self.scrollView.delegate = self
        
        self.childView.backgroundColor = UIColor.clearColor()
        self.childView.frame = CGRectMake(0.0, 0.0, self.view.frame.width, (self.view.frame.height * 3))
        
        self.setConstraints()
        setFonts(self.view)
        
        self.view.backgroundColor = backgroundColor
        
        imagePicker.delegate = self
        
        questionCategoryChart.delegate = self
        questionCategoryChart.alpha = 0
        
        self.categoryChartCategoryLabel.hidden = true
        self.categoryChartNumberLabel.hidden = true
        
        self.profilePicture.hidden = true
        self.profilePictureRing1.hidden = true
        self.profilePictureRing2.hidden = true

    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
                
        self.checkForUser()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
            
        if self.viewLoaded == false {
            
            SwiftSpinner.showWithDelay(0.5, title: "Gathering your things", animated: true)
            
        }

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    
    /// Setup //////////////////////////////////////////////////////////

    
    func loadFunc() {
        
        
        self.queryForUser { () -> Void in
            
            self.setProfilePictureAndName()
            
            self.makeCategoryChart({ () -> Void in
                
                self.queryForPlacesPlayed({ (locationObjects, playedAreasDict) -> Void in
                    
                    PPChart().makeWhereChart(playedAreasDict, contentView: self.childView, parentView: self.view, locationObjects: locationObjects, completion: { () -> Void in
                                                
                        SwiftSpinner.hide(completion: nil)
                        
                        self.viewLoaded == true
                        
                        self.profilePicture.hidden = false
                        self.profilePictureRing1.hidden = false
                        self.profilePictureRing2.hidden = false
                        
                        
                    })
                    
                    
                })
                
            })
            
        }
        
    }
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self.scrollView, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        return refreshControl
        }()
    
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {

        self.queryForUser { () -> Void in
            
            self.makeCategoryChart({ () -> Void in
                
                self.queryForPlacesPlayed({ (locationObjects, playedAreasDict) -> Void in
                    
                    PPChart().makeWhereChart(playedAreasDict, contentView: self.childView, parentView: self.view, locationObjects: locationObjects, completion: { () -> Void in
                                                
                        
                    })
                    
                })
                
            })
            
        }
        
        refreshControl.endRefreshing()
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        animateWhereChartBar(bar1, answerCount1, 0.0)
        animateWhereChartBar(bar2, answerCount2, 0.1)
        animateWhereChartBar(bar3, answerCount3, 0.2)
        animateWhereChartBar(bar4, answerCount4, 0.3)
        animateWhereChartBar(bar5, answerCount5, 0.4)
        
    }
    
    
    
    
    // User Data
    //////////
    ////////////////
    
    
    
    func setProfilePictureAndName() {
        
        let user = userObject
        let userName = user?.valueForKey(displayName) as? String
        self.userNameLabel.text = userName?.lowercaseString
        self.userNameLabel.textColor = lightColoredFont
        self.userNameLabel.font = fontSmall
        self.userNameLabel.textAlignment = .Right
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
        self.profilePicture.clipsToBounds = true
        self.profilePicture.contentMode = .ScaleAspectFit
        self.profilePicture.setBackgroundImage(UIImage(named: "defaultProfilePic"), forState: .Normal)

        func getProfilePicture() {
        
            let imageFile = self.userObject?.valueForKey(profilePic) as? PFFile
        
            if imageFile != nil {
                
                imageFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    
                    if error == nil {
                        
                        self.profilePicture.setBackgroundImage(UIImage(data: data!), forState: .Normal)
                        self.profilePicture.contentMode = .ScaleAspectFit

                        
                    }
      
                })
            }
            
            
        }
        
        if self.userObject?.valueForKey(profilePic) != nil {
            
            getProfilePicture()
            
        }
        
        var colors1 = [highColor,lowestColor, lowColor, highestColor]
        
        var colors2 = [lightPurpleColor, midColor, orangeColor, whiteColor]
        
        let random1 = Int(arc4random_uniform(3))
        let randomColor1 = colors1.removeAtIndex(random1)
        
        let random2 = Int(arc4random_uniform(3))
        let randomColor2 = colors2.removeAtIndex(random2)
        
        self.profilePictureRing1.layer.cornerRadius = self.profilePictureRing1.frame.height/2
        self.profilePictureRing1.backgroundColor = randomColor1
        self.profilePictureRing2.layer.cornerRadius = self.profilePictureRing2.frame.height/2
        self.profilePictureRing2.backgroundColor = randomColor2
        
        
    }
    
    @IBAction func proPicButton(sender: AnyObject) {
        
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            
            presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profilePicture.setBackgroundImage(pickedImage, forState: .Normal)
            self.profilePicture.contentMode = .ScaleAspectFit
            
            let user = userObject
            let image = UIImagePNGRepresentation(pickedImage)
            let imageFile = PFFile(name: "profilePic.png", data: image)
            user?.setValue(imageFile, forKey: profilePic)
            user?.saveInBackground()
        }
        
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func queryForUser(completion: () -> Void) {
        
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user, error) -> Void in
            
            if error == nil {
                
                self.userObject = user
                
                completion()
                
            } else if error != nil {
                
                println(error!.localizedDescription)
                
            }
            
        })
        
    }
    
    
    // CategoryChart
    //////////
    ////////////////
    

    func makeCategoryChart(completion: () -> Void) {
        
        
        self.categoryChartBackgroundCenterColor.layer.cornerRadius = self.categoryChartBackgroundCenterColor.frame.height/2
        
        self.categoryChartBackgroundCenterColor.backgroundColor = UIColor.clearColor()
        
        
        let geography = userObject?.valueForKey(geographyCategory) as! NSArray
        let music = userObject?.valueForKey(musicCategory) as! NSArray
        let movies = userObject?.valueForKey(moviesCategory) as! NSArray
        let science = userObject?.valueForKey(scienceCategory) as! NSArray
        let television = userObject?.valueForKey(televisionCategory) as! NSArray
        let history = userObject?.valueForKey(historyCategory) as! NSArray
        let money = userObject?.valueForKey(moneyCategory) as! NSArray
        let products = userObject?.valueForKey(productsCategory) as! NSArray
        let people = userObject?.valueForKey(peopleCategory) as! NSArray
        let sports = userObject?.valueForKey(sportsCategory) as! NSArray
        
        let geoCount = Double(geography.count)
        let musicCount = Double(music.count)
        let moviesCount = Double(movies.count)
        let scienceCount = Double(science.count)
        let tvCount = Double(television.count)
        let historyCount = Double(history.count)
        let moneyCount = Double(money.count)
        let productsCount = Double(products.count)
        let peopleCount = Double(people.count)
        let sportsCount = Double(sports.count)
        
        let totalNumber = Int(geoCount + musicCount + moviesCount + scienceCount + tvCount + historyCount + moneyCount + productsCount + peopleCount + sportsCount)
        
        self.totalAnswerLabel.text = String(totalNumber)
        self.totalAnswerLabel.textColor = lightColoredFont
        self.totalAnswerLabel.font = fontExtraLarge
        self.totalAnswerLabel.textAlignment = .Center
        
        let countArray = [geoCount, musicCount, scienceCount, tvCount, historyCount, moneyCount, productsCount, peopleCount, sportsCount]
        
        let titleArray = ["GEOGRAPHY", "MUSIC", "SCIENCE", "TV", "HISTORY", "MONEY", "PRODUCTS", "PEOPLE", "SPORTS"]
        
        let sortedArray = Array(countArray).sorted(>)
        
        let chartColors = [highColor, lightPurpleColor,lowestColor, lowColor, midColor, orangeColor, whiteColor, highestColor, highestColor]
        
        self.questionCategoryChart.backgroundColor = backgroundColor
        self.questionCategoryChart.holeColor = backgroundColor
        self.questionCategoryChart.legend.enabled = false

        self.questionCategoryChart.valueFormatter.maximumFractionDigits = 0
        
        self.questionCategoryChart.descriptionFont = fontSmall
        self.questionCategoryChart.descriptionText = ""
        self.questionCategoryChart.infoFont = fontMedium
        self.questionCategoryChart.infoTextColor = lightColoredFont
                self.questionCategoryChart.noDataText = "We can't draw your chart until you answer _____ more quesitons"

        self.questionCategoryChart.holeRadiusPercent = 0.6

        
        
        var dataEntries: [ChartDataEntry] = []
        
        for index in 0..<countArray.count {
            
            let data = ChartDataEntry(value: countArray[index], xIndex: index)
            dataEntries.append(data)
            
        }
        
        let myPieChartDataSet = PieChartDataSet(yVals: dataEntries)
        
        myPieChartDataSet.valueTextColor = UIColor.clearColor()
        
        myPieChartDataSet.selectionShift = 7.0
        
        if totalNumber < 2 {
            
            myPieChartDataSet.sliceSpace = 0.0
            
        } else {
            
            myPieChartDataSet.sliceSpace = 2.0
            
        }
        
        
        myPieChartDataSet.colors = chartColors
        let chartData = PieChartData(xVals: [""], dataSet: myPieChartDataSet)
        
        questionCategoryChart.data = chartData
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.questionCategoryChart.alpha = 1.0
            
            completion()
            
            SwiftSpinner.hide(completion: nil)
            
        })
        
        
        
        
    }
    
    
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        self.totalAnswerLabel.hidden = true
        
        let chartColors = [highColor, lightPurpleColor,lowestColor, lowColor, midColor, orangeColor, whiteColor, highestColor, highestColor]
        
        self.categoryChartBackgroundCenterColor.layer.cornerRadius = self.categoryChartBackgroundCenterColor.frame.height/2
        
        //self.categoryChartBackgroundCenterColor.backgroundColor = chartColors[entry.xIndex]
        
        self.categoryChartBackgroundCenterColor.layer.borderWidth = (self.view.frame.width/100)
        self.categoryChartBackgroundCenterColor.layer.borderColor = chartColors[entry.xIndex].CGColor
        
        println("touch function ran")
        
        let numberToDisplay = Int(entry.value)
        categoryChartNumberLabel.text = String(numberToDisplay)
        categoryChartNumberLabel.textColor = lightColoredFont
        categoryChartNumberLabel.textAlignment = .Center
        categoryChartNumberLabel.font = fontLarge
        categoryChartNumberLabel.hidden = false
        
        let titleArray = ["GEOGRAPHY", "MUSIC", "SCIENCE", "TV", "HISTORY", "MONEY", "PRODUCTS", "PEOPLE", "SPORTS"]
        
        let categoryToDisplay = titleArray[entry.xIndex]
        categoryChartCategoryLabel.text = categoryToDisplay
        categoryChartCategoryLabel.textColor = lightColoredFont
        categoryChartCategoryLabel.font = fontLarge
        categoryChartCategoryLabel.textAlignment = .Center
        categoryChartCategoryLabel.hidden = false
        
        println(questionCategoryChart.highlighted.count)
        
        if questionCategoryChart.highlighted.count == 0 {
            
            let total = chartView.data?.yValueSum
            let totalInt = Int(total!)
            self.totalAnswerLabel.text = String(totalInt)
            println(totalInt)
            
        }
        
    }
    
    @IBAction func categoryChartCenterButton(sender: AnyObject) {
        
        self.categoryChartCenterButton.layer.cornerRadius = self.categoryChartCenterButton.frame.height/2
        
        self.categoryChartBackgroundCenterColor.backgroundColor = UIColor.clearColor()
        self.categoryChartBackgroundCenterColor.layer.borderColor = UIColor.clearColor().CGColor
        
        let geography = userObject?.valueForKey(geographyCategory) as! NSArray
        let music = userObject?.valueForKey(musicCategory) as! NSArray
        let movies = userObject?.valueForKey(moviesCategory) as! NSArray
        let science = userObject?.valueForKey(scienceCategory) as! NSArray
        let television = userObject?.valueForKey(televisionCategory) as! NSArray
        let history = userObject?.valueForKey(historyCategory) as! NSArray
        let money = userObject?.valueForKey(moneyCategory) as! NSArray
        let products = userObject?.valueForKey(productsCategory) as! NSArray
        let people = userObject?.valueForKey(peopleCategory) as! NSArray
        let sports = userObject?.valueForKey(sportsCategory) as! NSArray

        
        let geoCount = Double(geography.count)
        let musicCount = Double(music.count)
        let moviesCount = Double(movies.count)
        let scienceCount = Double(science.count)
        let tvCount = Double(television.count)
        let historyCount = Double(history.count)
        let moneyCount = Double(money.count)
        let productsCount = Double(products.count)
        let peopleCount = Double(people.count)
        let sportsCount = Double(sports.count)

        
        self.categoryChartCategoryLabel.hidden = true
        self.categoryChartNumberLabel.hidden = true
        self.totalAnswerLabel.hidden = false
        
        let totalNumber = Int(geoCount + musicCount + moviesCount + scienceCount + tvCount + historyCount + moneyCount + productsCount + peopleCount + sportsCount)
        
        self.totalAnswerLabel.text = String(totalNumber)
        
        
    }

    
    
    
    // LocationChart
    //////////
    ////////////////
    

    func whereChartBarPressed(sender: UIButton) {
        
        if checkmarkImage.hidden == false {
            
            checkmarkImage.removeFromSuperview()
            
        }
        
        for answerCount in answerCountLabels {
            
            answerCount.setTitleColor(lightColoredFont, forState: .Normal)
            answerCount.layer.cornerRadius = 4.0
            answerCount.layer.borderColor = UIColor.clearColor().CGColor
            answerCount.layer.borderWidth = 0.0
            answerCount.backgroundColor = UIColor.clearColor()
            answerCount.contentVerticalAlignment = .Center
            
        }
        
        for item in locationLabels {
            
            item.hidden = true
            
        }
        
        for button in locationBars {
            
            button.layer.cornerRadius = 0.0
            button.layer.borderColor = UIColor.clearColor().CGColor
            button.layer.borderWidth = 0.0
            
        }
        
        var bar: UIButton = locationBars[sender.tag]
        bar.layer.cornerRadius = 3.0
        bar.layer.borderColor = lightColoredFont.CGColor
        bar.layer.borderWidth = 2.0
        
        var countLabel = answerCountLabels[sender.tag]
        countLabel.layer.cornerRadius = 4.0
        countLabel.backgroundColor = lightColoredFont
        countLabel.setTitleColor(backgroundColor, forState: .Normal)
        countLabel.contentEdgeInsets = UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)
        countLabel.contentVerticalAlignment = UIControlContentVerticalAlignment.Top

        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let viewHeightPercentage = viewHeight/100
        let viewWidthPercentage = viewWidth/100
        
        let xCord: CGFloat = 0.0
        let height: CGFloat = 29.0
        let yCord: CGFloat = (viewHeight * 2) - (bottomBackGround.frame.height / 2)
        let width: CGFloat = self.view.frame.width
        
    
        var label: UILabel = locationLabels[sender.tag]
        label.frame = CGRectMake(xCord, yCord, width, height)
        label.textAlignment = .Center
        let labelText: String = whereChartLocationNames[sender.tag]
        label.textColor = backgroundColor
        label.font = fontLargeRegular
        label.text = labelText.lowercaseString
        
        checkmarkImage.frame = CGRectMake(0.0, 0.0, 15.0, 15.0)
        checkmarkImage.frame.origin = CGPointMake((countLabel.frame.maxX - 34.0), (countLabel.frame.midY + 10.0))
        checkmarkImage.layer.cornerRadius = 2.0
        let image = UIImage(named: "checkmarkPNG1X")
        checkmarkImage.backgroundColor = UIColor(patternImage: image!)
        
        let viewWidthFourths = viewWidth/4
        
        let rankingLabelsWidth: CGFloat = 60
        let rankingLabelHeight: CGFloat = 30.0
        let rankingLabelsY = bottomBackGround.frame.minY - rankingLabelHeight - 5.0
        let leftLabelX = viewWidthFourths - (viewWidthFourths/3) - 20.0
        let centerLabelX = (viewWidthFourths * 2) - (viewWidthFourths/3)
        let rightLabelX = (viewWidthFourths * 3) - (viewWidthFourths/3) + 20.0
        let overLabelsY = rankingLabelsY - rankingLabelHeight + 4.5
        
        bottomBackGround.backgroundColor = locationBars[sender.tag].backgroundColor
        
        percentileRankingLabel.text = "\((userRankingPercentile[sender.tag]))%"
        percentileRankingLabel.textColor = lightColoredFont
        percentileRankingLabel.font = fontMedium
        percentileRankingLabel.textAlignment = .Center
        percentileRankingLabel.frame = CGRectMake(leftLabelX, rankingLabelsY, rankingLabelsWidth, rankingLabelHeight)
        
        percentileRankingOverLabel.text = "percentile"
        percentileRankingOverLabel.textColor = lightColoredFont
        percentileRankingOverLabel.font = fontTiny
        percentileRankingOverLabel.textAlignment = .Center
        percentileRankingOverLabel.frame = CGRectMake(leftLabelX - 10.0, overLabelsY, rankingLabelsWidth + 15.0, rankingLabelHeight)
        
        overallRankingLabel.text = addOrdinalIndicator(userRankingsOverall[sender.tag])
        overallRankingLabel.textColor = lightColoredFont
        overallRankingLabel.font = fontMedium
        overallRankingLabel.textAlignment = .Center
        overallRankingLabel.frame = CGRectMake(centerLabelX , rankingLabelsY, rankingLabelsWidth, rankingLabelHeight)
        
        overallRankingOverLabel.text = "rank"
        overallRankingOverLabel.textColor = lightColoredFont
        overallRankingOverLabel.font = fontTiny
        overallRankingOverLabel.textAlignment = .Center
        overallRankingOverLabel.frame = CGRectMake(centerLabelX , overLabelsY, rankingLabelsWidth, rankingLabelHeight)
        
        statusLabel.text = "citizen"
        statusLabel.textColor = lightColoredFont
        statusLabel.font = fontSmaller
        statusLabel.textAlignment = .Center
        statusLabel.frame = CGRectMake(rightLabelX, rankingLabelsY - 1.0, rankingLabelsWidth, rankingLabelHeight)
        
        statusOverLabel.text = "status"
        statusOverLabel.textColor = lightColoredFont
        statusOverLabel.font = fontTiny
        statusOverLabel.textAlignment = .Center
        statusOverLabel.frame = CGRectMake(rightLabelX, overLabelsY, rankingLabelsWidth, rankingLabelHeight)
        
        self.childView.addSubview(checkmarkImage)
        self.childView.bringSubviewToFront(checkmarkImage)
        println(checkmarkImage.frame.origin.x)
        println(checkmarkImage.frame.origin.y)
        
        label.hidden = false
        statusLabel.hidden = false
        overallRankingLabel.hidden = false
        percentileRankingLabel.hidden = false
        bottomBackGround.hidden = false
        checkmarkImage.hidden = false

    
    }
    
    
    
    func queryForPlacesPlayed(completion: (locationObjects: [PFObject], playedAreasDict: [String:Int]) -> Void) {
        
        let user = userObject
        var locationArray = user?.valueForKey(whereUserAnswered) as! NSArray
        
        var locationArrayCount = NSMutableArray()
        var locationArraySingleIds = NSMutableArray()
        
        for item in locationArray {
            
            locationArrayCount.addObject(item.count)
            locationArraySingleIds.addObject(item[0])
        }
        
        var locationDict = [String: Int]()
        
        for index in 0..<locationArray.count {
            
            var id = locationArraySingleIds[index] as! String
            var locationCount = locationArrayCount[index] as! Int
            
            locationDict[id] = locationCount
        }
        
        let sortedDictKeys = locationDict.sortedKeysByValue(>)
        
        let query = PFQuery(className: LocationClass)
        query.whereKey(objectId, containedIn: sortedDictKeys)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    completion(locationObjects: objects, playedAreasDict: locationDict)
                    
                }
            } else if error != nil {
                
                println(error!.localizedDescription)
            }
            
        }
        
    }
    
    
    //Login-Signup
    ////////////
    /////////////////

    
    func checkForUser() {
        
        if PFUser.currentUser() == nil {
            self.loginFunc()
            
        } else if PFUser.currentUser() != nil {
                    
            self.loadFunc()
            
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
            
            var loginViewController = PFLogInViewController()
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
            self.view.addSubview(signupViewController.signUpView!)

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
        
        self.loadFunc()

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
        
        self.loadFunc()

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
    



//Constraints and Layout
//////////////////////////
////////////////////////////


    func setConstraints() {
        
        let viewHeight = self.view.frame.height
        println(viewHeight)

        
        switch(viewHeight) {
            
        case 480:
            
            self.constraintPieChartToProfilePic.constant = self.view.frame.height/20
            self.constraintProfilePicTrailingToView.constant = self.view.frame.width/12.5
            self.contraintProfilePicToTopOfView.constant = self.view.frame.height/10
            
        case 568:
            
            self.constraintPieChartToProfilePic.constant = self.view.frame.height/11.5
            self.constraintProfilePicTrailingToView.constant = self.view.frame.width/12.5
            self.contraintProfilePicToTopOfView.constant = self.view.frame.height/10
            
        case 667:
            
            self.constraintPieChartToProfilePic.constant = self.view.frame.height/12
            self.constraintProfilePicTrailingToView.constant = self.view.frame.width/11
            self.contraintProfilePicToTopOfView.constant = self.view.frame.height/10
            
        case 736:
            
            self.constraintPieChartToProfilePic.constant = self.view.frame.height/12
            self.constraintProfilePicTrailingToView.constant = self.view.frame.width/11
            self.contraintProfilePicToTopOfView.constant = self.view.frame.height/10
            
        default:
            
            break
            
        }
        
    }
    

}










