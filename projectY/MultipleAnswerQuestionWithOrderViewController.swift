//
//  MultipleAnswerQuestionWithOrderViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/25/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



class MultipleAnswerWithOrderViewController: UIViewController, UITextFieldDelegate {
    
    let firstColor = UIColor(hex: "8036FF")
    let secondColor = UIColor(hex: "00B2EA")
    let thirdColor = UIColor(hex: "E9D300")
    let fourthColor = UIColor(hex: "FF6000")
    let fifthColor = UIColor(hex: "F953FF")
    let sixthColor = UIColor(hex: "B22029")
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    var questionImageFile: UIImage?
    
    let type = questionObjectFromGameBoardSend?.valueForKey(questionType) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        multipleAnswerQuestionWithOrder(self, self, self.view) { (answerInputField) -> Void in
            
            
            
        }
        
    }
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
        if selectedSection == nil {
            
            textField.text = String("")
            textField.placeholder = "choose a circle"
            
            return false
            
        } else if selectedSection != nil {
            
            checkMultipleAnswerWithOrder(self, textField, selectedSection!) { (correct) -> Void in
                
                self.previousButton = nil
                self.selectedSection = nil
                ++self.submittedCount
                
                if self.submittedCount == self.answers.count {
                    
                    delay(1.0, { () -> () in
                        
                        textField.resignFirstResponder()
                        drawAnswerLabelsAfterFinalSubmit(self, textField)
                        
                    })
                    
                }
                
            }
            
        }
        
        return true
    }
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        println("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestionWithOrder(sender, self)
        
    }
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        println("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestionMultipleAnswerWithOrder(self, sender)
    }
    
    
    var previousButton : UIButton?
    var selectedSection : Int?
    
    func userChoseSectionToAnswer(sender: AnyObject?) {
        
        let textField = self.view.viewWithTag(9001) as! UITextField
        textField.enabled = true
        textField.placeholder = nil
        
        if previousButton != nil {
            
            previousButton?.transform = CGAffineTransformIdentity
            previousButton?.layer.borderWidth = 1.5
            
        }
        
        let sender = sender as! UIButton
        
        previousButton = sender
        selectedSection = sender.tag
        
        sender.transform = CGAffineTransformMakeScale(1.25, 1.25)
        sender.layer.borderWidth = 3.5
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
    
}