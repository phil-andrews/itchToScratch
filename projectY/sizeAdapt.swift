//
//  sizeAdapt.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/17/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

func setFonts(view: UIView) {
    
    let viewHeight = view.frame.height
    
    switch(viewHeight) {
        
        case 480:
        
        fontBottom = robotoLight10!
        fontTiny = robotoLight12!
        fontSmallest = robotoLight14!
        fontSmaller = robotoLight16!
        fontSmall = robotoLight18!
        fontMedium = robotoLight20!
        fontLarge = robotoLight22!
        fontExtraLarge = robotoLight26!
        
        fontSmallestRegular = robotoRegular16!
        fontSmallerRegular = robotoRegular18!
        fontSmallRegular = robotoRegular20!
        fontMediumRegular = robotoRegular22!
        fontLargeRegular = robotoRegular24!
        fontExtraLargeRegular = robotoRegular26!
        
        fontSmallestMedium = robotoMedium16!
        fontSmallerMedium = robotoMedium18!
        fontSmallMedium = robotoMedium20!
        fontMediumMedium = robotoMedium22!
        fontLargeMedium = robotoMedium24!
        fontExtraLargeMedium = robotoMedium26!
        
        case 568:
        
        fontBottom = robotoLight14!
        fontTiny = robotoLight16!
        fontSmallest = robotoLight18!
        fontSmaller = robotoLight20!
        fontSmall = robotoLight22!
        fontMedium = robotoLight24!
        fontLarge = robotoLight26!
        fontExtraLarge = robotoLight28!
        
        fontSmallestRegular = robotoRegular18!
        fontSmallerRegular = robotoRegular20!
        fontSmallRegular = robotoRegular22!
        fontMediumRegular = robotoRegular24!
        fontLargeRegular = robotoRegular26!
        fontExtraLargeRegular = robotoRegular28!
        
        fontSmallestMedium = robotoMedium18!
        fontSmallerMedium = robotoMedium20!
        fontSmallMedium = robotoMedium22!
        fontMediumMedium = robotoMedium24!
        fontLargeMedium = robotoMedium26!
        fontExtraLargeMedium = robotoMedium28!

        
        case 667:
        
        fontBottom = robotoLight16!
        fontTiny = robotoLight18!
        fontSmallest = robotoLight20!
        fontSmaller = robotoLight22!
        fontSmall = robotoLight24!
        fontMedium = robotoLight26!
        fontLarge = robotoLight28!
        fontExtraLarge = robotoLight30!
        
        fontSmallestRegular = robotoRegular20!
        fontSmallerRegular = robotoRegular22!
        fontSmallRegular = robotoRegular24!
        fontMediumRegular = robotoRegular26!
        fontLargeRegular = robotoRegular28!
        fontExtraLargeRegular = robotoRegular30!
        
        fontSmallestMedium = robotoMedium20!
        fontSmallerMedium = robotoMedium22!
        fontSmallMedium = robotoMedium24!
        fontMediumMedium = robotoMedium26!
        fontLargeMedium = robotoMedium28!
        fontExtraLargeMedium = robotoMedium30!

        
        case 736:
        
        fontBottom = robotoLight18!
        fontTiny = robotoLight20!
        fontSmallest = robotoLight22!
        fontSmaller = robotoLight24!
        fontSmall = robotoLight26!
        fontMedium = robotoLight28!
        fontLarge = robotoLight30!
        fontExtraLarge = robotoLight32!
        
        fontSmallestRegular = robotoRegular22!
        fontSmallerRegular = robotoRegular24!
        fontSmallRegular = robotoRegular26!
        fontMediumRegular = robotoRegular28!
        fontLargeRegular = robotoRegular30!
        fontExtraLargeRegular = robotoRegular32!
        
        fontSmallestMedium = robotoMedium22!
        fontSmallerMedium = robotoMedium24!
        fontSmallMedium = robotoMedium26!
        fontMediumMedium = robotoMedium28!
        fontLargeMedium = robotoMedium30!
        fontExtraLargeMedium = robotoMedium32!
    
    default:
    
        fontBottom = robotoLight14!
        fontTiny = robotoLight16!
        fontSmallest = robotoLight18!
        fontSmaller = robotoLight20!
        fontSmall = robotoLight22!
        fontMedium = robotoLight24!
        fontLarge = robotoLight26!
        fontExtraLarge = robotoLight28!
        
        fontSmallestRegular = robotoRegular20!
        fontSmallerRegular = robotoRegular22!
        fontSmallRegular = robotoRegular24!
        fontMediumRegular = robotoRegular26!
        fontLargeRegular = robotoRegular28!
        fontExtraLargeRegular = robotoRegular30!
        
    }
    
    
}




func fontAdjuster(labelText: String, fontS: UIFont, fontM: UIFont, fontL: UIFont) -> UIFont {
    
    var font = fontS
    
    let textLength = labelText.length
    
    switch(textLength) {
        
    case _ where textLength < 25:
        
        font = fontL
        
    case _ where textLength >= 25:
        
        font = fontM
        
    case _ where textLength >= 50:
        
        font = fontL
        
    default:
        
        font = fontS
        
    }
    
    return font
    
}



func makeTextFieldFirstResponderForImageQuestion(sender: AnyObject?, viewController: UIViewController) {
    
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
        firstLightTag = 9111
        arrayOfLights = returnArrayOfLights(firstLightTag, viewController)

    default:
        
        break
    }
    
    let questionAsk = viewController.view.viewWithTag(questionAskTag) as! UILabel
    let imageView = viewController.view.viewWithTag(imageViewTag) as! UIImageView
    let masterHeight = viewController.view.frame.height
    
    
    if let answerInputField = viewController.view.viewWithTag(textFieldTag) as? UITextField {
        
        if sender.tag != 1003 {
            
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
    
    println(senderTag)
    
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
        firstLightTag = 9111
        arrayOfLights = returnArrayOfLights(firstLightTag, viewController)

    default:
        
        break
        
    }
    
    
    let showKeyboardButton = viewController.view.viewWithTag(keyboardButtonTag) as! UIButton
    let questionAsk = viewController.view.viewWithTag(questionAskTag) as! UILabel
    let imageView = viewController.view.viewWithTag(imageViewTag) as! UIImageView
    let masterViewHeight = viewController.view.frame.height
    
    if let answerInputField = viewController.view.viewWithTag(textFieldTag) as? UITextField {
        
        answerInputField.resignFirstResponder()
        
        if senderTag != 1002 {
            
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



func placeTextFieldAccordingToDeviceSize(masterView: UIView, textField: UITextField) -> CGFloat {

    var yCoordToReturn = CGFloat()
    
    let viewHeight = masterView.frame.height
    
    switch(viewHeight) {
        
    case 480:
        textField.autocorrectionType = UITextAutocorrectionType.No
        yCoordToReturn = viewHeight - 224 - textField.frame.height
        
    case 568:
        textField.autocorrectionType = UITextAutocorrectionType.Yes
        yCoordToReturn = viewHeight - 253 - textField.frame.height - 5
        
    case 667:
        textField.autocorrectionType = UITextAutocorrectionType.Yes
        yCoordToReturn = viewHeight - 258 - textField.frame.height - 5

    case 736:
        textField.autocorrectionType = UITextAutocorrectionType.Yes
        yCoordToReturn = viewHeight - 271 - textField.frame.height - 5
        
    default:
        
        yCoordToReturn = viewHeight - 253 - textField.frame.height - 5
    }
    
    return yCoordToReturn
    
}

