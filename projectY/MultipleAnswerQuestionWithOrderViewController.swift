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
    
    let firstColor = UIColor(red: 45.0, green: 100.0, blue: 100.0, alpha: 1.0)
    let secondColor = UIColor(red: 45.0, green: 100.0, blue: 100.0, alpha: 1.0)
    let thirdColor = UIColor(red: 45.0, green: 100.0, blue: 100.0, alpha: 1.0)
    let fourthColor = UIColor(red: 45.0, green: 100.0, blue: 100.0, alpha: 1.0)
    let fifthColor = UIColor(red: 45.0, green: 100.0, blue: 100.0, alpha: 1.0)
    let sixthColor = UIColor(red: 45.0, green: 100.0, blue: 100.0, alpha: 1.0)
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [String]
    
    var questionImageFile: UIImage?
    
    let type = questionObjectFromGameBoardSend?.valueForKey(questionType) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        multipleAnswerQuestionWithOrder(self, textFieldDelegate: self, masterView: self.view) { (answerInputField) -> Void in
            
            
            
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
            
            checkMultipleAnswerWithOrder(self, answerInputField: textField, section: selectedSection!) { (correct) -> Void in
                
                self.previousButton = nil
                self.selectedSection = nil
                ++self.submittedCount
                
                if self.submittedCount == self.answers.count {
                    
                    delay(1.0, closure: { () -> () in
                        
                        textField.resignFirstResponder()
                        drawAnswerLabelsAfterFinalSubmit(self, answerInputField: textField)
                        
                    })
                    
                }
                
            }
            
        }
        
        return true
    }
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        print("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestionWithOrder(sender, viewController: self)
        
    }
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        print("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestionMultipleAnswerWithOrder(self, sender: sender)
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