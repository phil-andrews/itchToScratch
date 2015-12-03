//
//  MultipleAnswerWithOrderCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/28/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit


func checkMultipleAnswerWithOrder(viewController: UIViewController, answerInputField: UITextField, section: Int, completion: (Bool) -> Void) {
    
    print("ran")
    
    let sectionButton = viewController.view.viewWithTag(section) as! UIButton
    sectionButton.enabled = false
    let dropDownLabel = viewController.view.viewWithTag(904) as! UILabel
    dropDownLabel.layer.removeAllAnimations()
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    let answerPossibilities = questionObjectFromGameBoardSend?.valueForKey("qAnswers\(section)") as! [String]
    
    let userAnswer = answerInputField.text!.lowercaseString
    
    print(answerPossibilities)
    print(userAnswer)
    
    var userAnsweredCorrect = false
    
    for item in answerPossibilities {
        
        if userAnswer == item.lowercaseString {
            
            sectionButton.transform = CGAffineTransformIdentity
            //sectionButton.transform = CGAffineTransformMakeScale(0.80, 0.80)
            sectionButton.layer.borderWidth = 5.0
            sectionButton.backgroundColor = highestColor
            
            let dropDownLabelOriginX = dropDownLabel.frame.origin.x
            
            dropDownLabel.backgroundColor = backgroundColor
            dropDownLabel.textColor = highColor
            dropDownLabel.text = answers[section - 1]
            dropDownLabel.frame.origin.x -= viewController.view.frame.width
            dropDownLabel.hidden = false
            
            answerInputField.text = ""
            
            UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
                
                dropDownLabel.frame.origin.x += viewController.view.frame.width
                
                
                }, completion: { (Bool) -> Void in
                    
                    delay(2.0, closure: { () -> () in
                        
                        UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: [], animations: { () -> Void in
                            
                            dropDownLabel.frame.origin.x += viewController.view.frame.width
                            
                            }, completion: { (Bool) -> Void in
                                
                                dropDownLabel.hidden = true
                                dropDownLabel.frame.origin.x = dropDownLabelOriginX

                        })
                        
                    })
                    
            })
            
            
            userAnsweredCorrect = true
            
        }
        
        if userAnsweredCorrect == true {
            
            break
            
        }
        
    }
    
    if userAnsweredCorrect == false {
        
        sectionButton.transform = CGAffineTransformIdentity
        sectionButton.transform = CGAffineTransformMakeScale(0.80, 0.80)
        sectionButton.layer.borderWidth = 3.0
        sectionButton.backgroundColor = UIColor.blackColor()
        
        let dropDownLabelOriginX = dropDownLabel.frame.origin.x
        
        dropDownLabel.backgroundColor = backgroundColor
        dropDownLabel.textColor = UIColor.whiteColor()
        dropDownLabel.text = answers[section - 1]
        dropDownLabel.frame.origin.x += viewController.view.frame.width
        dropDownLabel.hidden = false
        
        answerInputField.text = ""
        
        UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
            
            dropDownLabel.frame.origin.x -= viewController.view.frame.width
            
            
            }, completion: { (Bool) -> Void in
                
                delay(2.0, closure: { () -> () in
                    
                    UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: [], animations: { () -> Void in
                        
                        dropDownLabel.frame.origin.x -= viewController.view.frame.width
                        
                        }, completion: { (Bool) -> Void in
                            
                            dropDownLabel.hidden = true
                            dropDownLabel.frame.origin.x = dropDownLabelOriginX
                            
                    })
                    
                })
                
        })

    }

    completion(userAnsweredCorrect)

}


func drawAnswerLabelsAfterFinalSubmit(viewController: UIViewController, answerInputField: UITextField) {
    
    UIView.animateWithDuration(0.20, animations: { () -> Void in
        
        answerInputField.frame.origin.x += viewController.view.frame.width
        
    })
    
    let firstColor = UIColor(red: 34.0, green: 56.0, blue: 200.0, alpha: 1.0)
    let secondColor = UIColor(red: 34.0, green: 56.0, blue: 200.0, alpha: 1.0)
    let thirdColor = UIColor(red: 34.0, green: 56.0, blue: 200.0, alpha: 1.0)
    let fourthColor = UIColor(red: 34.0, green: 56.0, blue: 200.0, alpha: 1.0)
    let fifthColor = UIColor(red: 34.0, green: 56.0, blue: 200.0, alpha: 1.0)
    let sixthColor = UIColor(red: 34.0, green: 56.0, blue: 200.0, alpha: 1.0)
    
    let colorArray = [firstColor, secondColor, thirdColor, fourthColor, fifthColor, sixthColor]
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    var labelYCoord = answerInputField.center.y
    var duration = 0.15
    
    for index in 0..<answers.count {
        
        let label = PaddedLabel15()
        label.hidden = true
        label.text = answers[index]
        label.textAlignment = .Center
        label.backgroundColor = backgroundColor
        label.textColor = colorArray[index]
        label.font = fontSmallRegular
        label.frame.size.height = viewController.view.frame.height * 0.0640
        label.frame.size.width = viewController.view.frame.width
        viewController.view.addSubview(label)
        
        label.frame.origin.y = labelYCoord
        
        label.frame.origin.x -= viewController.view.frame.width
        label.hidden = false
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            label.frame.origin.x += viewController.view.frame.width
            
        })
        
        duration = duration + 0.15
        labelYCoord = labelYCoord + label.frame.height + 5.0
        
    }
    
}
