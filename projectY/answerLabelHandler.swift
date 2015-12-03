//
//  answerLabelHandler.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/21/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit




func animateAnswerLabelAnsweredCorrect(answerLabel: UILabel, color: UIColor, completion: () -> Void) {
    
    answerLabel.transform = CGAffineTransformMakeScale(0.0, 0.0)
    answerLabel.hidden = false
    answerLabel.backgroundColor = color
    answerLabel.font = fontSmallestMedium
    answerLabel.textColor = backgroundColor
    
    UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [], animations: { () -> Void in
        
        answerLabel.transform = CGAffineTransformIdentity

    }) { (Bool) -> Void in
        
        completion()
        
    }
    
}


func animateAnswerLabelsThatWereIncorrect(viewController: UIViewController, answerLabel: UILabel, bgColor: UIColor, textColor: UIColor, delayAmount: Double, completion: () -> Void) {
    
    answerLabel.center.x -= viewController.view.frame.width
    answerLabel.backgroundColor = bgColor
    answerLabel.textColor = textColor
    answerLabel.hidden = false
    
    UIView.animateWithDuration(0.25, delay: delayAmount, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: [], animations: { () -> Void in
        
        answerLabel.center.x += viewController.view.frame.width
        
    }) { (Bool) -> Void in
        
        
        
    }
    
    completion()
    
}
