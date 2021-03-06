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


func orderingQuestion(viewController: UIViewController, masterView: UIView, label1: UILabel, label2: UILabel, label3: UILabel, label4: UILabel, completion: () -> Void) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAskKey) as! String
    var choices = question?.valueForKey(questionChoicesKey) as! [String]
    
    let questionLabel = UILabel()
    drawPercentageRectOffView(questionLabel, masterView: masterView, heightPercentage: 22, widthPercentage: 85)
    questionLabel.text = questionString
    questionLabel.textColor = UIColor.whiteColor()
    questionLabel.font = fontSmallerRegular
    questionLabel.numberOfLines = 0
    questionLabel.textAlignment = .Left
    questionLabel.adjustsFontSizeToFitWidth = true
    questionLabel.minimumScaleFactor = 0.8
    
    masterView.addSubview(questionLabel)
    
    questionLabel.frame.origin.x = centerXAlignment(questionLabel, masterView: masterView)
    questionLabel.frame.origin.y = percentYFromMasterFrame(questionLabel, masterView: masterView, percent: 3.52)
    
    var yOriginPercent = CGFloat()
    var yOffsetBetween = CGFloat()
    
    switch(choices.count) {
        
    case 3:
        
        yOriginPercent = 8.8
        yOffsetBetween = 15.8
        
    case 4:
        
        yOriginPercent = 5.8
        yOffsetBetween = 9.5
        
    case 5:
        
        yOriginPercent = 5.8
        yOffsetBetween = 7.21
        
    default:
        
        yOriginPercent = 5.8
        yOffsetBetween = 7.21
        
    }
    
    var labelArray = [label1, label2, label3, label4]
    
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    var count = 401
    
    for index in 0..<choices.count {
        
        let label = labelArray[index] as UILabel!
        
        var int = Int()
        int = Int(arc4random_uniform(UInt32(choices.count)))
        let labelText = choices.removeAtIndex(int)
        label.text = labelText
        
        
        label.textColor = yellowColor
        label.font = fontAdjuster(label.text!, fontS: fontSmallestRegular, fontM: fontSmallerRegular, fontL: fontMediumRegular)
        label.frame.size.width = (onePercentOfWidth * 70)
        label.numberOfLines = 3
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.baselineAdjustment = .AlignBaselines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.sizeToFit()
        label.frame.size.width = (onePercentOfWidth * 70)
        label.tag = count
        
        if count == 401 {
            
            label.frame.origin.y = percentYFromBottomOfView(label, viewToOffsetFrom: questionLabel, masterView: masterView, percent: yOriginPercent)
            
        } else if count != 401 {
            
            let previousLabel = masterView.viewWithTag(count - 1)
            
            label.frame.origin.y = percentYFromBottomOfView(label, viewToOffsetFrom: previousLabel!, masterView: masterView, percent: yOffsetBetween)
        }
        
        label.frame.origin.x = centerXAlignment(label, masterView: masterView) - (onePercentOfWidth * 7)
        
        masterView.addSubview(label)
        
        ++count
        
    }
    
    let scaleLineTopY = label1.frame.minY
    let scaleLineBottomY = label4.frame.maxY
    
    drawVerticalScaleLine(masterView, topYCoord: scaleLineTopY, bottomYCoord: scaleLineBottomY, xPositionPercent: 92, width: 1.0, color: lowColor, labelFontSize: fontTiny)
    
    let submitButton = UIButton()
    submitButton.tag = 4001
    submitButton.setTitle("go", forState: .Normal)
    submitButton.setTitleColor(yellowColor, forState: .Normal)
    submitButton.titleLabel?.textColor = yellowColor
    submitButton.titleLabel?.font = fontSmall
    submitButton.sizeToFit()
    submitButton.addTarget(viewController, action: Selector("checkQuestionSubmission:"), forControlEvents: .TouchUpInside)
    
    masterView.addSubview(submitButton)
    
    submitButton.frame.origin.x = centerXAlignment(submitButton, masterView: masterView)
    submitButton.frame.origin.y = masterView.frame.height * 0.90
    
    completion()
    
}


func touchesBeganForOrderingQuestion(masterView: UIView, inout draggedLabelCoordinates: CGPoint, inout draggedLabel: UILabel, touches: Set<NSObject>, labelArray: [UILabel]) {
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
        
        for label in labelArray {
            
            if label.frame.contains(location) {
                
                draggedLabel = label
                draggedLabelCoordinates = label.center
                
                label.center.y = location.y
                label.font = fontAdjuster(label.text!, fontS: fontSmallRegular, fontM: fontMediumRegular, fontL: fontLargeRegular)
                label.textColor = highestColor
                
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
    
    let draggedLabelTag = draggedLabel.tag
    
    if draggedLabelCoordinates == CGPoint(x: 0.0, y: 0.0) {
        
        return
        
    }
    
    var labelWithinBounds = false
    
    for touch in (touches as! Set<UITouch>) {
        let location = touch.locationInView(masterView)
                
        for label in labelArray {
            
            if label.tag != draggedLabel.tag && label.frame.contains(location) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                  
                    draggedLabel.center = label.center
                    
                    label.center = draggedLabelCoordinates
                    
                    draggedLabel.font = fontAdjuster(draggedLabel.text!, fontS: fontSmallestRegular, fontM: fontSmallerRegular, fontL: fontMediumRegular)
                    draggedLabel.textColor = yellowColor
                    
                })
                
                draggedLabel.tag = label.tag
                label.tag = draggedLabelTag
                
                labelWithinBounds = true
                
                
            } else if labelWithinBounds == false {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                                        
                    draggedLabel.center = draggedLabelCoordinates
                    
                    draggedLabel.font = fontAdjuster(draggedLabel.text!, fontS: fontSmallestRegular, fontM: fontSmallerRegular, fontL: fontMediumRegular)
                    draggedLabel.textColor = yellowColor
                })
                
            }
            
            
        }
        
        
    }
    
    
}



func drawVerticalScaleLine(masterView: UIView, topYCoord: CGFloat!, bottomYCoord: CGFloat!, xPositionPercent: CGFloat, width: CGFloat, color: UIColor, labelFontSize: UIFont) {
    
    let question = questionObjectFromGameBoardSend
    
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    
    print(topYCoord)
    
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
    topLabel.textColor = color
    topLabel.font = labelFontSize
    topLabel.sizeToFit()
    topLabel.frame.origin.y = lineView.frame.origin.y - (topLabel.frame.height)
    topLabel.frame.origin.x = lineView.center.x - (topLabel.frame.width * 0.75)
    masterView.addSubview(topLabel)
    
    let bottomLabel = UILabel()
    let bottomLabelText = question?.valueForKey(scaleLabelBottom) as! String
    bottomLabel.text = bottomLabelText
    bottomLabel.textColor = color
    bottomLabel.font = labelFontSize
    bottomLabel.sizeToFit()
    bottomLabel.frame.origin.y = lineView.frame.origin.y + lineView.frame.height
    bottomLabel.frame.origin.x = lineView.center.x - (bottomLabel.frame.width * 0.75)
    masterView.addSubview(bottomLabel)
    
    
}
    




