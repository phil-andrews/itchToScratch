//
//  TouchHandlersForRangeQuestion.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/27/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse




func touchesBeganForRangeQuestion(masterView: UIView, touches: Set<NSObject>, buttonOverlay: UIView, horizontalRangeBar: UIView, inout previousRangeBarLocation: CGPoint) {
    
    let handle: UIView = buttonOverlay
    
    for touch in (touches as! Set<UITouch>) {
        
        let location = touch.locationInView(masterView)
        
        if handle.frame.contains(location) == true {
            
            let previousRangeBarLocation = horizontalRangeBar.center
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                handle.layer.borderWidth = (masterView.frame.size.width * 0.035)
                handle.backgroundColor = yellowColor
                handle.transform = CGAffineTransformMakeScale(1.25, 1.25)
                
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        
                        handle.layer.borderWidth = (masterView.frame.size.width * 0.015)
                        handle.transform = CGAffineTransformIdentity
                        handle.backgroundColor = backgroundColor
                        
                        }, completion: { (Bool) -> Void in
                            
                            
                            
                    })
                    
            })
            
        }
        
    }
    
}


func touchesMovedForRangeQuestion(masterView: UIView, touches: Set<NSObject>, buttonOverlay: UIView, rangeBarHandle: UIView, rangeLabel: UILabel, userArrow: UIImageView, inout userAnswer: Int, verticalScaleLine: UIView, inout previousRangeBarLocation: CGPoint) {
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
        
        if buttonOverlay.frame.contains(location) {
            
            let upperScaleLimit = verticalScaleLine.frame.minY
            let lowerScaleLimit = verticalScaleLine.frame.maxY
            
            rangeBarHandle.center.y = location.y
            userArrow.center.y = rangeBarHandle.center.y
            buttonOverlay.center.y = rangeBarHandle.center.y
            rangeLabel.frame.origin.y = rangeBarHandle.frame.minY - rangeLabel.frame.height
            
            
            if location.y <= upperScaleLimit {
                
                rangeBarHandle.center.y = upperScaleLimit
                userArrow.center.y = rangeBarHandle.center.y
                buttonOverlay.center.y = rangeBarHandle.center.y
                rangeLabel.frame.origin.y = rangeBarHandle.frame.minY - rangeLabel.frame.height
                
                
            }
            
            if location.y >= lowerScaleLimit {
                
                rangeBarHandle.center.y = lowerScaleLimit
                userArrow.center.y = rangeBarHandle.center.y
                buttonOverlay.center.y = rangeBarHandle.center.y
                rangeLabel.frame.origin.y = rangeBarHandle.frame.minY - (rangeLabel.frame.height)
                
                
            }
            
            changeRangeLabelTextForTouchesMoved(masterView, touch, rangeBarHandle, verticalScaleLine, rangeLabel, &userAnswer, &previousRangeBarLocation)
            
        }
        
    }
    
}



func changeRangeLabelTextForTouchesMoved(masterView: UIView, touch: UITouch, rangeHorizontalBar: UIView, rangeVerticalScaleLine: UIView, rangeLabel: UILabel, inout userAnswer: Int, inout previousRangeBarLocation: CGPoint) {
    
    let rangeTopString = questionObjectFromGameBoardSend?.valueForKey(scaleLabelTop) as! String
    let rangeBottomString = questionObjectFromGameBoardSend?.valueForKey(scaleLabelBottom) as! String
    
    let rangeTopRegex = listMatches("\\d+", inString: rangeTopString)
    let rangeTopInt = rangeTopRegex[0].toInt()
    
    let rangeBottomRegex = listMatches("\\d+", inString: rangeBottomString)
    let rangeBottomInt = rangeBottomRegex[0].toInt()
    
    let rangeStartPoint = rangeVerticalScaleLine.frame.maxY
    let rangeEndPoint = rangeVerticalScaleLine.frame.minY
    let yRange = rangeEndPoint - rangeStartPoint
    
    let location = rangeHorizontalBar.center.y
    
    let percent = ((location - rangeStartPoint) / (yRange)) * 100
    let finalNumber = (Double(percent * 0.01) * (Double(rangeTopInt!) - Double(rangeBottomInt!))) + Double(rangeBottomInt!)
    let labelText = Int(finalNumber)
    userAnswer = labelText
    
    rangeLabel.text = String(labelText)
    
    previousRangeBarLocation = rangeHorizontalBar.center
    
    
}



