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
    
    var questionImageFile: UIImage?
    
    let type = questionObjectFromGameBoardSend?.valueForKey(questionType) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        multipleAnswerQuestionWithImage(self, self, self.view, textFieldTag: 9001, textFieldQuestionButtonTag: 9002, questionLabelTag: 901, dropDownAnswerLabelTag: 902, imageViewTag: 903, startingLightTag: 9111, callKeybardButtonTag: 9003) { (answerInputField) -> Void in
            
            answerInputField.becomeFirstResponder()
            
        }
        
    }
    
    
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        
        return true
    }
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        println("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestion(sender, self)
        
    }
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        println("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestion(self, sender, nil)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
    
}