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
    
    for answer in correctAnswers {
        
        if answer == inputAnswer {
            
            let answerLabel = viewController.view.viewWithTag(102) as! UILabel
            
            answerLabel.frame.origin.y = answerLabel.frame.origin.y - answerLabel.frame.height * 1.25
            answerLabel.backgroundColor = highColor
            answerLabel.textColor = backgroundColor
            
                UIView.animateWithDuration(0.18, animations: { () -> Void in
                    
                    answerLabel.hidden = false
                    answerLabel.frame.origin.y = answerLabel.frame.origin.y + answerLabel.frame.height * 1.25

                    
                }, completion: { (Bool) -> Void in
                    
                    // save object and user
                    
                    completion(true)
                    
                })
            
        }
        
        
        // save user
        
        completion(false)
        
    }
    
}


func checkSingleAnswerWithImage(viewController: UIViewController, answerInputField: UITextField, completion: (Bool) -> Void) {
    
    answerInputField.resignFirstResponder()
    
    let correctAnswers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let inputAnswer = answerInputField.text
    
    for answer in correctAnswers {
        
        if answer == inputAnswer {
            
            let answerLabel = viewController.view.viewWithTag(102) as! UILabel
            let questionLabel = viewController.view.viewWithTag(101) as! UILabel
            let textField = viewController.view.viewWithTag(1001) as! UITextField
            
            answerLabel.frame.origin.y = answerLabel.frame.origin.y - answerLabel.frame.height * 1.25
            answerLabel.backgroundColor = highColor
            answerLabel.textColor = backgroundColor
            
            UIView.animateWithDuration(0.18, animations: { () -> Void in
                
                textField.hidden = true
                answerLabel.hidden = false
                questionLabel.frame.origin.y = questionLabel.frame.origin.y + (answerLabel.frame.height * 1.75)
                answerLabel.frame.origin.y = answerLabel.frame.origin.y + answerLabel.frame.height * 1.25
                
                
                }, completion: { (Bool) -> Void in
                                        
                    // save object and user
                    
                    completion(true)
                    
            })
            
        }
        
        
        // save user
        
        completion(false)
        
    }
    
    
}


