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
        
        rangeQuestion(self, self.view, rangeButtonViewOverlay, rangeHorizontalBar, rangeLabel,userArrow, correctArrow) { (verticalLine) -> Void in
            
            self.verticalScaleLine = verticalLine
            
        }
        
    }
    
    var userAnswer = Int()
    var userSubmitted = false
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if userSubmitted == false {
        
        touchesBeganForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, &previousRangeBarLocation)
            
        }
        
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if userSubmitted == false {
            
        touchesMovedForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, rangeLabel, userArrow, &userAnswer, verticalScaleLine, &previousRangeBarLocation)
            
        }
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    
    func checkQuestionSubmission(sender: AnyObject?) {
        
        println("answer submitted")
        
        if let sender = sender as? UIButton {
            
            sender.hidden = true
            
        }
        
        self.userSubmitted = true
        
        animateComponentsToCenterX(self, userAnswer, verticalScaleLine, rangeHorizontalBar, rangeLabel, correctArrow, userArrow, opponentArrow) { () -> () in
            
            animateOpponentArrowAndLabel(self, self.userAnswer, self.verticalScaleLine, self.rangeHorizontalBar, self.rangeLabel, self.correctArrow, self.userArrow, self.opponentArrow, { () -> () in
                
                compareAnswersAgainstEachOtherAndActual(self, self.userAnswer, self.verticalScaleLine, self.rangeHorizontalBar, self.rangeLabel, self.correctArrow, self.userArrow, self.opponentArrow, { () -> () in
                    
                    
                    
                })
                
                
            })
            
            
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


