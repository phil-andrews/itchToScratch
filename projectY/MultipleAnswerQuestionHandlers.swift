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


func multipleAnswerQuestionNoImage(masterView: UIView, completion: (UITextField) -> Void) {
    
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



func multipleAnswerQuestionWithImage(viewController: UIViewController, masterView: UIView, completion: (UITextField) -> Void) {
    
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
    textField.tag = 2000
    
    masterView.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView)
    textField.frame.origin.y = percentYFromBottomOfView(textField, imageView, masterView, 12.5)
    
    let textFieldPadding = UIView()
    textFieldPadding.frame = CGRectMake(0, 0, 8, 40)
    textField.leftView = textFieldPadding
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.keyboardAppearance = .Dark
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 30, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = percentYFromBottomOfView(questionLabel, imageView, masterView, 11)
    
    drawCallKeyboardButton(viewController, masterView)
    
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
    button.tag = 2001
    button.contentMode = .ScaleAspectFit
    masterView.addSubview(button)
    
    button.frame.origin.x = centerXAlignment(button, masterView)
    button.frame.origin.y = percentYFromMasterFrame(button, masterView, 90)
    
    button.addTarget(viewController, action: Selector("makeTextFieldFirstResponder:"), forControlEvents: .TouchUpInside)
    
    
}
