//
//  MultipleChoiceViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/24/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



class MultipleChoiceViewController: UIViewController {
    
    
    var questionImageFile: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        let type = questionObjectFromGameBoardSend?.valueForKey(questionType) as! Int
        
        if type == 2 {
            
            multipleChoiceQuestion(self, sView: self.view, question: questionObjectFromGameBoardSend!, completion: { () -> Void in
                
                
                
            })
            
        } else if type == 3 {
            
            multipleChoiceQuestionWithImage(self, sView: self.view, question: questionObjectFromGameBoardSend!, questionImage: self.questionImageFile!, completion: { () -> Void in
                
                
                
            })
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    
    func checkQuestionSubmission(sender: AnyObject?) {
        
        let button = sender as! UIButton
        
        checkMultipleChoiceQuestion(self, senderTag: button.tag) { () -> () in
            
            
            
        }
        
    }
    
    
}