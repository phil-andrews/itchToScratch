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
        
        multipleAnswerQuestionNoImage(self.view, self, { (answerInputField: UITextField) -> Void in
         
                answerInputField.becomeFirstResponder()
                
            })
        
    }
    
    
    
    var submittedCount = 0
    var unhiddenAnswerLabelTags = [Int]()
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        checkMultpleAnswerNoImageQuestion(self, textField, 702, &submittedCount, &unhiddenAnswerLabelTags, { () -> Void in
            
            
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
