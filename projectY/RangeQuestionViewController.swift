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
    
    var verticalScaleLine = UIView()
    var previousRangeBarLocation = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        rangeQuestion(self.view, rangeButtonViewOverlay, rangeHorizontalBar, rangeLabel) { (verticalLine) -> Void in
            
            self.verticalScaleLine = verticalLine
            
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        touchesBeganForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, &previousRangeBarLocation)

        
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        touchesMovedForRangeQuestion(self.view, touches, rangeButtonViewOverlay, rangeHorizontalBar, rangeLabel, verticalScaleLine, &previousRangeBarLocation)
        
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    
    func checkQuestionSubmission(sender: AnyObject?) {
        
        
        
    }
    
        
        
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
}


