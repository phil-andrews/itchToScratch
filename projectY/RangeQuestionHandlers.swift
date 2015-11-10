//
//  RangeQuestionHandlers.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/5/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse


func rangeQuestion(masterView: UIView, rangeButtonOverlay: UIView, rangeBar: UIView, completion: (UIView) -> Void) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAsk) as! String
    let answers = question?.valueForKey(questionAnswers) as! [String]
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView, 22, 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmaller
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView)
    questionLabel.frame.origin.y = percentYFromMasterFrame(questionLabel, masterView, 3.52)
    
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let masterHeight = masterView.frame.height
    let onePercentOfHeight = masterHeight/100
    
    let scaleLabelTopY = questionLabel.frame.maxY + (onePercentOfHeight * 8.8)
    let scaleLabelBottomY = (masterView.frame.height) - (onePercentOfHeight * 10)
    
    drawVerticalScaleLineForRangeQuestion(masterView, scaleLabelTopY, scaleLabelBottomY, 85, 7.0, lowColor, fontSmaller) { (verticalLine: UIView) -> Void in
        
        drawHorizontalDragBar(masterView, verticalLine, lowColor, rangeButtonOverlay, rangeBar)
        
        completion(verticalLine)
        
    }
    
    
}



func drawVerticalScaleLineForRangeQuestion(masterView: UIView, topYCoord: CGFloat!, bottomYCoord: CGFloat!, xPositionPercent: CGFloat, width: CGFloat, color: UIColor, labelFontSize: UIFont, completion: (UIView) -> Void) {
    
    let question = questionObjectFromGameBoardSend
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    println(topYCoord)
    
    let lineXCoord = (onePercentOfWidth * xPositionPercent)
    
    let lineHeight = topYCoord - bottomYCoord
    
    let lineView = UIView()
    lineView.frame = CGRectMake(lineXCoord, bottomYCoord, width, lineHeight)
    lineView.backgroundColor = color
    lineView.layer.cornerRadius = 2.0
    masterView.addSubview(lineView)
    
    
    let topLabel = UILabel()
    let topLabelText = question?.valueForKey(scaleLabelTop) as! String
    topLabel.text = topLabelText
    topLabel.textColor = lightColoredFont
    topLabel.font = labelFontSize
    topLabel.sizeToFit()
    topLabel.frame.origin.y = lineView.frame.origin.y - (topLabel.frame.height * 1.15)
    topLabel.frame.origin.x = lineView.center.x - (topLabel.frame.width/2)
    masterView.addSubview(topLabel)
    
    let bottomLabel = UILabel()
    let bottomLabelText = question?.valueForKey(scaleLabelBottom) as! String
    bottomLabel.text = bottomLabelText
    bottomLabel.textColor = lightColoredFont
    bottomLabel.font = labelFontSize
    bottomLabel.sizeToFit()
    bottomLabel.frame.origin.y = lineView.frame.maxY + (bottomLabel.frame.height * 0.15)
    bottomLabel.frame.origin.x = lineView.center.x - (bottomLabel.frame.width/2)
    masterView.addSubview(bottomLabel)
    
    completion(lineView)
    
}



func drawHorizontalDragBar(masterView: UIView, scaleBarLine: UIView, color: UIColor, rangeHandle: UIView, rangeHandleBar: UIView) {
    
    rangeHandleBar.layer.cornerRadius = 1.0
    rangeHandleBar.backgroundColor = color
    drawSquareRectOffView(rangeHandleBar, masterView, 1.5, 30)
    rangeHandleBar.frame.size.height = scaleBarLine.frame.size.width
    rangeHandleBar.tag = 501
    
    println(rangeHandleBar)
    
    masterView.addSubview(rangeHandleBar)
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    let dragBarX = scaleBarLine.center.x - rangeHandleBar.frame.width
    let dragBarY = scaleBarLine.frame.maxY - (rangeHandleBar.frame.height)
    rangeHandleBar.frame.origin = CGPoint(x: dragBarX, y: dragBarY)
    
    drawSquareRectOffView(rangeHandle, masterView, 8, 8)
    rangeHandle.layer.borderWidth = (masterWidth * 0.015)
    rangeHandle.layer.borderColor = yellowColor.CGColor
    rangeHandle.layer.cornerRadius = rangeHandle.frame.size.height/2
    rangeHandle.tag = 502
    rangeHandle.userInteractionEnabled = true
    
    masterView.addSubview(rangeHandle)
    
    rangeHandle.center.y = rangeHandleBar.center.y
    rangeHandle.center.x = rangeHandleBar.frame.minX - (rangeHandle.frame.size.width/2.03)
    
}



func touchesBeganForRangeQuestion(masterView: UIView, touches: Set<NSObject>, buttonOverlay: UIView) {
    
    let handle: UIView = buttonOverlay
    
    for touch in (touches as! Set<UITouch>) {
        
        println("touches")
        
        let location = touch.locationInView(masterView)
        
            if handle.frame.contains(location) == true {
                
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


func touchesMovedForRangeQuestion(masterView: UIView, touches: Set<NSObject>, buttonOverlay: UIView, rangeBarHandle: UIView, verticalScaleLine: UIView) {
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
        
        let upperScaleLimit = verticalScaleLine.frame.minY + (rangeBarHandle.frame.size.height/2)
        let lowerScaleLimit = verticalScaleLine.frame.maxY - (rangeBarHandle.frame.size.height/2)
        
        rangeBarHandle.center.y = location.y
        buttonOverlay.center.y = rangeBarHandle.center.y
        
        if location.y <= upperScaleLimit {
            
            rangeBarHandle.center.y = upperScaleLimit
            buttonOverlay.center.y = rangeBarHandle.center.y
            
        }
        
        if location.y >= lowerScaleLimit {
            
            rangeBarHandle.center.y = lowerScaleLimit
            buttonOverlay.center.y = rangeBarHandle.center.y
            
        }
        
        
        
    }
    
}




