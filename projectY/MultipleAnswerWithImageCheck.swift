//
//  MultipleAnswerWithImageCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/21/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse


func checkMultpleAnswerWithImageQuestion(viewController: UIViewController, answerInputField: UITextField, dropDownLabelTag: Int, indicatorLightStartingTag: Int, inout submittedCount: Int, inout unhiddenAnswerLabelTags: [Int], completion: () -> Void) {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let submittedAnswer = answerInputField.text
    let answerDropDownLabel = viewController.view.viewWithTag(dropDownLabelTag) as! UILabel

    
    var submittedWasCorrect = false
    var bottomAnswerLabelTag: Int = dropDownLabelTag + 18
    let lightMatrix = indicatorLightSelector()
    
    for index in 0..<answers.count {
        
        let bottomAnswerLabel = viewController.view.viewWithTag(bottomAnswerLabelTag) as! UILabel
        let answer = questionObjectFromGameBoardSend?.valueForKey("qAnswers\(index + 1)") as! [String]
        
        for item in answer {
            
            let itemLowerCase = item.lowercaseString
            let submittedAnswerLowerCase = submittedAnswer.lowercaseString
            
            if submittedAnswerLowerCase == itemLowerCase {
                
                let light = viewController.view.viewWithTag(indicatorLightStartingTag + lightMatrix[submittedCount]) as UIView!
                
                animateDropDownAnswerLabel(viewController, dropDownLabelTag, item, highColor, backgroundColor, { () -> Void in
                    
                    animationForIndicatorLightFilledCorrect(light, highColor)
                    
                })
                
                let answerOne = answer[0]
                
                if bottomAnswerLabel.text?.lowercaseString == answerOne.lowercaseString {
                    
                    bottomAnswerLabel.backgroundColor = highColor
                    bottomAnswerLabel.textColor = backgroundColor
                    
                    let screenSize = viewController.view.frame.height
                        
                    if screenSize > 650 {
                        
                        bottomAnswerLabel.hidden = true
                        
                    } else if screenSize < 650 {
                        
                        bottomAnswerLabel.hidden = false
                    }
                    
                    
                    unhiddenAnswerLabelTags.append(bottomAnswerLabel.tag)
                    
                }
                
                submittedWasCorrect = true
                
                answerInputField.text = String("")
                
                ++submittedCount
                
            }
            
        }
        
        bottomAnswerLabelTag = bottomAnswerLabelTag + 1
        
    }
    
    if submittedWasCorrect == false && submittedCount < answers.count {
        
        println(indicatorLightStartingTag + lightMatrix[submittedCount])

        let light = viewController.view.viewWithTag(indicatorLightStartingTag + lightMatrix[submittedCount]) as UIView!
        
        animateForIndicatorLightFilledIncorrect(light, lowColor)
        
        ++submittedCount
        
    }
    
    if submittedCount == (answers.count) {
        
        answerInputField.enabled = false
        answerInputField.hidden = true
        
        let delayAmount = 1.0
        
        delay(delayAmount, { () -> () in
            
            removeTextFieldFromFirstResponderToShowQuestion(viewController, nil, 8002)

          
            delay(0.35, { () -> () in
                
                var startingIndex = dropDownLabelTag + 18
                var delay = 0.0
                
                for index in 0..<answers.count {
                    
                    let answerLabel = viewController.view.viewWithTag(startingIndex) as! UILabel
                    
                    if answerLabel.hidden == true {
                        
                        answerLabel.frame.origin.x -= viewController.view.frame.width
                        answerLabel.hidden = false
                        answerLabel.backgroundColor = UIColor.grayColor()
                        answerLabel.textColor = whiteColor
                        
                        UIView.animateWithDuration(0.20, delay: delay, usingSpringWithDamping: 3.0, initialSpringVelocity: 0.4, options: nil, animations: { () -> Void in
                            
                            answerLabel.frame.origin.x += viewController.view.frame.width
                            
                        }, completion: { (Bool) -> Void in
                        
                            
                        })
                        
                        delay = delay + 0.18
                    }
                    
                    ++startingIndex

                }
                
                
            })
            // do something with scoring right here
            
            
        })
        
    }
    
}


func animateDropDownAnswerLabel(viewController: UIViewController, dropDownLabelTag: Int, answerString: String, bgColor: UIColor, textColor: UIColor, completion: () -> Void) {
    
    let dropDownLabel = viewController.view.viewWithTag(dropDownLabelTag) as! UILabel

    dropDownLabel.text = answerString
    dropDownLabel.textColor = textColor
    dropDownLabel.backgroundColor = bgColor
    
    UIView.animateWithDuration(0.25, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: nil, animations: { () -> Void in
        
        dropDownLabel.center.y = dropDownLabel.center.y + (dropDownLabel.frame.height * 1.15)
        
    }) { (Bool) -> Void in
        
        completion()
        
         animateDropDownAnswerLabelToOriginalPosition(viewController, dropDownLabelTag, 2.0, { () -> Void in
            
            
         })

        
    }
    
}


func animateDropDownAnswerLabelToOriginalPosition(viewController: UIViewController, dropDownLabelTag: Int, delayAmount: Double, completion: () -> Void) {
    
    let dropDownLabel = viewController.view.viewWithTag(dropDownLabelTag) as! UILabel
    let imageView = viewController.view.viewWithTag(dropDownLabelTag + 1) as! UIImageView
    
    println(imageView.frame.maxY)
    
    UIView.animateKeyframesWithDuration(0.10, delay: delayAmount, options: nil, animations: { () -> Void in
        
        println("ran")

        
        dropDownLabel.frame.origin.y = imageView.frame.maxY - (dropDownLabel.frame.height * 1.25)
        
        }, completion: { (Bool) -> Void in
            
            completion()
            
    })
}













