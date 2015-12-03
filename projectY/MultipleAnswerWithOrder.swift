//
//  MultipleAnswerWithOrder.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/28/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit



func multipleAnswerQuestionWithOrder(viewController: UIViewController, textFieldDelegate: UITextFieldDelegate, masterView: UIView, completion: (UITextField) -> Void) {
    
    let question: PFObject = questionObjectFromGameBoardSend!
    let imageFile = question.valueForKey(questionImageKey) as! PFFile
    let questionString = question.valueForKey(questionAskKey) as! String
    
    let imageView = UIImageView()
    drawPercentageRectOffView(imageView, masterView: masterView, heightPercentage: 35.05, widthPercentage: 100)
    masterView.addSubview(imageView)
    imageView.tag = 902
    
    imageView.frame.origin.y = 0
    imageView.frame.origin.x = 0
    
    let textField = UITextField()
    textField.alpha = 0.0
    drawPercentageRectOffView(textField, masterView: masterView, heightPercentage: 6.5, widthPercentage: 90)
    textField.backgroundColor = UIColor.whiteColor()
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 4.0
    textField.font = fontSmallerMedium
    textField.textColor = backgroundColor
    textField.textAlignment = .Left
    textField.clearButtonMode = UITextFieldViewMode.WhileEditing
    textField.keyboardAppearance = .Light
    textField.keyboardType = UIKeyboardType.Default
    textField.returnKeyType = .Go
    textField.delegate = textFieldDelegate
    textField.tag = 9001
    
    viewController.view.addSubview(textField)
    
    textField.frame.origin.x = centerXAlignment(textField, masterView: masterView)
    textField.frame.origin.y = placeTextFieldAccordingToDeviceSize(masterView, textField: textField)
    
    let dropDownAnswerLabel = UILabel()
    dropDownAnswerLabel.hidden = true
    dropDownAnswerLabel.textColor = backgroundColor
    dropDownAnswerLabel.textAlignment = .Center
    dropDownAnswerLabel.font = fontLargeMedium
    dropDownAnswerLabel.frame.size.height = masterView.frame.height * 0.064
    dropDownAnswerLabel.frame.size.width = imageView.frame.width
    dropDownAnswerLabel.tag = 904
    
    if masterView.frame.height <= 480 {
        dropDownAnswerLabel.frame.size.width = masterView.frame.width * 0.80
        dropDownAnswerLabel.frame.origin.x = centerXAlignment(dropDownAnswerLabel, masterView: masterView)
    }
    
    masterView.addSubview(dropDownAnswerLabel)
    
    dropDownAnswerLabel.frame.origin.y = imageView.frame.maxY - dropDownAnswerLabel.frame.height
    
    let textFieldQuestionButton = UIButton()
    textFieldQuestionButton.tag = 9002
    textFieldQuestionButton.setTitle("Q", forState: .Normal)
    textFieldQuestionButton.setTitleColor(backgroundColor, forState: .Normal)
    textFieldQuestionButton.titleLabel?.font = fontSmallMedium
    textFieldQuestionButton.backgroundColor = yellowColor
    textFieldQuestionButton.layer.borderWidth = 4.0
    textFieldQuestionButton.layer.borderColor = UIColor.whiteColor().CGColor
    textFieldQuestionButton.frame = CGRectMake(0, 0, (textField.frame.width * 0.138), textField.frame.height)
    textFieldQuestionButton.addTarget(viewController, action: Selector("dismissKeyboardShowQuestion:"), forControlEvents: .TouchUpInside)
    textField.leftView = textFieldQuestionButton
    textField.leftViewMode = .Always
    
    let questionLabel = PaddedLabel15()
    questionLabel.tag = 901
    drawPercentageRectOffView(questionLabel, masterView: masterView, heightPercentage: 25, widthPercentage: 100)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallest
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.7
    
    if masterView.frame.height == 568 {
        
        questionLabel.font = fontTiny
        
    }
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView: masterView)
    questionLabel.frame.origin.y = masterView.frame.height * 0.3453
    
    drawCallKeyboardButton(viewController, masterView: masterView, buttonTag: 9003)
    
    drawSelectorButtons(viewController, imageView: imageView, answerInputField: textField)
    
    queryForImage(imageFile, completion: { (image) -> Void in
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        
        completion(textField)
        
    })
    
}



func drawSelectorButtons(viewController: UIViewController, imageView: UIImageView, answerInputField: UITextField) {
    
    let firstColor = UIColor(red: 1.0, green: 190.0, blue: 19.0, alpha: 1.0)
    let secondColor = UIColor(red: 1.0, green: 190.0, blue: 19.0, alpha: 1.0)
    let thirdColor = UIColor(red: 1.0, green: 190.0, blue: 19.0, alpha: 1.0)
    let fourthColor = UIColor(red: 1.0, green: 190.0, blue: 19.0, alpha: 1.0)
    let fifthColor = UIColor(red: 1.0, green: 190.0, blue: 19.0, alpha: 1.0)
    let sixthColor = UIColor(red: 1.0, green: 190.0, blue: 19.0, alpha: 1.0)
    
    let colorArray = [firstColor, secondColor, thirdColor, fourthColor, fifthColor, sixthColor]
    
    let questionAnswers = questionObjectFromGameBoardSend!.valueForKey(questionAnswersKey) as! NSArray

    var count = 0
    
    let yCoord = imageView.frame.maxY + ((answerInputField.frame.origin.y - imageView.frame.maxY) / 2)
    
    for _ in questionAnswers {
        
        ++count
        
        let button = UIButton()
        button.hidden = true
        button.tag = count
        button.addTarget(viewController, action: Selector("userChoseSectionToAnswer:"), forControlEvents: .TouchUpInside)
        button.frame.size.width = viewController.view.frame.width * 0.1
        button.frame.size.height = viewController.view.frame.width * 0.1
        button.layer.cornerRadius = button.frame.height/2
        button.layer.borderWidth = 1.5
        button.layer.borderColor = colorArray[count - 1].CGColor
        
        let xCoord = (Double(viewController.view.frame.width) / Double(questionAnswers.count + 1)) * Double(count)
        
        button.center.y = yCoord
        button.center.x = CGFloat(xCoord)
        
        viewController.view.addSubview(button)
        
        
    }
    
    
}



func removeTextFieldFromFirstResponderToShowQuestionMultipleAnswerWithOrder(viewController: UIViewController, sender: AnyObject?) {
    
    
    let showKeyboardButton = viewController.view.viewWithTag(9003) as! UIButton
    let questionAsk = viewController.view.viewWithTag(901) as! UILabel
    
    if let answerInputField = viewController.view.viewWithTag(9001) as? UITextField {
        
        answerInputField.resignFirstResponder()
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            answerInputField.alpha = 0.0
            
            questionAsk.frame.origin.y -= viewController.view.frame.maxY
            
            if sender != nil {
                
                showKeyboardButton.frame.origin.y -= viewController.view.frame.maxY
                
            }
            
        })
    }
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    for index in 0..<answers.count {
        
        let button = viewController.view.viewWithTag(index + 1) as! UIButton

        UIView.animateWithDuration(0.15, animations: { () -> Void in
            
            button.alpha = 0.0
            
        }, completion: { (Bool) -> Void in
            
            button.hidden = true
        })
        
    }
}


func makeTextFieldFirstResponderForImageQuestionWithOrder(sender: AnyObject?, viewController: UIViewController) {
    
    let questionAsk = viewController.view.viewWithTag(901) as! UILabel
    
    if let answerInputField = viewController.view.viewWithTag(9001) as? UITextField {
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            questionAsk.frame.origin.y += viewController.view.frame.maxY
            
            answerInputField.alpha = 1.0
            
            if let sender = sender as? UIButton {
                
            sender.frame.origin.y += viewController.view.frame.maxY
            
            }
            
            }, completion: { (Bool) -> Void in
                
                answerInputField.becomeFirstResponder()
                
        })
        
    }
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    for index in 0..<answers.count {
        
        let button = viewController.view.viewWithTag(index + 1) as! UIButton
        button.alpha = 0.0
        button.hidden = false
        
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            
            button.alpha = 1.0
            
        })
        
    }
    
}
