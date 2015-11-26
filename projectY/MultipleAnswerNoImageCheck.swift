//
//  MultipleAnswerCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/20/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit


func checkMultpleAnswerNoImageQuestion(viewController: UIViewController, answerInputField: UITextField, answerLabelStartTag: Int, inout submittedCount: Int, inout unhiddenAnswerLabelTags: [Int], completion: () -> Void) {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let submittedAnswer = answerInputField.text
    
    var submittedWasCorrect = false
    var labelTag = answerLabelStartTag
    let lightMatrix = indicatorLightSelector()
    
    for index in 0..<answers.count {
        
        let answerLabel = viewController.view.viewWithTag(labelTag) as! UILabel
        let answer = questionObjectFromGameBoardSend?.valueForKey("qAnswers\(index + 1)") as! [String]
        
        for item in answer {
            
            let itemLowerCase = item.lowercaseString
            let submittedAnswerLowerCase = submittedAnswer.lowercaseString
            
            if submittedAnswerLowerCase == itemLowerCase {
                
                println(answerLabel.text?.lowercaseString)
                println(answer[0])

                if answerLabel.text?.lowercaseString == answer[0].lowercaseString && answerLabel.hidden == true {
                   
                    let light = viewController.view.viewWithTag(7111 + lightMatrix[submittedCount]) as UIView!

                    animateAnswerLabelAnsweredCorrect(answerLabel, highColor, { () -> Void in
                        
                        animationForIndicatorLightFilledCorrect(light, highColor)

                    })
                    
                    submittedWasCorrect = true
                    
                    answerInputField.text = String("")
                    
                    unhiddenAnswerLabelTags.append(labelTag)
                    
                    ++submittedCount
                    
                }
                
            }
            
        }
        
        ++labelTag
        
    }
    
    if submittedWasCorrect == false && submittedCount < answers.count {
        
        let light = viewController.view.viewWithTag(7111 + lightMatrix[submittedCount]) as UIView!
        animateForIndicatorLightFilledIncorrect(light, lowColor)
        
        ++submittedCount
        
    }
    
    if submittedCount == (answers.count) {
        
        answerInputField.enabled = false
        answerInputField.hidden = true
        
        let delayAmount = 1.0
        
        animateAllViewsDownAfterFinalSubmit(viewController, answers, delayAmount, { () -> Void in
            
            animateHiddenAnswerLabels(viewController, unhiddenAnswerLabelTags, answerLabelStartTag, delayAmount, { () -> Void in
                
                
                // do something with scoring right here
                
                
            })
            
        })
        
    }
    
}


func animateAllViewsDownAfterFinalSubmit(viewController: UIViewController, answers: [String], delay: Double, completion: () -> Void) {
    
    let questionLabelTag = 701
    var startingLightTag = 7111
    var startingAnswerLabelTag = 702
    
    func animateDown(view: UIView) {
        
        UIView.animateKeyframesWithDuration(0.20, delay: delay, options: nil, animations: { () -> Void in
            
            view.center.y = view.center.y + (viewController.view.frame.height * 0.15)

        }) { (Bool) -> Void in
            
            
        }
        
    }
    
    for index in 0..<answers.count {
        
        let lightView = viewController.view.viewWithTag(startingLightTag + index)
        let answerLabel = viewController.view.viewWithTag(startingAnswerLabelTag + index)
        
        animateDown(lightView!)
        animateDown(answerLabel!)
        
    }
    
    
    let questionLabel = viewController.view.viewWithTag(questionLabelTag)
    animateDown(questionLabel!)
    
    completion()
    
}



func animateHiddenAnswerLabels(viewController: UIViewController, unhiddenViewTags: [Int], startingAnswerLabelTag: Int, delayAmount: Double, completion: () -> Void) {
    
    println("func ran")
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    var delayAmountCopy = delayAmount + 0.5
    
    if unhiddenViewTags.count < answers.count {
        
        for index in 0..<answers.count {
            
            let tag = startingAnswerLabelTag + index
            var match = true
            
            for item in unhiddenViewTags {
                
                if item == tag {
                    
                    match = false
                }
                
            }
            
            if match == true {
                
                let view = viewController.view.viewWithTag(tag) as! UILabel

                delayAmountCopy = delayAmountCopy + 0.15
                
                animateAnswerLabelsThatWereIncorrect(viewController, view, UIColor.whiteColor(), backgroundColor, delayAmountCopy, { () -> Void in
                    
                    
                })
                
            }

            
        }
        
    }
    
    completion()
    
}

