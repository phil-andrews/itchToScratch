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
    
    let questionString = question.valueForKey(questionAskKey) as! String
    let questionAnswer = question.valueForKey(questionAnswersKey) as! NSArray
    let answer = questionAnswer[0] as! String
    let choices = question.valueForKey(questionChoicesKey) as! NSArray
    
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
    
    var count = 2001
    
    var randomChoicesArray = choices as NSMutableCopying
    
    for index in choices {
        
        let choice = index as! String
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.setTitle(choice, forState: .Normal)
        button.setTitleColor(lowColor, forState: .Normal)
        button.titleLabel?.font = fontAdjuster(choice, fontMedium, fontLarge, fontExtraLarge)
        button.addTarget(masterView, action: Selector("checkQuestionSubmission:"), forControlEvents: .TouchUpInside)
        button.tag = count
        button.sizeToFit()
        button.frame.size.width = masterView.view.frame.width
        
        if count == 2001 {
            
            button.frame.origin.y = percentYFromBottomOfView(button, questionLabel, masterView.view, yOriginPercent)
            
        } else if count != 2001 {
            
            let previousButton = masterView.view.viewWithTag(count - 1)
            
            button.frame.origin.y = percentYFromBottomOfView(button, previousButton!, masterView.view, yOffsetBetween)
        }
        
        button.frame.origin.x = centerXAlignment(button, masterView.view)
        
        sView.addSubview(button)
        
        ++count
        
    }
    
    completion()
    
}



func multipleChoiceQuestionWithImage(masterView: UIViewController, sView: UIView, question: PFObject, questionImage: UIImage, completion: () -> Void) {
    
    let imageFile = question.valueForKey(questionImageKey) as! PFFile
    let questionString = question.valueForKey(questionAskKey) as! String
    let questionAnswer = question.valueForKey(questionAnswersKey) as! NSArray
    let answer = questionAnswer[0] as! String
    let choices = question.valueForKey(questionChoicesKey) as! NSArray
    
    let imageView = UIImageView()
    drawPercentageRectOffView(imageView, masterView.view, 35.05, 100)
    imageView.image = questionImage
    masterView.view.addSubview(imageView)
    
    
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
    
    var count = 2001
    
    for index in choices {
        
        let choice = index as! String
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.setTitle(choice, forState: .Normal)
        button.setTitleColor(yellowColor, forState: .Normal)
        button.titleLabel?.font = fontAdjuster(choice, fontSmaller, fontSmall, fontMedium)
        button.addTarget(masterView, action: Selector("checkQuestionSubmission:"), forControlEvents: .TouchUpInside)
        button.tag = count
        button.sizeToFit()
        button.frame.size.width = masterView.view.frame.width
        
        if count == 2001 {
            
            button.frame.origin.y = percentYFromBottomOfView(button, questionLabel, masterView.view, yOriginPercent)
            
        } else if count != 2001 {
            
            let previousButton = masterView.view.viewWithTag(count - 1)
            
            button.frame.origin.y = percentYFromBottomOfView(button, previousButton!, masterView.view, yOffsetBetween)
        }
        
        button.frame.origin.x = centerXAlignment(button, masterView.view)
        
        sView.addSubview(button)
        
        ++count
        
    }

}

















