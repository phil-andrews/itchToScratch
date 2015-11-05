//
//  MultipleChoiceQuestionHandlers.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/4/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



func multipleChoiceQuestion(masterView: UIViewController, sView: UIView, question: PFObject, completion: () -> Void) {
    
    let questionString = question.valueForKey(questionAsk) as! String
    let questionAnswer = question.valueForKey(questionAnswers) as! NSArray
    let answer = questionAnswer[0] as! String
    let choices = question.valueForKey(questionChoices) as! NSArray
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView.view, 22, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallerRegular
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.baselineAdjustment = .AlignBaselines
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
        button.titleLabel?.font = fontAdjuster(choice, fontMediumMedium, fontLargeMedium, fontExtraLargeMedium)
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



func multipleChoiceQuestionWithImage(masterView: UIViewController, sView: UIView, question: PFObject, completion: () -> Void) {
    
    let imageFile = question.valueForKey(questionImage) as! PFFile
    let questionString = question.valueForKey(questionAsk) as! String
    let questionAnswer = question.valueForKey(questionAnswers) as! NSArray
    let answer = questionAnswer[0] as! String
    let choices = question.valueForKey(questionChoices) as! NSArray
    
    let imageView = UIImageView()
    drawPercentageRectOffView(imageView, sView, 35.05, 100)
    sView.addSubview(imageView)
    
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView.view, 13, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallestRegular
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    sView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView.view)
    questionLabel.frame.origin.y = imageView.frame.height + percentYFromMasterFrame(questionLabel, masterView.view, 2.52)
    
    var yOriginPercent = CGFloat()
    var yOffsetBetween = CGFloat()
    
    switch(choices.count) {
        
    case 3:
        
        yOriginPercent = 7.21
        yOffsetBetween = 4.9
        
    case 4:
        
        yOriginPercent = 2.0
        yOffsetBetween = 4
        
    case 5:
        
        yOriginPercent = 2.0
        yOffsetBetween = 3.5
        
    default:
        
        yOriginPercent = 2.0
        yOffsetBetween = 4
        
    }
    
    var count = 101
    
    for index in choices {
        
        let choice = index as! String
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.setTitle(choice, forState: .Normal)
        button.setTitleColor(yellowColor, forState: .Normal)
        button.titleLabel?.font = fontAdjuster(choice, fontSmallerMedium, fontSmallMedium, fontMediumMedium)
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

    
    queryForImage(imageFile, { (image) -> Void in
        
        imageView.image = image
        
        completion()
        
    })
}

















