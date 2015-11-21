//
//  MultipleAnswerQuestionHandlers.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/13/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit


func multipleAnswerQuestionNoImage(masterView: UIView, textFieldDelegate: UITextFieldDelegate, completion: (UITextField) -> Void) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAskKey) as! String
    let numberOfAnswers = question?.valueForKey(numberOfAnswersKey) as! Int
    let answers = question?.valueForKey(questionAnswersKey) as! [String]
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 18.48, 90)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.7
    questionLabel.tag = 701
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = 0
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView, 7.04, 90)
    textField.backgroundColor = UIColor.whiteColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = backgroundColor
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.Always
    textField.clearsOnBeginEditing = true
    textField.tag = 7001
    textField.delegate = textFieldDelegate
    
    masterView.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    textField.frame.origin.y = placeTextFieldAccordingToDeviceSize(masterView, textField)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Light
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    drawAnswerLabelsForMultipleAnswerNoImage(masterView, questionLabel, textField)
    
    completion(textField)
    
}



func drawAnswerLabelsForMultipleAnswerNoImage(masterView: UIView, questionLabel: UILabel, answerInputField: UITextField) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAskKey) as! String
    let numberOfAnswers = question?.valueForKey(numberOfAnswersKey) as! Int
    let answers = question?.valueForKey(questionAnswersKey) as! [String]
    
    let spaceBetweenQuestionAndTextField = answerInputField.frame.minY - questionLabel.frame.maxY
    
    var answerLabelXOffset = questionLabel.frame.origin.x
    let labelSpacing = masterView.frame.height * 0.005
    var labelHeight = spaceBetweenQuestionAndTextField * 0.1472
    var answerLabelYOffset = labelHeight + labelSpacing
    var topLabelYOffset = CGFloat()

    
    switch(numberOfAnswers) {
        
    case 3:
        
        topLabelYOffset = (questionLabel.frame.maxY + (spaceBetweenQuestionAndTextField / 2)) - (labelHeight * 1.5) - labelSpacing
        
    case 4:
        
        topLabelYOffset = (questionLabel.frame.maxY + (spaceBetweenQuestionAndTextField / 2)) - (labelHeight * 2) - (labelSpacing * 2)
        
    case 5:
        
        topLabelYOffset = (questionLabel.frame.maxY + (spaceBetweenQuestionAndTextField / 2)) - (labelHeight * 2.5) - (labelSpacing * 2.5)
        
    default:
        
        answerLabelYOffset = 20
        
    }
    

    var count = 702
    var previousLabelY = CGFloat()
    
    for item in answers {
    
        let answerLabel = PaddedLabel()
        answerLabel.hidden = true
        answerLabel.text = item
        answerLabel.font = fontSmallest
        answerLabel.textColor = highColor
        answerLabel.textAlignment = .Left
        answerLabel.tag = count
        masterView.addSubview(answerLabel)

        answerLabel.frame.size.width = masterView.frame.width
        answerLabel.frame.size.height = labelHeight
        
        if answerLabel.tag == 702 {
            
            answerLabel.frame.origin.y = topLabelYOffset
            previousLabelY = answerLabel.frame.maxY
            
        } else {
            
            answerLabel.frame.origin.y = previousLabelY + labelSpacing
            previousLabelY = answerLabel.frame.maxY
            
        }
                
        ++count
        
    }
    
    var startingXCoord = masterView.center.x
    var lightSpacing = (masterView.frame.width * 0.0156)
    
    var answerLightCount = 7111
    var previousLightPositiveXCoord = CGFloat()
    var previousLightNegativeXCoord = CGFloat()
    
    if answers.count % 2 == 0 {
        
        startingXCoord = startingXCoord - ((masterView.frame.width * 0.0937) / 2) - (lightSpacing / 2)
        
    }
    
    for answer in answers {
        
        let light = UIView()
        drawPercentageRectOffView(light, masterView, 0.7, 9.37)
        light.layer.borderWidth = 0.5
        light.layer.borderColor = lowColor.CGColor
        light.tag = answerLightCount
        masterView.addSubview(light)
        
        light.frame.origin.y = answerInputField.frame.minY - (masterView.frame.height * 0.0105) - light.frame.height
        
        if answerLightCount == 7111 {
            
            light.center.x = startingXCoord
            previousLightPositiveXCoord = light.center.x
            previousLightNegativeXCoord = light.center.x
            
            ++answerLightCount
            
            continue
            
        }
        
        if answerLightCount % 2 != 0 {
            
            light.center.x = previousLightNegativeXCoord - (lightSpacing + light.frame.width)
            previousLightNegativeXCoord = light.center.x
            
        } else if answerLightCount % 2 == 0 {
            
            light.center.x = previousLightPositiveXCoord + (lightSpacing + light.frame.width)
            previousLightPositiveXCoord = light.center.x
            
        }
        
        ++answerLightCount
        
    }
    
}
























