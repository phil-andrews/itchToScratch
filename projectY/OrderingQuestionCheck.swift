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
    let containerView = viewController.view.viewWithTag(999)
    var labelTag = 401
    
    for index in 0..<correctAnswers.count {
        
        let answer = correctAnswers[index]
        let answerLabel = viewController.view.viewWithTag(labelTag) as! UILabel
        
        if answerLabel.text == answer {
            
            animateAnswerLabelCorrect(answerLabel)
            
            ++labelTag
            
            continue
            
        } else if answerLabel.text != answer {
            
            answerLabel.textColor = UIColor.redColor()
            
        }
        
        
    }
    
}



func animateAnswerLabelCorrect(label: UILabel) {
    
    UIView.animateWithDuration(0.2, animations: { () -> Void in
        
        label.transform = CGAffineTransformMakeScale(1.25, 1.25)
        
    }) { (Bool) -> Void in
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            label.transform = CGAffineTransformIdentity
            
        }, completion: { (Bool) -> Void in
        
            
        })
        
    }
    
    
}

