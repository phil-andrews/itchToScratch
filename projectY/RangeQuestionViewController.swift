//
//  RangeQuestionViewController.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/25/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit


class RangeQuestionViewController: UIViewController {
    
    @IBOutlet var swipeUpToGoBack: UISwipeGestureRecognizer!

    
    var rangeButtonViewOverlay = UIView()
    var rangeHorizontalBar = UIView()
    var rangeLabel = UILabel()
    let userArrow = UIImageView()
    let opponentArrow = UIImageView()
    let correctArrow = UIImageView()
    
    var verticalScaleLine = UIView()
    var previousRangeBarLocation = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        self.swipeUpToGoBack.enabled = false
        
        rangeQuestion(self, masterView: self.view, rangeButtonOverlay: rangeButtonViewOverlay, rangeBar: rangeHorizontalBar, rangeLabel: rangeLabel,userArrow: userArrow, correctArrow: correctArrow) { (verticalLine) -> Void in
            
            self.verticalScaleLine = verticalLine
            
        }
        
    }
    
    var userAnswer = Int()
    var userSubmitted = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if userSubmitted == false {
        
        touchesBeganForRangeQuestion(self.view, touches: touches, buttonOverlay: rangeButtonViewOverlay, horizontalRangeBar: rangeHorizontalBar, previousRangeBarLocation: &previousRangeBarLocation)
            
        }
        
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if userSubmitted == false {
            
        touchesMovedForRangeQuestion(self.view, touches: touches, buttonOverlay: rangeButtonViewOverlay, rangeBarHandle: rangeHorizontalBar, rangeLabel: rangeLabel, userArrow: userArrow, userAnswer: &userAnswer, verticalScaleLine: verticalScaleLine, previousRangeBarLocation: &previousRangeBarLocation)
            
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    
    func checkQuestionSubmission(sender: AnyObject?) {
        
        print("answer submitted")
        
        if let sender = sender as? UIButton {
            
            sender.hidden = true
            
        }
        
        self.userSubmitted = true
        
        let opponentAnswerArray = currentLocationObject?.valueForKey(opponentsQuestionsAnswered) as! NSArray
        
        animateComponentsToCenterX(self, userAnswer: userAnswer, verticalScaleLine: verticalScaleLine, rangeHorizontalBar: rangeHorizontalBar, rangeLabel: rangeLabel, correctArrow: correctArrow, userArrow: userArrow, opponentArrow: opponentArrow) { () -> () in
           
            
            if opponentAnswerArray.count != 0 {
                
                animateOpponentArrowAndLabel(self, userAnswer: self.userAnswer, verticalScaleLine: self.verticalScaleLine, rangeHorizontalBar: self.rangeHorizontalBar, rangeLabel: self.rangeLabel, correctArrow: self.correctArrow, userArrow: self.userArrow, opponentArrow: self.opponentArrow, completion: { () -> () in
                
                    compareAnswersAgainstEachOtherAndActual(self, userAnswer: self.userAnswer, verticalScaleLine: self.verticalScaleLine, rangeHorizontalBar: self.rangeHorizontalBar, rangeLabel: self.rangeLabel, correctArrow: self.correctArrow, userArrow: self.userArrow, opponentArrow: self.opponentArrow, completion: { () -> () in
                        
                        
                        
                    })
                    
                    
                })
                
            }
            
            
            
            
        }
        
        
        self.swipeUpToGoBack.enabled = true
        
    }
    
        
        
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
}


