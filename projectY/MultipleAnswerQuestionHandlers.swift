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
    //println(question)
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
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = 0 //percentYFromMasterFrame(questionLabel, masterView, 1.9)
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView, 7.04, 90)
    textField.backgroundColor = UIColor.blackColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = UIColor.whiteColor()
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    textField.tag = 7001
    textField.delegate = textFieldDelegate
    
    masterView.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    textField.frame.origin.y = percentYFromMasterFrame(textField, masterView, 48)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Dark
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
    let labelSpacing = masterView.frame.height * 0.0194
    var labelHeight = spaceBetweenQuestionAndTextField * 0.1172
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
    

    var count = 701
    var previousLabelY = CGFloat()
    
    for item in answers {
    
        let answerLabel = UILabel()
        answerLabel.text = item
        answerLabel.font = fontSmallest
        answerLabel.textColor = highColor
        answerLabel.textAlignment = .Left
        answerLabel.tag = count
        masterView.addSubview(answerLabel)

        answerLabel.frame.size.width = questionLabel.frame.width - 5.0
        answerLabel.frame.size.height = labelHeight
        
        let answerLight = UIView()
        answerLight.layer.borderWidth = 0.5
        answerLight.layer.borderColor = lowColor.CGColor
        answerLight.tag = count * 10
        drawPercentageRectOffView(answerLight, masterView, 3.34, 1.25)
        masterView.addSubview(answerLight)
        
        answerLight.frame.origin.x = questionLabel.frame.maxX
        
        answerLabel.frame.origin.x = questionLabel.frame.origin.x
        
        if answerLabel.tag == 701 {
            
            answerLabel.frame.origin.y = topLabelYOffset
            answerLight.center.y = answerLabel.center.y
            previousLabelY = answerLabel.frame.maxY
            
        } else {
            
            answerLabel.frame.origin.y = previousLabelY + labelSpacing
            answerLight.center.y = answerLabel.center.y
            previousLabelY = answerLabel.frame.maxY
            
        }
        
        answerLabel.hidden = true
        
        ++count
        
    }
    
}



func multipleAnswerQuestionWithImage(viewController: UIViewController, textFieldDelegate: UITextFieldDelegate, masterView: UIView, completion: (UITextField) -> Void) {
    
    let question: PFObject = questionObjectFromGameBoardSend!
    let imageFile = question.valueForKey(questionImageKey) as! PFFile
    let questionString = question.valueForKey(questionAskKey) as! String
    let questionAnswer = question.valueForKey(questionAnswersKey) as! NSArray
    let answer = questionAnswer[0] as! String
    
    let imageView = UIImageView()
    drawPercentageRectOffView(imageView, masterView, 35.05, 100)
    masterView.addSubview(imageView)
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView, 6.5, 90)
    textField.backgroundColor = UIColor.blackColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = UIColor.whiteColor()
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    textField.tag = 8001
    textField.delegate = textFieldDelegate
    
    viewController.view.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    textField.frame.origin.y = percentYFromBottomOfView(textField, imageView, masterView, 12.5)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Dark
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    let textFieldQuestionButton = UIButton()
    textFieldQuestionButton.setTitle("Q", forState: .Normal)
    textFieldQuestionButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    textFieldQuestionButton.titleLabel?.font = fontSmallMedium
    textFieldQuestionButton.backgroundColor = yellowColor
    textFieldQuestionButton.frame = CGRectMake(0, 0, (textField.frame.width * 0.138), textField.frame.height)
    textFieldQuestionButton.addTarget(viewController, action: Selector("dismissKeyboardShowQuestion:"), forControlEvents: .TouchUpInside)
    textFieldQuestionButton.tag = 8002
    textField.rightView = textFieldQuestionButton
    textField.rightViewMode = .Always
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 30, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    questionLabel.tag = 802
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = percentYFromBottomOfView(questionLabel, imageView, masterView, 11)
    
    drawCallKeyboardButton(viewController, masterView)
    drawAnswerLabelAndLights(masterView, imageView)
    
    queryForImage(imageFile, { (image) -> Void in
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        
        textField.hidden = true
        completion(textField)
        
    })
    
}



func drawCallKeyboardButton(viewController: UIViewController, masterView: UIView) {
    
    let button = UIButton()
    button.frame.size.width = masterView.frame.width * 0.20
    button.frame.size.height = masterView.frame.height * 0.0598
    button.setBackgroundImage(UIImage(named: "keyBoardCallButton"), forState: UIControlState.Normal)
    button.tag = 8003
    button.contentMode = .ScaleAspectFit
    masterView.addSubview(button)
    
    button.frame.origin.x = centerXAlignment(button, masterView)
    button.frame.origin.y = percentYFromMasterFrame(button, masterView, 90)
    
    button.addTarget(viewController, action: Selector("makeTextFieldFirstResponder:"), forControlEvents: .TouchUpInside)
    
    
}



func drawAnswerLabelAndLights(masterView: UIView, imageView: UIImageView) {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    let answerLabel = UILabel()
    answerLabel.text = ""
    drawPercentageRectOffView(answerLabel, masterView, 4.22, 85)
    answerLabel.textAlignment = .Center
    answerLabel.textColor = highestColor
    answerLabel.font = fontSmallerRegular
    answerLabel.tag = 811
    
    masterView.addSubview(answerLabel)
    
    answerLabel.frame.origin.x = centerXAlignment(answerLabel, masterView)
    answerLabel.frame.origin.y = imageView.frame.maxY + (masterView.frame.height * 0.0158)
    
    let yCoord = answerLabel.frame.origin.y + (masterView.frame.height * 0.0268)
    var startingXCoord = masterView.center.x
    var lightSpacing = (masterView.frame.width * 0.0156)
    
    var count = 8111
    var previousLightPositiveXCoord = CGFloat()
    var previousLightNegativeXCoord = CGFloat()
    
    if answers.count % 2 == 0 {
        
        startingXCoord = startingXCoord - ((masterView.frame.width * 0.0937) / 2) - (lightSpacing / 2)
        
    }
    
    for answer in answers {
        
        println(answers.count)
        
        let light = UIView()
        drawPercentageRectOffView(light, masterView, 0.7, 9.37)
        light.layer.borderWidth = 0.5
        light.layer.borderColor = lowColor.CGColor
        light.tag = count
        masterView.addSubview(light)
        
        light.frame.origin.y = answerLabel.frame.maxY + (masterView.frame.height * 0.0264)
        
        if count == 8111 {
            
            light.center.x = startingXCoord
            previousLightPositiveXCoord = light.center.x
            previousLightNegativeXCoord = light.center.x
            
            ++count
            
            continue
            
        }
        
        if count % 2 != 0 {
            
            println("modulo")
        
            light.center.x = previousLightNegativeXCoord - (lightSpacing + light.frame.width)
            previousLightNegativeXCoord = light.center.x
            
        } else if count % 2 == 0 {
            
            println("modulo no")

            light.center.x = previousLightPositiveXCoord + (lightSpacing + light.frame.width)
            previousLightPositiveXCoord = light.center.x
            
        }
        
        ++count
        
    }
    
}



func makeTextFieldFirstResponderForMultipleAnswerWithImage(sender: AnyObject?, viewController: UIViewController) {
    
    let sender = sender as! UIButton
    let questionAsk = viewController.view.viewWithTag(802) as! UILabel
    
    if let answerInputField = viewController.view.viewWithTag(8001) as? UITextField {
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            questionAsk.frame.origin.y += viewController.view.frame.maxY
            sender.frame.origin.y += viewController.view.frame.maxY
            
            }, completion: { (Bool) -> Void in
                
                answerInputField.becomeFirstResponder()
                answerInputField.hidden = false
                
        })
        
    }
    
}


func removeTextFieldFromFirstResponderForMultipleAnswerWithImage(viewController: UIViewController) {
    
    let showKeyboardButton = viewController.view.viewWithTag(8003) as! UIButton
    let questionAsk = viewController.view.viewWithTag(802) as! UILabel
    
    if let answerInputField = viewController.view.viewWithTag(8001) as? UITextField {
        
        answerInputField.resignFirstResponder()
        answerInputField.hidden = true
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            questionAsk.frame.origin.y -= viewController.view.frame.maxY
            showKeyboardButton.frame.origin.y -= viewController.view.frame.maxY
            
        })
    }
}



















