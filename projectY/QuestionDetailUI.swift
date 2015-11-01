//
//  QuestionDetailUI.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/31/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Parse
import ParseUI
import Bolts
import SpriteKit

var questionObjectFromGameBoardSend: PFObject?

func displayQuestionContainer(masterView: UIViewController, question: PFObject, type: Int, completion: (UIView) -> Void) {

    let containerView = UIView()
    containerView.frame = masterView.view.bounds
    containerView.tag = 999
    
    let overLay = UIImageView()
    overLay.frame = masterView.view.bounds
    let image = UIImage(named: "blurEffect")
    overLay.image = image
    
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    var blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = masterView.view.bounds
    blurEffectView.alpha = 1.0
    
    containerView.addSubview(blurEffectView)
    containerView.addSubview(overLay)
    
    containerView.frame.origin.y += masterView.view.frame.height
    containerView.alpha = 0.98
    masterView.view.addSubview(containerView)
    
    completion(containerView)
    
}



func multipleChoiceQuestion(masterView: UIViewController, sView: UIView, question: PFObject, completion: () -> Void) {
    
    let questionString = question.valueForKey(questionAsk) as! String
    let questionAnswer = question.valueForKey(questionAnswers) as! NSArray
    let answer = questionAnswer[0] as! String
    let choices = question.valueForKey(questionChoices) as! NSArray
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView.view, 22, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    sView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView.view)
    questionLabel.frame.origin.y = percentYFromMasterFrame(questionLabel, masterView.view, 3.52)
    
    var yOriginPercent = CGFloat()
    var yOffsetBetween = CGFloat()
    
    switch(choices.count) {
        
    case 3:
        
        yOriginPercent = 8.8
        yOffsetBetween = 15.8
        
    case 4:
        
        yOriginPercent = 5.8
        yOffsetBetween = 9.5
        
    case 5:
        
        yOriginPercent = 5.8
        yOffsetBetween = 7.21
        
    default:
        
        yOriginPercent = 5.8
        yOffsetBetween = 7.21
        
    }
    
    var count = 101
    
    for index in choices {
        
        let choice = index as! String
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.setTitle(choice, forState: .Normal)
        button.setTitleColor(yellowColor, forState: .Normal)
        button.titleLabel?.font = fontExtraLargeRegular
        button.addTarget(masterView, action: Selector("checkAnswerHandler"), forControlEvents: .TouchUpInside)
        button.tag = count
        button.sizeToFit()
        
        if count == 101 {
            
            button.frame.origin.y = percentYFromBottomOfView(button, questionLabel, masterView.view, yOriginPercent)
            
        } else if count != 101 {
            
            let previousButton = masterView.view.viewWithTag(count - 1)
            
            button.frame.origin.y = percentYFromBottomOfView(button, previousButton!, masterView.view, yOffsetBetween)
        }
        
        button.frame.origin.x = centerXAlignment(button, masterView.view)
        
        sView.addSubview(button)
        
        ++count
        
    }
    
    completion()
    
}



func singleAnswerQuestionNoImage() {
    
    
    
    
    
}



func singleAnswerQuestionWithImage() {
    
    
    
    
    
}



func multipleAnswerQuestionWithImage() {
    
    
    
    
    
}



func orderingQuestion(masterView: UIView, label1: UILabel, label2: UILabel, label3: UILabel, label4: UILabel, completion: () -> Void) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAsk) as! String
    var choices = question?.valueForKey(questionChoices) as! [String]
    let answers = question?.valueForKey(questionAnswers) as! [String]
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 22, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    masterView.addSubview(questionLabel)

    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = percentYFromMasterFrame(questionLabel, masterView, 3.52)
    
    var yOriginPercent = CGFloat()
    var yOffsetBetween = CGFloat()
    
    switch(choices.count) {
        
    case 3:
        
        yOriginPercent = 8.8
        yOffsetBetween = 15.8
        
    case 4:
        
        yOriginPercent = 5.8
        yOffsetBetween = 9.5
        
    case 5:
        
        yOriginPercent = 5.8
        yOffsetBetween = 7.21
        
    default:
        
        yOriginPercent = 5.8
        yOffsetBetween = 7.21
        
    }
    
    var labelArray = [label1, label2, label3, label4]
    
    var count = 401
    
    for index in 0..<choices.count {
        
        let label = labelArray[index] as UILabel!
        
        var int = Int()
        int = Int(arc4random_uniform(UInt32(choices.count)))
        let labelText = choices.removeAtIndex(int)
        label.text = labelText
        
        label.textColor = yellowColor
        label.font = fontExtraLarge
        label.sizeToFit()
        label.tag = count
        
        if count == 401 {
            
            label.frame.origin.y = percentYFromBottomOfView(label, questionLabel, masterView, yOriginPercent)
            
        } else if count != 401 {
            
            let previousLabel = masterView.viewWithTag(count - 1)
            
            label.frame.origin.y = percentYFromBottomOfView(label, previousLabel!, masterView, yOffsetBetween)
        }
        
        label.frame.origin.x = centerXAlignment(label, masterView)
        
        masterView.addSubview(label)
        
        ++count
        
    }
    
    completion()
    
}




func multipleAnswerQuestionNoImage() {
    
    
    
    
}




func numberRangeQuestion() {
    
    
    
    
    
}




func checkAnswerSubmitted() {
    
    let question = questionObjectFromGameBoardSend
    let type = question!.valueForKey(questionType) as! Int
    let questionString = question!.valueForKey(questionAsk) as! String
    let category = question!.valueForKey(questionCategory) as! String
    let answersNeeded = question!.valueForKey(numberOfAnswers) as! Int
    var answerArray = question!.valueForKey(questionAnswers) as! NSMutableArray
    
    
    println("func ran")
    
    
    
    
}


func animateContainerView(masterView: UIViewController, containerView: UIView) {
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
        
        containerView.frame.origin.y -= masterView.view.frame.height
        
    })
    
    
    
}





