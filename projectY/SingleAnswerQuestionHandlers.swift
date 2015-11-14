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

func singleAnswerQuestion(masterView: UIView, completion: (UITextField) -> Void) {
    
    let questionString = questionObjectFromGameBoardSend?.valueForKey(questionAskKey) as! String
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 30, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallerRegular
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = percentYFromMasterFrame(questionLabel, masterView, 10.75)
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView, 7.05, 90)
    textField.backgroundColor = UIColor.blackColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = UIColor.whiteColor()
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    
    masterView.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    textField.frame.origin.y = percentYFromMasterFrame(textField, masterView, 45.0)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Dark
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    completion(textField)
}



func singleAnswerQuestionWithImage(masterView: UIView, completion: (UITextField) -> Void) {
    
    let question: PFObject = questionObjectFromGameBoardSend!
    let imageFile = question.valueForKey(questionImageKey) as! PFFile
    let questionString = question.valueForKey(questionAskKey) as! String
    let questionAnswer = question.valueForKey(questionAnswersKey) as! NSArray
    let answer = questionAnswer[0] as! String
    
    let imageView = UIImageView()
    drawPercentageRectOffView(imageView, masterView, 35.05, 100)
    masterView.addSubview(imageView)
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 12, 90)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.7
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.y = imageView.frame.maxY + 3.0
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    
    let textField = UITextField()
    drawPercentageRectOffView(textField, masterView, 6.5, 90)
    textField.backgroundColor = UIColor.blackColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = UIColor.whiteColor()
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    
    masterView.addSubview(textField)
    
    textField.frame.origin.y = questionLabel.frame.maxY + 5
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Dark
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    
    queryForImage(imageFile, { (image) -> Void in
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        
        completion(textField)
        
    })
    
    
}




