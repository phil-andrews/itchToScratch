//
//  MultipleAnswerWithImageViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/25/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



class MultipleAnswerWithImageViewController: UIViewController, UITextFieldDelegate {
    
    
    var questionImageFile: UIImage?
    
    let type = questionObjectFromGameBoardSend?.valueForKey(questionType) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor

        
            multipleAnswerQuestionWithImage(self, self, self.view, textFieldTag: 8001, textFieldQuestionButtonTag: 8002, questionLabelTag: 801, dropDownAnswerLabelTag: 802, imageViewTag: 803, startingLightTag: 8111, callKeybardButtonTag: 8003) { (answerInputField) -> Void in
    

    
        }
        
    }
    
    
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
            checkMultpleAnswerWithImageQuestion(self, textField, 802, 8111, &submittedCount, &unhiddenAnswerLabelTags) { () -> Void in
                
                
                
        }
        
        return true
    }
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        println("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestion(sender, self)
        
    }
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        println("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestion(self, sender, nil)

        
        let dropDownLabel = self.view.viewWithTag(802) as! UILabel
        let imageView = self.view.viewWithTag(803) as! UIImageView
        
        dropDownLabel.layer.removeAllAnimations()
        
        UIView.animateKeyframesWithDuration(0.10, delay: 0.0, options: nil, animations: { () -> Void in
            
            println("ran")
            
            dropDownLabel.frame.origin.y = imageView.frame.maxY - (dropDownLabel.frame.height * 1.25)
            
            }, completion: { (Bool) -> Void in
                
                
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
}