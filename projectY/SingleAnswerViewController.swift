//
//  SingleAnswerNoImageViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/24/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse

class SingleAnswerViewController: UIViewController, UITextFieldDelegate {
    
    var questionImageFile: UIImage?
    
    let type = questionObjectFromGameBoardSend?.valueForKey(questionType) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.view.backgroundColor = backgroundColor
        
        if type == 1 {
        
            singleAnswerQuestion(self.view, self) { (answerInputField) -> Void in
                
            }
        } else if type == 6 {
            
            singleAnswerQuestionWithImage(self, self.view, self, { (answerInputField) -> Void in
                
                
                
            })
            
            
        }
            
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
      
        if type == 1 {
            
        checkSingleAnswer(self, textField) { (correct) -> Void in

            
            }
            
        } else if type == 6 {
            
            checkSingleAnswerWithImage(self, textField, { (correct) -> Void in
                
                
                
            })
            
        }
        return true
        
    }
    

    
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
}