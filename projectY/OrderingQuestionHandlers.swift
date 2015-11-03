//
//  OrderingQuestionHandlers.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/2/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



func touchesBeganForOrderingQuestion(masterView: UIView, inout draggedLabelCoordinates: CGPoint, inout draggedLabel: UILabel, touches: Set<NSObject>, labelArray: [UILabel]) {
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
        
        for label in labelArray {
            
            if label.frame.contains(location) {
                
                draggedLabel = label
                draggedLabelCoordinates = label.center
                
                label.center.y = location.y
                
                break
                
            }
            
        }
    
    }
    
}



func touchesMovedForOrderingQuestion(masterView: UIView, inout draggedLabel: UILabel, touches: Set<NSObject>) {
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
        
        draggedLabel.center.y = location.y
        
    }
    
}



func touchesEndedForOrderingQuestion(masterView: UIView, inout draggedLabelCoordinates: CGPoint, inout draggedLabel: UILabel, touches: Set<NSObject>, labelArray: [UILabel]) {
    
    var labelWithinBounds = false
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
        
        for label in labelArray {
            
            if label.tag != draggedLabel.tag && label.frame.contains(location) {
                
                draggedLabel.center = label.center
                
                label.center = draggedLabelCoordinates
                
                labelWithinBounds = true
                
                
            } else if labelWithinBounds == false {
                
                draggedLabel.center = draggedLabelCoordinates
                
            }
            
            
        }
        
        
    }
    
    
}

