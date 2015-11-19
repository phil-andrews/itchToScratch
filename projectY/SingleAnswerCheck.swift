//
//  SingleAnswerCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/18/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse


func checkSingleAnswer(viewController: UIViewController, answerInputField: UITextField, completion: (Bool) -> Void) {
    
    let correctAnswers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let inputAnswer = answerInputField.text
    let containerView = viewController.view.viewWithTag(999)
    var complete = false
    
    for answer in correctAnswers {
        
        if answer == inputAnswer {
            
            let answerLabel = viewController.view.viewWithTag(102) as! UILabel
            let questionLabel = viewController.view.viewWithTag(101) as! UILabel
            
            answerLabel.transform = CGAffineTransformMakeScale(1.0, 0.00001)
            
            UIView.animateWithDuration(0.18, animations: { () -> Void in
                
                questionLabel.transform = CGAffineTransformMakeScale(1.25, 1.25)
                
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(0.18, animations: { () -> Void in
                    
                    questionLabel.transform = CGAffineTransformIdentity
                    answerLabel.hidden = false
                    answerLabel.transform = CGAffineTransformIdentity
                    
                }, completion: { (Bool) -> Void in
                    
                    complete = true
                    
                    // save object and user
                    
                    completion(true)
                    
                })
                
            })
            
        }
        
        
        // save user
        
        completion(false)
        
    }
    
    
    
}
