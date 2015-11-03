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


func orderingQuestion(masterView: UIView, label1: UILabel, label2: UILabel, label3: UILabel, label4: UILabel, completion: () -> Void) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAsk) as! String
    var choices = question?.valueForKey(questionChoices) as! [String]
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
        label.font = fontMedium
        label.numberOfLines = 2
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.minimumScaleFactor = 0.7
        label.sizeToFit()
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, (onePercentOfWidth * 70), label.frame.height)
        label.textAlignment = .Left
        label.tag = count
        
        if count == 401 {
            
            label.frame.origin.y = percentYFromBottomOfView(label, questionLabel, masterView, yOriginPercent)
            
        } else if count != 401 {
            
            let previousLabel = masterView.viewWithTag(count - 1)
            
            label.frame.origin.y = percentYFromBottomOfView(label, previousLabel!, masterView, yOffsetBetween)
        }
        
        label.frame.origin.x = centerXAlignment(label, masterView) - (onePercentOfWidth * 7)
        
        masterView.addSubview(label)
        
        ++count
        
    }
    
    let scaleLineTopY = label1.frame.minY
    let scaleLineBottomY = label4.frame.maxY
    
    drawVerticalScaleLine(masterView, scaleLineTopY, scaleLineBottomY, 1.0, lowColor)
    
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
                label.font = fontMediumRegular
                
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
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                  
                    draggedLabel.center = label.center
                    
                    label.center = draggedLabelCoordinates
                    
                    draggedLabel.font = fontMedium
                    
                })
                
                labelWithinBounds = true
                
                
            } else if labelWithinBounds == false {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    draggedLabel.center = draggedLabelCoordinates
                    
                    draggedLabel.font = fontMedium

                })
                
            }
            
            
        }
        
        
    }
    
    
}



func drawVerticalScaleLine(masterView: UIView, topYCoord: CGFloat!, bottomYCoord: CGFloat!, width: CGFloat, color: UIColor) {
    
    let question = questionObjectFromGameBoardSend
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    println(topYCoord)
    
    let line = UIBezierPath()
    let lineXCoord = (onePercentOfWidth * 92)
    let lineStartPoint = CGPoint(x: lineXCoord, y: topYCoord)
    let lineEndPoint = CGPoint(x: lineXCoord, y: bottomYCoord)
    
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
    topLabel.font = fontTiny
    topLabel.sizeToFit()
    topLabel.frame.origin.y = lineView.frame.origin.y - (topLabel.frame.height)
    topLabel.frame.origin.x = lineView.center.x - (topLabel.frame.width * 0.75)
    masterView.addSubview(topLabel)
    
    let bottomLabel = UILabel()
    let bottomLabelText = question?.valueForKey(scaleLabelBottom) as! String
    bottomLabel.text = bottomLabelText
    bottomLabel.textColor = color
    bottomLabel.font = fontTiny
    bottomLabel.sizeToFit()
    bottomLabel.frame.origin.y = lineView.frame.origin.y + lineView.frame.height// + (bottomLabel.frame.height * 1.25)
    bottomLabel.frame.origin.x = lineView.center.x - (bottomLabel.frame.width * 0.75)
    masterView.addSubview(bottomLabel)
    
    
    
    
//    line.moveToPoint(lineStartPoint)
//    line.addLineToPoint(lineEndPoint)
//    line.closePath()
//    line.lineCapStyle = kCGLineCapRound
//    line.lineWidth = width * onePercentOfWidth
//    color.setStroke()
//    masterView.setNeedsDisplay()
//    line.stroke()
    
}
    
    
    
    


