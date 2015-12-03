//
//  MultipleAnswerViewController.swift
//  
//
//  Created by Philip Ondrejack on 11/24/15.
//
//

import UIKit
import Parse
import Foundation

class MultipleAnswerNoImageViewController: UIViewController, UITextFieldDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        multipleAnswerQuestionNoImage(self.view, textFieldDelegate: self, completion: { (answerInputField: UITextField) -> Void in
         
                answerInputField.becomeFirstResponder()
                
            })
        
    }
    
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        checkMultpleAnswerNoImageQuestion(self, answerInputField: textField, answerLabelStartTag: 702, submittedCount: &submittedCount, unhiddenAnswerLabelTags: &unhiddenAnswerLabelTags, completion: { () -> Void in
            
            
        })
        
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
}
