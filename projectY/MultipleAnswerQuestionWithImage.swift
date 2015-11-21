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

func multipleAnswerQuestionWithImage(viewController: UIViewController, textFieldDelegate: UITextFieldDelegate, masterView: UIView, textFieldTag fieldTag: Int, textFieldQuestionButtonTag buttonTag: Int, answerLabelTag answerTag: Int, imageViewTag imageTag: Int, startingLightTag lightTag: Int, callKeybardButtonTag keyboardButtonTag: Int, completion: (UITextField) -> Void) {
    
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
    
    let questionLabel = PaddedLabel()
    drawPercentageRectOffView(questionLabel, masterView, 30, 100)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallest
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.7
    questionLabel.tag = answerTag
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = viewController.view.frame.height * 0.315
    
    drawCallKeyboardButton(viewController, masterView, keyboardButtonTag)
    drawAnswerLabelAndLights(masterView, imageView, textField, answerTag, lightTag)
    
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
    
    if answers.count % 2 == 0 {
        
        startingXCoord = startingXCoord - ((masterView.frame.width * 0.0937) / 2) - (lightSpacing / 2)
        
    }
    
    
    for answer in answers {
        
        let answerLabel = PaddedLabel()
        answerLabel.hidden = true
        answerLabel.text = answer
        answerLabel.backgroundColor = UIColor.whiteColor()
        answerLabel.textColor = UIColor.blackColor()
        answerLabel.font = fontSmallestRegular
        answerLabel.frame.size.height = masterView.frame.height * 0.0440
        answerLabel.frame.size.width = masterView.frame.width
        answerLabel.tag = count * 10
        
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
        
    }
    
}
