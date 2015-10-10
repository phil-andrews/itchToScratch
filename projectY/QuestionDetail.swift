//
//  QuestionDetail.swift
//  projectY
//
//  Created by Philip Ondrejack on 6/1/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI
import Bolts

class QuestionDetail: UITableViewController, UITextFieldDelegate {
    
    var parseObject: PFObject?
    var locationObject: PFObject?
    var objectPlace: Int?
    var imageForQuestion: UIImage?
    
    
    var arrayOfCorrect = [] as NSMutableArray
    var countOfCorrectAnswers = 0
    var blockButton = false

    @IBOutlet weak var topCell: UITableViewCell!
    @IBOutlet weak var bottomCell: UITableViewCell!
    @IBOutlet weak var topContentView: UIView!
    var topCellHeight = CGFloat()
    
    var detailImageView = UIImageView()
    @IBOutlet weak var answerInputField: UITextField!
    var questionLabel = UILabel()
    var questionLabelNOImage = UILabel()
    
    @IBOutlet weak var correctAnswerLabelOne: UILabel!
    @IBOutlet weak var correctAnswerLabelTwo: UILabel!
    @IBOutlet weak var correctAnswerLabelThree: UILabel!
    @IBOutlet weak var correctAnswerLabelFour: UILabel!
    @IBOutlet weak var correctAnswerLabelFive: UILabel!
    @IBOutlet weak var correctAnswerLabelSix: UILabel!
    @IBOutlet weak var correctAnswerLabelSeven: UILabel!
    @IBOutlet weak var correctAnswerLabelEight: UILabel!
    
    var correctFlash = UIImageView()
    
    let labelTextColor = "E9E8E8"
    
    
    @IBAction func goBack(sender: UISwipeGestureRecognizer) {

        
        self.goBackUnwind()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        self.topCell.backgroundColor = backgroundColor
        self.bottomCell.backgroundColor = backgroundColor
        self.bottomCell.alpha = 0.5
        
        self.answerInputField.delegate = self
        self.answerInputField.becomeFirstResponder()
        self.answerInputField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.answerInputField.clearsOnBeginEditing = true
        self.answerInputField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.answerInputField.backgroundColor = lightColoredFont
        
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.calculateTopCellSize()
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.formatScreen()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let bottomCellHeight: CGFloat = 34
        var cellHeight: CGFloat?
        var keyBoardHeight: CGFloat?
        
        switch(viewHeight) {
            
        case 736:
            
            keyBoardHeight = 271
            
        case 667:
            
            keyBoardHeight = 258

        case 568:
            
            keyBoardHeight = 253

        case 480:
            
            keyBoardHeight = 253
            detailImageView.contentMode = UIViewContentMode.ScaleAspectFit
            questionLabel.adjustsFontSizeToFitWidth = true
            
        default:
            
            keyBoardHeight = 275
            
        }
        
        if indexPath.row == 0 {
            
            cellHeight = ((viewHeight - bottomCellHeight) - keyBoardHeight!)
            topCellHeight = cellHeight!
            
        }
        
        if indexPath.row == 1 {
            
            cellHeight = bottomCellHeight

        }
        
        return cellHeight!
        
    }
    
    
    func calculateTopCellSize() {
        
        let viewHeight = self.view.frame.height
        let viewWidth = self.view.frame.width
        let bottomCellHeight: CGFloat = 34
        var cellHeight: CGFloat?
        var keyBoardHeight: CGFloat?
        
        switch(viewHeight) {
            
        case 736:
            
            keyBoardHeight = 271
            
        case 667:
            
            keyBoardHeight = 258
            
        case 568:
            
            keyBoardHeight = 253
            
        case 480:
            
            keyBoardHeight = 253
            detailImageView.contentMode = UIViewContentMode.ScaleAspectFit
            questionLabel.adjustsFontSizeToFitWidth = true
            
        default:
            
            keyBoardHeight = 275
            
        }
            
            cellHeight = ((viewHeight - bottomCellHeight) - keyBoardHeight!)
            topCellHeight = cellHeight!
        
    }


    func formatScreen() {
        
        self.correctAnswerLabelOne.hidden = true
        self.correctAnswerLabelTwo.hidden = true
        self.correctAnswerLabelThree.hidden = true
        self.correctAnswerLabelFour.hidden = true
        self.correctAnswerLabelFive.hidden = true
        self.correctAnswerLabelSix.hidden = true
        self.correctAnswerLabelSeven.hidden = true
        self.correctAnswerLabelEight.hidden = true

        drawPercentageRectOffView(self.correctFlash, self.view, 100.0, 100.0)
        
        self.view.addSubview(correctFlash)
        
        self.correctFlash.hidden = true
        
        let imageObject = self.parseObject as PFObject?
        
        if imageForQuestion?.isEqual(UIImage(named: noQuestionImage)) == true {
            
            println("image file equals nil")
            
            drawPercentageRectOffFloat(self.questionLabelNOImage, self.topContentView, topCellHeight, 50.0, 45)
            let yOffset = (self.topContentView.frame.height / 2) - (questionLabelNOImage.frame.height / 2)
            self.questionLabelNOImage.frame.offset(dx: 22.5, dy: yOffset)
            self.questionLabelNOImage.text = imageObject?.valueForKey(questionAsk) as? String
            self.questionLabelNOImage.textColor = lightColoredFont
            self.questionLabelNOImage.lineBreakMode = .ByWordWrapping
            self.questionLabelNOImage.numberOfLines = 0
            
            self.topContentView.addSubview(questionLabelNOImage)
            
            self.questionLabel.text = ""
            
        } else if imageForQuestion?.isEqual(UIImage(named: noQuestionImage)) == false {
            
            println("image file does not equal nil")
            
            self.detailImageView.hidden = false
            
            drawPercentageRectOffFloat(self.detailImageView, self.topContentView, topCellHeight, 60.0, 0)
            self.detailImageView.clipsToBounds = true
            self.detailImageView.image = imageForQuestion
            self.detailImageView.contentMode = .ScaleAspectFit
            self.topContentView.addSubview(detailImageView)

            let yOffset = detailImageView.frame.maxY + (questionLabel.frame.height)
            drawPercentageRectOffFloat(self.questionLabel, self.topContentView, topCellHeight, 40.0, 45)
            self.questionLabel.frame.offset(dx: 22.5, dy: yOffset)
            self.questionLabel.text = imageObject?.valueForKey(questionAsk) as? String
            self.questionLabel.textColor = lightColoredFont
            self.questionLabel.lineBreakMode  = .ByWordWrapping
            self.questionLabel.numberOfLines = 0
            
            self.topContentView.addSubview(questionLabel)
            
            self.questionLabelNOImage.text = ""

            
        }
        
        
    }
    
    
    
    func queryQuestionImage() {
        
        let imageObject = self.parseObject as PFObject?
        let imageFile = imageObject?.objectForKey(questionImage) as? PFFile
        
        imageFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
            
            if error == nil {
                
                self.detailImageView.image = UIImage(data: data!) as UIImage?
                
            } else if error != nil {
                
                println("error when querying for question image")
                println(error!.localizedDescription)
            }
            
            
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // *MARK Answer Input ////////////////////////////////////////////////////


    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        answerInputField.clearsOnBeginEditing = true
        
        answerInputField.autocorrectionType = UITextAutocorrectionType.Yes
        
    }

    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.checkMultipleAnswer(textField)
        
        return true
    }
 
    
    
    func checkMultipleAnswer(textField: UITextField) {
        
        let numberOfAnswersRequired = self.parseObject?.valueForKey(numberOfAnswers) as! Int
        
        var answers1: NSMutableArray? = self.parseObject?.valueForKey(questionAnswers) as? NSMutableArray
        var answers2: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersOne) as? NSMutableArray
        var answers3: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersTwo) as? NSMutableArray
        var answers4: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersThree) as? NSMutableArray
        var answers5: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersFour) as? NSMutableArray
        var answers6: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersFive) as? NSMutableArray
        var answers7: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersSix) as? NSMutableArray
        var answers8: NSMutableArray? = self.parseObject?.valueForKey(questionAnswersSeven) as? NSMutableArray
        
        switch(numberOfAnswersRequired) {
            
            case 1:
            
                self.singleAnswer(textField)
            
            case 2:
            
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                
                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
                }
            
            case 3:
            
                println("this is the number of answers: \(numberOfAnswersRequired)")
                
                
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers3!, arrayPlace: 3, runningCount: &count)
                
                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
                }

            case 4:
            
                println("this is the number of answers: \(numberOfAnswersRequired)")
                
                
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers3!, arrayPlace: 3, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers4!, arrayPlace: 4, runningCount: &count)
                
                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
            }
            
            case 5:
                
                println("this is the number of answers: \(numberOfAnswersRequired)")
                
                
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers3!, arrayPlace: 3, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers4!, arrayPlace: 4, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers5!, arrayPlace: 5, runningCount: &count)

                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
                }
                
            case 6:
                
                println("this is the number of answers: \(numberOfAnswersRequired)")
                
                
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers3!, arrayPlace: 3, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers4!, arrayPlace: 4, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers5!, arrayPlace: 5, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers6!, arrayPlace: 6, runningCount: &count)

                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
                }
                
            case 7:
                
                println("this is the number of answers: \(numberOfAnswersRequired)")
                
                
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers3!, arrayPlace: 3, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers4!, arrayPlace: 4, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers5!, arrayPlace: 5, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers6!, arrayPlace: 6, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers7!, arrayPlace: 7, runningCount: &count)

                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
                }
            
            case 8:
                
                println("this is the number of answers: \(numberOfAnswersRequired)")
                
                
                var count = 0
                
                self.multipleAnswerChecker(textField, answerArray: answers1!, arrayPlace: 1, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers2!, arrayPlace: 2, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers3!, arrayPlace: 3, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers4!, arrayPlace: 4, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers5!, arrayPlace: 5, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers6!, arrayPlace: 6, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers7!, arrayPlace: 7, runningCount: &count)
                self.multipleAnswerChecker(textField, answerArray: answers8!, arrayPlace: 8, runningCount: &count)

                println(count)
                
                if count == 0 {
                    
                    self.decrementUserGuesses()
                }
            
            default:
                
                self.singleAnswer(textField)
            
        }
        
    }
    
    
    
    func multipleAnswerChecker(textField: UITextField, answerArray: NSMutableArray, arrayPlace: Int, inout runningCount: Int) {
        
        if arrayOfCorrect.containsObject(arrayPlace) == false {
            
            for item in answerArray {
                
                if textField.text == item as! String {
                    
                    self.countOfCorrectAnswers = self.countOfCorrectAnswers + 1
                    
                    self.arrayOfCorrect.addObject(arrayPlace)
                    
                    println("this is the array of correct \(self.arrayOfCorrect)")
                    
                    runningCount = runningCount + 1
                    
                    var numberOfRequiredAnswers = self.parseObject?.valueForKey(numberOfAnswers) as! Int
                    
                    if self.countOfCorrectAnswers == numberOfRequiredAnswers {
                        
                        self.answerInputField.hidden = true
                        
                        self.answerInputField.enabled = false
                        
                        self.correctFlash.alpha = 0.0
                        
                        self.correctFlash.hidden = false
                        
                        self.fadeAnimation(self.correctFlash, duration: 1.5, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
                        self.fadeAnimation(self.correctFlash, duration: 1.0, delay: 1.5, alpha: 0.0, options: .CurveEaseOut)
                        
                        self.correctAnswerLabelReveal(numberOfRequiredAnswers)
                        
                        self.incrementAnswerCount()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    func singleAnswer(textField: UITextField) {
        
        var answers = parseObject?.valueForKey(questionAnswers) as! [String]
        var count = 0
        
        for item in answers  {
            
            if textField.text == item {
                
                println("yes, that answer is correct")
                
                count = count + 1
                
                self.answerInputField.hidden = true
                
                self.answerInputField.enabled = false
                
                let correctAnswer = self.parseObject?.valueForKey(questionAnswers) as! NSArray
                
                self.correctAnswerLabelOne.text = correctAnswer[0] as? String
                
                self.correctAnswerLabelOne.hidden = false
                
                self.correctAnswerLabelOne.alpha = 0.0
                
                self.correctFlash.hidden = false
                
                self.correctFlash.alpha = 0.0
                
                self.fadeAnimation(self.correctFlash, duration: 1.5, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
                self.fadeAnimation(self.correctAnswerLabelOne, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
                self.fadeAnimation(self.correctFlash, duration: 1.0, delay: 1.5, alpha: 0.0, options: .CurveEaseOut)
                
                self.blockButton = true
                
                self.incrementAnswerCount()
                
                break
                
            }
            
        }
        
        println(count)
        
        if count == 0 {
            
            self.decrementUserGuesses()
            
        }
        
    }
    
    
    func correctAnswerLabelReveal(numberOfAnswers: Int) {
        
        let answerLabelOne = self.parseObject?.valueForKey(questionAnswers) as? NSMutableArray
        let answerLabelTwo = self.parseObject?.valueForKey(questionAnswersOne) as? NSMutableArray
        let answerLabelThree = self.parseObject?.valueForKey(questionAnswersTwo) as? NSMutableArray
        let answerLabelFour = self.parseObject?.valueForKey(questionAnswersThree) as? NSMutableArray
        let answerLabelFive = self.parseObject?.valueForKey(questionAnswersFour) as? NSMutableArray
        let answerLabelSix = self.parseObject?.valueForKey(questionAnswersFive) as? NSMutableArray
        let answerLabelSeven = self.parseObject?.valueForKey(questionAnswersSix) as? NSMutableArray
        let answerLabelEight = self.parseObject?.valueForKey(questionAnswersSeven) as? NSMutableArray
        
        println(numberOfAnswers)
        
        switch(numberOfAnswers) {
            
        case 8:
            
            self.correctAnswerLabelEight.text = answerLabelEight?.firstObject as? String
            self.correctAnswerLabelEight.alpha = 0.0
            self.correctAnswerLabelEight.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelEight, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
            
        case 7:
            
            self.correctAnswerLabelSeven.text = answerLabelSeven?.firstObject as? String
            self.correctAnswerLabelSeven.alpha = 0.0
            self.correctAnswerLabelSeven.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelSeven, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
        case 6:
            
            self.correctAnswerLabelSix.text = answerLabelSix?.firstObject as? String
            self.correctAnswerLabelSix.alpha = 0.0
            self.correctAnswerLabelSix.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelSix, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
        case 5:
            
            self.correctAnswerLabelFive.text = answerLabelFive?.firstObject as? String
            self.correctAnswerLabelFive.alpha = 0.0
            self.correctAnswerLabelFive.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelFive, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
        case 4:
            
            self.correctAnswerLabelFour.text = answerLabelFour?.firstObject as? String
            self.correctAnswerLabelFour.alpha = 0.0
            self.correctAnswerLabelFour.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelFour, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
        case 3:
            
            self.correctAnswerLabelThree.text = answerLabelThree?.firstObject as? String
            self.correctAnswerLabelThree.alpha = 0.0
            self.correctAnswerLabelThree.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelThree, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
        case 2:
            
            self.correctAnswerLabelTwo.text = answerLabelTwo?.firstObject as? String
            self.correctAnswerLabelTwo.alpha = 0.0
            self.correctAnswerLabelTwo.hidden = false
            
            self.fadeAnimation(self.correctAnswerLabelTwo, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
            fallthrough
            
        case 1:
            
            self.correctAnswerLabelOne.text = answerLabelOne?.firstObject as? String
            self.correctAnswerLabelOne.alpha = 0.0
            self.correctAnswerLabelOne.hidden = false
            self.fadeAnimation(self.correctAnswerLabelOne, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            

        default :
            
            self.correctAnswerLabelOne.text = answerLabelOne?.firstObject as? String
            self.correctAnswerLabelOne.alpha = 0.0
            self.correctAnswerLabelOne.hidden = false
            self.fadeAnimation(self.correctAnswerLabelOne, duration: 0.3, delay: 0.0, alpha: 1.0, options: .CurveEaseIn)
            
        }
        
        self.blockButton = true
        
    }
    
    
    
    
    // *MARK Navigation ////////////////////////////////////////////////////

    
    
    func goBackUnwind() {
        println("green")
        
        self.performSegueWithIdentifier("questionDetailReturnSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("prepare for segue")
        
        let upcoming: BlueController = segue.destinationViewController as! BlueController
        
        if segue.identifier == "questionDetailReturnSegue" {
            
            if self.blockButton == true {
                
                println("block button equals true")
                
                let objectID = self.parseObject?.objectId!
                
                let user = PFUser.currentUser()
                
                let newAnswerNumber = upcoming.currentLocationObject?.valueForKey("ans\(self.objectPlace!)") as! Int + 1
                
                println("this is the answerNUmber: \(newAnswerNumber)")
                
                delay(0.5, { () -> () in
                    
                    upcoming.checkUsersAnsweredQuestions(upcoming.buttonOutlets[self.objectPlace!], objectID: objectID!)
                    
                    delay(0.25, { () -> () in
                        
                        upcoming.cellHighlighting(newAnswerNumber, cell: upcoming.buttonOutlets[self.objectPlace!], animation: true)
                    })
                    
                })
                
                
            }
            
        }
        
    }
    
    
    
    // *MARK Queries ////////////////////////////////////////////////////
    

    
    func incrementAnswerCount() {
        
        let query = PFQuery(className: LocationClass)
        let objectID = locationObject?.valueForKey(objectId) as! String
        query.getObjectInBackgroundWithId(objectID, block: { (object: PFObject?, error) -> Void in
            
            println(self.objectPlace)
            
            if error != nil {
                
                println(error!.localizedDescription)
                
            } else if let object = object {
                println("object should be saving")
                object.incrementKey("ans\(self.objectPlace!)")
                object[geoPoint] = PFGeoPoint(location: usersCurrentLocationData)
                object.saveInBackground()
                self.locationObject = object
                self.addObjectIDToUser()
            }
            
        })
        
    }
    
    

    func addObjectIDToUser() {
        
        let user = PFUser.currentUser()
        let questionObjectID = self.parseObject?.objectId
        let locationID = self.locationObject?.objectId
        
        let categories = [geographyCategory, sportsCategory, scienceCategory, moviesCategory, televisionCategory, musicCategory, historyCategory, moneyCategory, productsCategory]
        let category = self.parseObject?.valueForKey(questionCategory) as! String
        
        for item in categories {
            
            if item == category {
                
                user?.addObject(questionObjectID!, forKey: item)
                
            }
            
        }
        
        let image = self.parseObject?.valueForKey(questionImage) as? PFFile
        
        if image == nil {
            
            user?.addObject(questionObjectID!, forKey: questionJustTextCategory)
            
        } else if image != nil {
            
            user?.addObject(questionObjectID!, forKey: questionWithImageCategory)
            
        }
        
        let userAnsweredAreas = user?.valueForKey(whereUserAnswered) as! [NSMutableArray]
        
        var count = 0
        
        outerLoop: for item in userAnsweredAreas {
            
            if item[0] as? String == locationID {
                
                item.insertObject(locationID!, atIndex: 0)
                
                break outerLoop
                
            }
            
            println(userAnsweredAreas.count)
            
            if count == (userAnsweredAreas.count - 1) {
                
                println("new object was added to whereUserAnswered array")
                
                user?.addObject([locationID!], forKey: whereUserAnswered)
                
            }
            
            ++count

            
        }
        
        if userAnsweredAreas.count == 0 {
            
            println("new object was added to whereUserAnswered array")
            
            
            user?.addObject([locationID!], forKey: whereUserAnswered)
            
        }
        
        userQuestionObjectsToBlock.addObject(questionObjectID!)
        
        user?.addObject(questionObjectID!, forKey: questionsAnswered)
        user?.saveInBackground()
        self.updateScoreRankings()
        
    }
    
    
    
    func updateScoreRankings() {
        
        let user = PFUser.currentUser()
        var scoreRankings = self.locationObject?.valueForKey(scoreRankingsKey) as! NSMutableArray
        var whereAnswered = user?.valueForKey(whereUserAnswered) as! [NSArray]
        var totalAnswersAtCurrentLocation = Int()
        
        var count = 1
        
        for item in whereAnswered {
            
            let objectID = item[0] as! String
            
            if objectID == self.locationObject?.objectId {
                
                println("object ID's matched")
                
                totalAnswersAtCurrentLocation = item.count
                
                break
                
            }
            
            if count >= (whereAnswered.count) {
                
                println("new location for user")
                
                totalAnswersAtCurrentLocation = 1
                
                scoreRankings.addObject(totalAnswersAtCurrentLocation)
                
                self.locationObject?.setValue(scoreRankings, forKey: scoreRankingsKey)
                
                self.saveLocationObject(scoreRankings, key: scoreRankingsKey)
                
                return
                
            }
            
            ++count

        }
        
    
        for index in 0..<scoreRankings.count {
            
            println("indexing ran")
                
            var itemValue = scoreRankings[index] as! Int
            
            println(itemValue)
            println(totalAnswersAtCurrentLocation)

            
            if (itemValue + 1) == totalAnswersAtCurrentLocation {
                
                scoreRankings[index] = totalAnswersAtCurrentLocation
                
                self.locationObject?.setValue(scoreRankings, forKey: scoreRankingsKey)
                
                self.saveLocationObject(scoreRankings, key: scoreRankingsKey)
                
                break
                
            }
        
        }
        
        if scoreRankings.count == 0 {
            
            scoreRankings.addObject(totalAnswersAtCurrentLocation)
            
            self.locationObject?.setValue(scoreRankings, forKey: scoreRankingsKey)
            
            self.saveLocationObject(scoreRankings, key: scoreRankingsKey)
            
        }
            
    }
    
    
    
    func saveLocationObject(value: AnyObject, key: String) {
        
        let query = PFQuery(className: LocationClass)
        let locationObjectID = self.locationObject?.objectId
        query.getObjectInBackgroundWithId(locationObjectID!, block: { (object: PFObject?, error) -> Void in
            
            if error != nil {
                
                println(error!.localizedDescription)
                
            } else {
                
                object?.setValue(value, forKey: key)
                object?.saveInBackground()
                
            }
            
            
        })
        
        
        
    }
        
    
    
    
    
    func decrementUserGuesses() {
        
        let user = PFUser.currentUser()
        
        user?.incrementKey(userGuesses, byAmount: -1)
        
        user?.saveInBackground()
        
    }
    
    
    
    // *MARK Animations ////////////////////////////////////////////////////
    
    
    
    func fadeAnimation(viewToAnimate: UIView, duration: NSTimeInterval, delay: NSTimeInterval, alpha: CGFloat, options: UIViewAnimationOptions) {
        
        UIView.animateWithDuration(duration, delay: 0.0, options: options, animations: {
            
            viewToAnimate.alpha = alpha
            
            }, completion: nil)
        
    }
    
    
    func characterFlipAnimation(string: String) {
        
        let characterArray = Array(string)
        
        for item in characterArray {
            
            if item == "a" {
                
                
            }
            
        }
        
        
        
        
    }


    
}


