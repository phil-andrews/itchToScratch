//
//  MultipleAnswerWithImage.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/16/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse

func multipleAnswerQuestionWithImage(viewController: UIViewController, textFieldDelegate: UITextFieldDelegate, masterView: UIView, textFieldTag fieldTag: Int, textFieldQuestionButtonTag buttonTag: Int, questionLabelTag questionTag: Int, dropDownAnswerLabelTag dropDownTag: Int, imageViewTag imageTag: Int, startingLightTag lightTag: Int, callKeybardButtonTag keyboardButtonTag: Int, completion: (UITextField) -> Void) {
    
    let question: PFObject = questionObjectFromGameBoardSend!
    let imageFile = question.valueForKey(questionImageKey) as! PFFile
    let questionString = question.valueForKey(questionAskKey) as! String
    let questionAnswers = question.valueForKey(questionAnswersKey) as! NSArray
    
    let imageView = UIImageView()
    drawPercentageRectOffView(imageView, masterView, 35.05, 100)
    imageView.tag = imageTag
    masterView.addSubview(imageView)
    
    imageView.frame.origin.y = 0
    imageView.frame.origin.x = 0
    
    let textField = UITextField()
    textField.alpha = 0.0
    drawPercentageRectOffView(textField, masterView, 6.5, 90)
    textField.backgroundColor = UIColor.whiteColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = backgroundColor
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    textField.tag = fieldTag
    textField.keyboardAppearance = .Light
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    textField.delegate = textFieldDelegate
    
    viewController.view.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    textField.frame.origin.y = placeTextFieldAccordingToDeviceSize(masterView, textField)
    
    let dropDownAnswerLabel = UILabel()
    dropDownAnswerLabel.textAlignment = .Center
    dropDownAnswerLabel.font = fontLargeMedium
    dropDownAnswerLabel.frame.size.height = masterView.frame.height * 0.064
    dropDownAnswerLabel.frame.size.width = imageView.frame.width
    
    if masterView.frame.height <= 480 {
        dropDownAnswerLabel.frame.size.width = masterView.frame.width * 0.80
        dropDownAnswerLabel.frame.origin.x = centerXAlignment(dropDownAnswerLabel, masterView)
    }
    
    dropDownAnswerLabel.tag = dropDownTag
    masterView.insertSubview(dropDownAnswerLabel, belowSubview: masterView.viewWithTag(imageTag)!)
    
    dropDownAnswerLabel.frame.origin.y = imageView.frame.maxY - (dropDownAnswerLabel.frame.height * 1.25)
    
    let textFieldQuestionButton = UIButton()
    textFieldQuestionButton.setTitle("Q", forState: .Normal)
    textFieldQuestionButton.setTitleColor(backgroundColor, forState: .Normal)
    textFieldQuestionButton.titleLabel?.font = fontSmallMedium
    textFieldQuestionButton.backgroundColor = yellowColor
    textFieldQuestionButton.layer.borderWidth = 4.0
    textFieldQuestionButton.layer.borderColor = UIColor.whiteColor().CGColor
    textFieldQuestionButton.frame = CGRectMake(0, 0, (textField.frame.width * 0.138), textField.frame.height)
    textFieldQuestionButton.addTarget(viewController, action: Selector("dismissKeyboardShowQuestion:"), forControlEvents: .TouchUpInside)
    textFieldQuestionButton.tag = buttonTag
    textField.leftView = textFieldQuestionButton
    textField.leftViewMode = .Always
    
    let questionLabel = PaddedLabel15()
    drawPercentageRectOffView(questionLabel, masterView, 25, 100)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallest
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.7
    questionLabel.tag = questionTag
    
    if masterView.frame.height == 568 {
        
        questionLabel.font = fontTiny
        
    }
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = masterView.frame.height * 0.3453
    
    drawCallKeyboardButton(viewController, masterView, keyboardButtonTag)
    drawAnswerLabelAndLights(masterView, imageView, textField, dropDownTag, lightTag)
    
    queryForImage(imageFile, { (image) -> Void in
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        
        completion(textField)
        
    })
    
}



func drawCallKeyboardButton(viewController: UIViewController, masterView: UIView, buttonTag: Int) {
    
    let button = UIButton()
    button.frame.size.width = masterView.frame.width * 0.20
    button.frame.size.height = masterView.frame.height * 0.0598
    button.setBackgroundImage(UIImage(named: "keyBoardCallButton"), forState: UIControlState.Normal)
    button.tag = buttonTag
    button.contentMode = .ScaleAspectFit
    masterView.addSubview(button)
    
    button.frame.origin.x = centerXAlignment(button, masterView)
    button.frame.origin.y = percentYFromMasterFrame(button, masterView, 90)
    
    button.addTarget(viewController, action: Selector("makeTextFieldFirstResponder:"), forControlEvents: .TouchUpInside)
    
    
}



func drawAnswerLabelAndLights(masterView: UIView, imageView: UIImageView?, answerInputField: UITextField, answerLabelTag: Int, startingLightTag: Int) {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    let subImageViewAnswerShow = UILabel()
    subImageViewAnswerShow.text = ""
    drawPercentageRectOffView(subImageViewAnswerShow, masterView, 4.22, 100)
    subImageViewAnswerShow.textAlignment = .Center
    subImageViewAnswerShow.textColor = highestColor
    subImageViewAnswerShow.font = fontSmallerRegular
    subImageViewAnswerShow.tag = answerLabelTag
    
    masterView.addSubview(subImageViewAnswerShow)
    
    subImageViewAnswerShow.frame.origin.x = centerXAlignment(subImageViewAnswerShow, masterView)
    subImageViewAnswerShow.frame.origin.y = imageView!.frame.maxY
    
    let yCoord = subImageViewAnswerShow.frame.origin.y + (masterView.frame.height * 0.0268)
    var startingXCoord = masterView.center.x
    var lightSpacing = (masterView.frame.width * 0.0156)
    
    var count = startingLightTag
    
    var previousLightPositiveXCoord = CGFloat()
    var previousLightNegativeXCoord = CGFloat()
    var previousAnswerLabelYCoord = masterView.frame.height * 0.565
    
    let screenHeight = masterView.frame.height
    
    if answers.count % 2 == 0 {
        
        startingXCoord = startingXCoord - ((masterView.frame.width * 0.0937) / 2) - (lightSpacing / 2)
        
    }
    
    
    var answerLabelCount = answerLabelTag + 18
    
    for answer in answers {
        
        let answerLabel = PaddedLabel15()
        answerLabel.hidden = true
        answerLabel.text = answer
        answerLabel.backgroundColor = UIColor.whiteColor()
        answerLabel.textColor = UIColor.blackColor()
        answerLabel.font = fontSmallestRegular
        answerLabel.frame.size.height = masterView.frame.height * 0.0440
        answerLabel.frame.size.width = masterView.frame.width
        answerLabel.tag = answerLabelCount
        
        masterView.addSubview(answerLabel)
        
        answerLabel.frame.origin.x = 0
        answerLabel.frame.origin.y = previousAnswerLabelYCoord
        
        previousAnswerLabelYCoord = previousAnswerLabelYCoord + answerLabel.frame.height + 1
        
        let light = UIView()
        drawPercentageRectOffView(light, masterView, 0.7, 9.37)
        light.layer.borderWidth = 0.5
        light.layer.borderColor = lowColor.CGColor
        light.tag = count
        masterView.addSubview(light)
        
        light.frame.origin.y = masterView.frame.height * 0.363

        if count == startingLightTag {
            
            light.center.x = startingXCoord
            previousLightPositiveXCoord = light.center.x
            previousLightNegativeXCoord = light.center.x
            
            ++count
            ++answerLabelCount
            
            continue
            
        }
        
        if count % 2 != 0 {
            
            light.center.x = previousLightNegativeXCoord - (lightSpacing + light.frame.width)
            previousLightNegativeXCoord = light.center.x
            
        } else if count % 2 == 0 {
            
            light.center.x = previousLightPositiveXCoord + (lightSpacing + light.frame.width)
            previousLightPositiveXCoord = light.center.x
            
        }
        
        ++count
        ++answerLabelCount

    }
    
}



func makeTextFieldFirstResponderForImageQuestion(sender: AnyObject?, viewController: UIViewController) {
    
    println(sender!.tag)

    
    let sender = sender as! UIButton
    var textFieldTag = Int()
    var questionAskTag = Int()
    var imageViewTag = Int()
    var firstLightTag = Int()
    var arrayOfLights: [UIView]?
    
    switch(sender.tag) {
        
    case 1003:
        
        textFieldTag = 1001
        questionAskTag = 101
        
    case 8003:
        
        textFieldTag = 8001
        questionAskTag = 801
        imageViewTag = 803
        firstLightTag = 8111
        arrayOfLights = returnArrayOfLights(firstLightTag, viewController)
        
    case 9003:
        
        textFieldTag = 9001
        questionAskTag = 901
        imageViewTag = 903
        
    default:
        
        break
    }
    
    let questionAsk = viewController.view.viewWithTag(questionAskTag) as! UILabel
    let imageView = viewController.view.viewWithTag(imageViewTag) as! UIImageView
    let masterHeight = viewController.view.frame.height
    
    
    if let answerInputField = viewController.view.viewWithTag(textFieldTag) as? UITextField {
        
        if sender.tag != 1003 && sender.tag != 9003 {
            
            for item in arrayOfLights! {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    answerInputField.alpha = 1.0
                    
                    item.frame.origin.y = answerInputField.frame.minY - 10
                    
                })
                
            }
            
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            questionAsk.frame.origin.y += viewController.view.frame.maxY
            sender.frame.origin.y += viewController.view.frame.maxY
            
            }, completion: { (Bool) -> Void in
                
                answerInputField.becomeFirstResponder()
                
        })
        
    }
    
}



func removeTextFieldFromFirstResponderToShowQuestion(viewController: UIViewController, sender: AnyObject?, codeTag: Int?) {
    
    var senderTag = Int()
    
    if sender != nil {
        
        let sender = sender as! UIButton
        senderTag = sender.tag
        
    } else if sender == nil {
        
        senderTag = codeTag!
    }
    
    var textFieldTag = Int()
    var questionAskTag = Int()
    var dropDownTag: Int?
    var imageViewTag = Int()
    var keyboardButtonTag = Int()
    var firstLightTag = Int()
    var arrayOfLights: [UIView]?
    
    switch(senderTag) {
        
    case 1002:
        
        textFieldTag = 1001
        questionAskTag = 101
        keyboardButtonTag = 1003
        
    case 8002:
        
        textFieldTag = 8001
        questionAskTag = 801
        dropDownTag = 802
        imageViewTag = 803
        keyboardButtonTag = 8003
        firstLightTag = 8111
        arrayOfLights = returnArrayOfLights(firstLightTag, viewController)
        
    case 9002:
        
        textFieldTag = 9001
        questionAskTag = 901
        imageViewTag = 903
        keyboardButtonTag = 9003
        
    default:
        
        break
        
    }
    
    
    let showKeyboardButton = viewController.view.viewWithTag(keyboardButtonTag) as! UIButton
    let questionAsk = viewController.view.viewWithTag(questionAskTag) as! UILabel
    let imageView = viewController.view.viewWithTag(imageViewTag) as! UIImageView
    let masterViewHeight = viewController.view.frame.height
    
    if let answerInputField = viewController.view.viewWithTag(textFieldTag) as? UITextField {
        
        answerInputField.resignFirstResponder()
        
        if senderTag != 1002 && senderTag != 9002 {
            
            for item in arrayOfLights! {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    answerInputField.alpha = 0.0
                    
                    item.frame.origin.y = masterViewHeight * 0.363
                    
                })
                
            }
            
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            questionAsk.frame.origin.y -= viewController.view.frame.maxY
            
            if sender != nil {
                
                showKeyboardButton.frame.origin.y -= viewController.view.frame.maxY
                
            }
            
        })
    }
}



func returnArrayOfLights(firstLightTag: Int, viewController: UIViewController) -> [UIView] {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! NSArray
    
    var tagNumber = firstLightTag
    var arrayOfLights = [UIView]()
    
    for index in 0..<answers.count {
        
        let light = viewController.view.viewWithTag(tagNumber)
        
        arrayOfLights.append(light!)
        
        ++tagNumber
    }
    
    return arrayOfLights
    
}
