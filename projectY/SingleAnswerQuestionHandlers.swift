//
//  SingleAnswerQuestionHandlers.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/12/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse

func singleAnswerQuestion(masterView: UIView, textFieldDelegate: UITextFieldDelegate, completion: (UITextField) -> Void) {
    
    let questionString = questionObjectFromGameBoardSend?.valueForKey(questionAskKey) as! String
    let answer = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    
    let questionLabel = PaddedLabel25()
    questionLabel.frame.size.width = masterView.frame.width
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.backgroundColor = backgroundColor
    questionLabel.font = fontSmallRegular
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    questionLabel.sizeToFit()
    questionLabel.frame.size.width = masterView.frame.width
    questionLabel.tag = 101
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView: masterView)
    questionLabel.frame.origin.y = masterView.frame.height * 0.0575
    
    masterView.addSubview(questionLabel)
    
    let answerLabel = UILabel()
    answerLabel.hidden = true
    answerLabel.frame.size.width = masterView.frame.width
    answerLabel.frame.size.height = masterView.frame.height * 0.0714
    answerLabel.text = answer[0]
    answerLabel.font = fontMedium
    answerLabel.textAlignment = .Center
    answerLabel.textColor = backgroundColor
    answerLabel.backgroundColor = UIColor.whiteColor()
    answerLabel.tag = 102
    
    masterView.insertSubview(answerLabel, belowSubview: questionLabel)
    
    answerLabel.frame.origin.x = centerXAlignment(answerLabel, masterView: masterView)
    answerLabel.frame.origin.y = questionLabel.frame.maxY + 15.0
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView: masterView, heightPercentage: 7.05, widthPercentage: 90)
    textField.backgroundColor = UIColor.whiteColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = backgroundColor
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    textField.tag = 1001
    textField.delegate = textFieldDelegate
    
    masterView.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView: masterView)
    textField.frame.origin.y = placeTextFieldAccordingToDeviceSize(masterView, textField: textField)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Light
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    completion(textField)
}



func singleAnswerQuestionWithImage(viewController: UIViewController, masterView: UIView, textFieldDelegate: UITextFieldDelegate, completion: (UITextField) -> Void) {
    
    let question: PFObject = questionObjectFromGameBoardSend!
    let imageFile = question.valueForKey(questionImageKey) as! PFFile
    let questionString = question.valueForKey(questionAskKey) as! String
    let questionAnswer = question.valueForKey(questionAnswersKey) as! NSArray
    let answer = questionAnswer[0] as! String
    
    let imageView = UIImageView()
    imageView.backgroundColor = backgroundColor
    drawPercentageRectOffView(imageView, masterView: masterView, heightPercentage: 35.05, widthPercentage: 100)
    masterView.addSubview(imageView)
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView: masterView, heightPercentage: 12, widthPercentage: 90)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.7
    questionLabel.tag = 101
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.y = imageView.frame.maxY + 3.0
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView: masterView)
    
    let answerLabel = UILabel()
    answerLabel.hidden = true
    answerLabel.frame.size.width = masterView.frame.width
    answerLabel.frame.size.height = masterView.frame.height * 0.0714
    answerLabel.text = answer
    answerLabel.font = fontMediumRegular
    answerLabel.textAlignment = .Center
    answerLabel.textColor = backgroundColor
    answerLabel.backgroundColor = UIColor.whiteColor()
    answerLabel.tag = 102
    
    masterView.insertSubview(answerLabel, belowSubview: imageView)
    
    answerLabel.frame.origin.x = centerXAlignment(answerLabel, masterView: masterView)
    answerLabel.frame.origin.y = imageView.frame.maxY + 15.0
    
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView: masterView, heightPercentage: 6.5, widthPercentage: 90)
    textField.backgroundColor = UIColor.whiteColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = backgroundColor
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    textField.tag = 1001
    textField.delegate = textFieldDelegate

    
    masterView.addSubview(textField)
    
    textField.frame.origin.y = placeTextFieldAccordingToDeviceSize(masterView, textField: textField)
    textField.frame.origin.x = centerXAlignment(textField, masterView: masterView)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Light
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    if masterView.frame.height <= 480 {
        
        questionLabel.frame.origin.y = percentYFromMasterFrame(questionLabel, masterView: masterView, percent: 55)
        questionLabel.frame.size.height = masterView.frame.height * 0.25
        textField.frame.origin.y = placeTextFieldAccordingToDeviceSize(masterView, textField: textField)
        drawCallKeyboardButton(viewController, masterView: masterView, buttonTag: 1003)
        
        let textFieldQuestionButton = UIButton()
        textFieldQuestionButton.setTitle("Q", forState: .Normal)
        textFieldQuestionButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        textFieldQuestionButton.titleLabel?.font = fontSmallMedium
        textFieldQuestionButton.backgroundColor = yellowColor
        textFieldQuestionButton.frame = CGRectMake(0, 0, (textField.frame.width * 0.138), textField.frame.height)
        textFieldQuestionButton.addTarget(viewController, action: Selector("dismissKeyboardShowQuestion:"), forControlEvents: .TouchUpInside)
        textFieldQuestionButton.tag = 1002
        textField.rightView = textFieldQuestionButton
        textField.rightViewMode = .Always
        
        textField.hidden = true
    }
    
    
    queryForImage(imageFile, completion: { (image) -> Void in
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        
        completion(textField)
        
    })
    
    
}




