//
//  OrderingQuestionCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/18/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit


func checkOrderingQuestion(viewController: UIViewController, completion: () -> Void) {
    
    let correctAnswers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    var labelTag = 401
    var numberCorrect = 0
    var incorrectLabelTags = [Int]()
    
    print(correctAnswers)
    
    var delayAmount = 0.00
    
    for index in 0..<correctAnswers.count {
        
        let answer = correctAnswers[index]
        let answerLabel = viewController.view.viewWithTag(labelTag) as! UILabel
        
        if answerLabel.text == answer {
            
            animateAnswerLabelCorrect(answerLabel, delayTime: delayAmount)
            
            delayAmount = delayAmount + 0.20
            ++labelTag
            ++numberCorrect
            
            continue
            
        } else if answerLabel.text != answer {
            
            incorrectLabelTags.append(answerLabel.tag)
            animateAnswerLabelIncorrect(answerLabel, delayTime: delayAmount)
            delayAmount = delayAmount + 0.20
            ++labelTag
            
        }
        
    }
    
    
    delay(2.0, closure: { () -> () in
        
        animateAnswerLabelsToCorrectPositions(viewController, labelTags: incorrectLabelTags, answerArray: correctAnswers)
    
        completion()
        
    })
    
}



func animateAnswerLabelCorrect(label: UILabel, delayTime: Double) {
    
    delay(delayTime, closure: { () -> () in
        
        UIView.transitionWithView(label, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
            label.textColor = highColor
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            label.transform = CGAffineTransformMakeScale(1.2, 1.2)
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    
                    label.transform = CGAffineTransformIdentity
                    
                    }, completion: { (Bool) -> Void in
                        
                        
                })
                
        }
        
    })
    
}


func animateAnswerLabelIncorrect(label: UILabel, delayTime: Double) {
 
    delay(delayTime, closure: { () -> () in
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.11
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(label.center.x - 15, label.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(label.center.x + 15, label.center.y))
        label.layer.addAnimation(animation, forKey: "position")
        
        label.textColor = UIColor.grayColor()
        
        
    })
    
    
}


func animateAnswerLabelsToCorrectPositions(viewController: UIViewController, labelTags: [Int], answerArray: [String]) {
    
    var text = String()
    
    var delayAmount = 0.0
    
    for tag in labelTags {
        
        switch(tag) {
            
        case 401:
            
            text = answerArray[0]
            
        case 402:
            
            text = answerArray[1]
            
        case 403:
            
            text = answerArray[2]
            
        case 404:
            
            text = answerArray[3]
            
        default:
            
            break
            
        }
        
        let answerLabel = viewController.view.viewWithTag(tag) as! UILabel
        
        answerLabel.alpha = 0.0
    
        answerLabel.frame.origin.x -= viewController.view.frame.width
        answerLabel.text = text
        answerLabel.textColor = lowColor
        answerLabel.font = fontAdjuster(answerLabel.text!, fontS: fontSmallestRegular, fontM: fontSmallerRegular, fontL: fontMediumRegular)
        answerLabel.frame.size.width = viewController.view.frame.width * 0.70
        answerLabel.numberOfLines = 3
        answerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.minimumScaleFactor = 0.5
        answerLabel.sizeToFit()
        answerLabel.frame.size.width = viewController.view.frame.width * 0.70
        answerLabel.alpha = 1.0
        
        delayAmount = delayAmount + 0.10
        
        UIView.animateWithDuration(0.2, delay: delayAmount, options: [], animations: { () -> Void in
            
            answerLabel.frame.origin.x += viewController.view.frame.width

        }, completion: { (Bool) -> Void in
          
            
        })
        
    }
    
}




