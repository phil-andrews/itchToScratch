//
//  OrderQuestionViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/25/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse


class OrderingQuestionViewController: UIViewController {
    
    @IBOutlet var swipeUpToGoBack: UISwipeGestureRecognizer!
    
    var orderingQuestionLabel1 = UILabel()
    var orderingQuestionLabel2 = UILabel()
    var orderingQuestionLabel3 = UILabel()
    var orderingQuestionLabel4 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        swipeUpToGoBack.enabled = false
        orderingQuestion(self, self.view, orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4) { () -> Void in
            
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    var typeForHandler = Int()
    var labelThatIsBeingDraggedOrigin = CGPoint()
    var labelThatIsBeingDragged = UILabel()
    

    
    var answerSubmitted = false
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if answerSubmitted == true {
            
            return
        }
        
        let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
        
        touchesBeganForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
        
        
    }
    
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if answerSubmitted == true {
            
            return
        }
        
        touchesMovedForOrderingQuestion(self.view, &labelThatIsBeingDragged, touches)
        
        
    }
    
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if answerSubmitted == true {
            
            return
        }
        
        let orderLabelArray = [orderingQuestionLabel1, orderingQuestionLabel2, orderingQuestionLabel3, orderingQuestionLabel4]
        
        touchesEndedForOrderingQuestion(self.view, &labelThatIsBeingDraggedOrigin, &labelThatIsBeingDragged, touches, orderLabelArray)
        
        
    }
    
    
    func checkQuestionSubmission(sender: AnyObject?) {
    
        self.answerSubmitted = true
        
        checkOrderingQuestion(self, { () -> Void in
            
            self.swipeUpToGoBack.enabled = true
            
        })
    
    }
    
    
}