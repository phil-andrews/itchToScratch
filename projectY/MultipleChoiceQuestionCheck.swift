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



func checkMultipleChoiceQuestion(viewController: UIViewController, answerTag: Int, completion: () -> ()) {
    
    let answerArray = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let answer = answerArray[0]
    let answerButton = viewController.view.viewWithTag(answerTag) as! UIButton
    let submittedAnswer = answerButton.titleLabel?.text
    
    println("this is the answer: \(answer)")
    println("this is the submit: \(submittedAnswer)")

    let buttonTags = [2001, 2002, 2003, 2004]
    var incorrectButtons = [UIButton]()
    var correctButton = UIButton()
    
    for tag in buttonTags {
        
        let button = viewController.view.viewWithTag(tag) as! UIButton
        let buttonLabel = button.titleLabel?.text
        
        if buttonLabel == answer && button.tag == answerTag {
            
            correctButton = button
            
        } else if buttonLabel != answer && button.tag == answerTag {
            
            //animate to correct answer
            
            incorrectButtons.append(button)
            
        }
        
    }
    
    
    animateCorrectAnswerSubmitted(viewController, correctButton.tag, answerTag)
}



func animateCorrectAnswerSubmitted(viewController: UIViewController, correctTag: Int, senderTag: Int) {
    
    let buttonTags = [2001, 2002, 2003, 2004]
    var delayAmount: NSTimeInterval = 0.0

    for tag in buttonTags {
        
        if tag != correctTag {
            
            let button = viewController.view.viewWithTag(tag) as! UIButton
            let buttonYCoord = button.center.y
            
                delayAmount = delayAmount + 0.15
            
            delay(delayAmount, { () -> () in
                
                UIView.transitionWithView(button, duration: 0.20, options: nil, animations: { () -> Void in
                    
                    button.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    
                    }, completion: nil)
                
            })
                
            UIView.animateWithDuration(0.20, delay: delayAmount, options: nil, animations: { () -> Void in
                
                button.transform = CGAffineTransformMakeScale(0.75, 0.75)
                
            }, completion: { (Bool) -> Void in
                
                
                
            })
                
        }
        
    }
    
    delay(delayAmount, { () -> () in
      
        if senderTag == correctTag {
            
            let button = viewController.view.viewWithTag(senderTag) as! UIButton
            
            button.frame.size.width = viewController.view.frame.width
            button.center.x = viewController.view.center.x
            
            UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: { () -> Void in
                
                button.backgroundColor = highColor
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                
                }, completion: { (Bool) -> Void in
                    
                    
            })
            
        }
        
    })
    
}

