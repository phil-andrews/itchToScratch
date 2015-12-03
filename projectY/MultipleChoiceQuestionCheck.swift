//
//  MultipleChoiceQuestionCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/19/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



func checkMultipleChoiceQuestion(viewController: UIViewController, senderTag: Int, completion: () -> ()) {
    
    let answerArray = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let answer = answerArray[0]
    let answerButton = viewController.view.viewWithTag(senderTag) as! UIButton

    answerButton.enabled = false
    answerButton.setTitleColor(backgroundColor, forState: .Normal)
    answerButton.titleLabel?.font = fontLargeMedium
    answerButton.backgroundColor = UIColor.whiteColor()

    let buttonTags = [2001, 2002, 2003, 2004]
    var incorrectButtons = [UIButton]()
    var correctButton = UIButton()
    
    for tag in buttonTags {
        
        let button = viewController.view.viewWithTag(tag) as! UIButton
        let buttonTitle = button.titleLabel?.text
        button.enabled = false
        
        if buttonTitle == answer {
            
            correctButton = button
            
            if button.tag == senderTag {
                
            }
            
        } else if buttonTitle != answer && button.tag != senderTag {
            
            incorrectButtons.insert(button, atIndex: 0)
            
        } else if buttonTitle != answer && button.tag == senderTag {
            
            incorrectButtons.append(button)
            
        }
        
    }
    
    animateButtonsOnSubmit(viewController, incorrectButtons: incorrectButtons, correctButton: correctButton, senderTag: senderTag) { () -> () in
        
    }
    
}




func animateButtonsOnSubmit(viewController: UIViewController, incorrectButtons: [UIButton], correctButton: UIButton, senderTag: Int, completion: () -> ()) {
    
    var delayAmount: NSTimeInterval = 0.15
    
    for button in incorrectButtons {
    
        delayAmount = delayAmount + 0.20
        
        delay(delayAmount, closure: { () -> () in
            
            if button.tag == senderTag {
                
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.09
                animation.repeatCount = 2
                animation.autoreverses = true
                animation.fromValue = NSValue(CGPoint: CGPointMake(button.center.x - 10, button.center.y))
                animation.toValue = NSValue(CGPoint: CGPointMake(button.center.x + 10, button.center.y))
                button.layer.addAnimation(animation, forKey: "position")
                
            }
            
            UIView.transitionWithView(button, duration: 0.20, options: [], animations: { () -> Void in
                
                button.backgroundColor = UIColor.clearColor()
                
                button.setTitleColor(UIColor.grayColor(), forState: .Normal)
                
                }, completion: nil)
            
        })
        
        UIView.animateWithDuration(0.20, delay: delayAmount, options: [], animations: { () -> Void in
            
            button.transform = CGAffineTransformMakeScale(0.75, 0.75)
            
            }, completion: { (Bool) -> Void in
                
        })
        
    }
    
    
    delay(delayAmount, closure: { () -> () in
        
        correctButton.frame.size.width = viewController.view.frame.width
        correctButton.center.x = viewController.view.center.x
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: { () -> Void in
           
            if correctButton.tag == senderTag {
                
                correctButton.backgroundColor = highColor
                correctButton.setTitleColor(backgroundColor, forState: .Normal)
                
            } else {
                
                correctButton.backgroundColor = UIColor.whiteColor()
                correctButton.setTitleColor(backgroundColor, forState: .Normal)
                correctButton.titleLabel?.font = fontLargeMedium
                
            }
            
            
            }, completion: { (Bool) -> Void in
                
                if correctButton.tag == senderTag {
                    
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.09
                    animation.repeatCount = 2
                    animation.autoreverses = true
                    animation.fromValue = NSValue(CGPoint: CGPointMake(correctButton.center.x, correctButton.center.y - 7))
                    animation.toValue = NSValue(CGPoint: CGPointMake(correctButton.center.x, correctButton.center.y + 7 ))
                    correctButton.layer.addAnimation(animation, forKey: "position")
                    
                    let checkMarkView = UIImageView()
                    checkMarkView.image = UIImage(named: "checkmark")
                    checkMarkView.frame.size.height = viewController.view.frame.height * 0.0897
                    checkMarkView.frame.size.width = viewController.view.frame.width * 0.1875
                    checkMarkView.frame.origin.y = viewController.view.frame.height
                    checkMarkView.frame.origin.x = viewController.view.center.x
                    
                    viewController.view.addSubview(checkMarkView)
                    
                    UIView.animateWithDuration(2.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        
                        checkMarkView.frame.origin.y = viewController.view.frame.height * 0.01
                        checkMarkView.frame.origin.x = viewController.view.frame.maxX
                        
                    }, completion: { (Bool) -> Void in
                        
                        checkMarkView.removeFromSuperview()

                    })
                    
                    
                }
                
        })
        
        
    })
    
    
}




