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

        
            multipleAnswerQuestionWithImage(self, textFieldDelegate: self, masterView: self.view, textFieldTag: 8001, textFieldQuestionButtonTag: 8002, questionLabelTag: 801, dropDownAnswerLabelTag: 802, imageViewTag: 803, startingLightTag: 8111, callKeybardButtonTag: 8003) { (answerInputField) -> Void in
    

    
        }
        
    }
    
    
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
            checkMultpleAnswerWithImageQuestion(self, answerInputField: textField, dropDownLabelTag: 802, indicatorLightStartingTag: 8111, submittedCount: &submittedCount, unhiddenAnswerLabelTags: &unhiddenAnswerLabelTags) { () -> Void in
                
                
                
        }
        
        return true
    }
    
    
    func makeTextFieldFirstResponder(sender: AnyObject?) {
        
        print("called keyboard")
        
        makeTextFieldFirstResponderForImageQuestion(sender, viewController: self)
        
        let screenSize = self.view.frame.height
        
        if screenSize > 650 {
            
            for tag in unhiddenAnswerLabelTags {
                
                let label = self.view.viewWithTag(tag) as! UILabel
                
                UIView.animateWithDuration(0.15, delay: 0.0, options: [], animations: { () -> Void in
                    
                    label.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        label.hidden = true
                        
                })
                
            }

        }
        
    }
    
    
    func dismissKeyboardShowQuestion(sender: AnyObject?) {
        
        print("dismissed keyboard")
        
        removeTextFieldFromFirstResponderToShowQuestion(self, sender: sender, codeTag: nil)

        
        let dropDownLabel = self.view.viewWithTag(802) as! UILabel
        let imageView = self.view.viewWithTag(803) as! UIImageView
        
        dropDownLabel.layer.removeAllAnimations()
        
        UIView.animateKeyframesWithDuration(0.10, delay: 0.0, options: [], animations: { () -> Void in
            
            print("ran")
            
            dropDownLabel.frame.origin.y = imageView.frame.maxY - (dropDownLabel.frame.height * 1.25)
            
            }, completion: { (Bool) -> Void in
                
                
        })
        
        let screenSize = self.view.frame.height
        
        if screenSize > 650 {
        
            for tag in unhiddenAnswerLabelTags {
                
                let label = self.view.viewWithTag(tag) as! UILabel
                label.alpha = 0.0
                
                UIView.animateWithDuration(0.15, delay: 0.15, options: [], animations: { () -> Void in
                    
                    label.hidden = false
                    label.alpha = 1.0
                    
                }, completion: { (Bool) -> Void in
                    
                    
                    
                })
                
            }
        
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
}