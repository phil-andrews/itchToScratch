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


func rangeQuestion(viewController: UIViewController, masterView: UIView, rangeButtonOverlay: UIView, rangeBar: UIView, rangeLabel: UILabel, userArrow: UIImageView, correctArrow: UIImageView, completion: (UIView) -> Void) {
    
    let question = questionObjectFromGameBoardSend
    let questionString = question?.valueForKey(questionAskKey) as! String
    let answers = question?.valueForKey(questionAnswersKey) as! [Int]
    
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
    
    let submitButton = UIButton()
    submitButton.setTitle("go", forState: .Normal)
    submitButton.titleLabel?.font = fontMedium
    submitButton.titleLabel?.textColor = highestColor
    submitButton.sizeToFit()
    submitButton.addTarget(viewController, action: Selector("checkQuestionSubmission:"), forControlEvents: .TouchUpInside)
    masterView.addSubview(submitButton)
    
    submitButton.frame.origin.y = masterView.frame.height * 0.90
    submitButton.frame.origin.x = centerXAlignment(submitButton, masterView)
    
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let masterHeight = masterView.frame.height
    let onePercentOfHeight = masterHeight/100
    
    let scaleLabelTopY = questionLabel.frame.maxY + (onePercentOfHeight * 8.8)
    let scaleLabelBottomY = (masterView.frame.height) - (onePercentOfHeight * 10)
    
    drawVerticalScaleLineForRangeQuestion(masterView, scaleLabelTopY, scaleLabelBottomY, 85, 12.0, lowColor, fontSmaller) { (verticalLine: UIView) -> Void in
        
        drawHorizontalDragBar(masterView, verticalLine, lowColor, rangeButtonOverlay, rangeBar, rangeLabel, userArrow, { () -> Void in
          
            drawRangeLabel(masterView, rangeBar, verticalLine, rangeLabel)
            
            let answer = answers[0]
            
            drawArrowLabel(masterView, verticalLine, correctArrow, answer)
            
            completion(verticalLine)

        })

        
    }
    
    
}



func drawVerticalScaleLineForRangeQuestion(masterView: UIView, topYCoord: CGFloat!, bottomYCoord: CGFloat!, xPositionPercent: CGFloat, width: CGFloat, color: UIColor, labelFontSize: UIFont, completion: (UIView) -> Void) {
    
    let question = questionObjectFromGameBoardSend
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    let lineXCoord = (onePercentOfWidth * xPositionPercent)
    
    let lineHeight = topYCoord - bottomYCoord
    
    let lineView = UIView()
    lineView.frame = CGRectMake(lineXCoord, bottomYCoord, width, lineHeight)
    lineView.backgroundColor = color
    masterView.addSubview(lineView)
    
    let topLabel = UILabel()
    let topLabelText = question?.valueForKey(scaleLabelTop) as! String
    topLabel.text = topLabelText
    topLabel.textColor = lightColoredFont
    topLabel.font = labelFontSize
    topLabel.sizeToFit()
    topLabel.frame.origin.y = lineView.frame.origin.y - (topLabel.frame.height * 1.25)
    topLabel.frame.origin.x = lineView.center.x - (topLabel.frame.width/2)
    masterView.addSubview(topLabel)
    topLabel.tag = 101
    
    let bottomLabel = UILabel()
    let bottomLabelText = question?.valueForKey(scaleLabelBottom) as! String
    bottomLabel.text = bottomLabelText
    bottomLabel.textColor = lightColoredFont
    bottomLabel.font = labelFontSize
    bottomLabel.sizeToFit()
    bottomLabel.frame.origin.y = lineView.frame.maxY + (bottomLabel.frame.height * 0.25)
    bottomLabel.frame.origin.x = lineView.center.x - (bottomLabel.frame.width/2)
    masterView.addSubview(bottomLabel)
    bottomLabel.tag = 102
    
    completion(lineView)
    
}



func drawHorizontalDragBar(masterView: UIView, scaleBarLine: UIView, color: UIColor, rangeHandle: UIView, rangeHandleBar: UIView, rangeLabel: UILabel, userArrow: UIImageView, completion: () -> Void) {
    
    rangeHandleBar.layer.cornerRadius = 1.0
    rangeHandleBar.backgroundColor = color
    drawSquareRectOffView(rangeHandleBar, masterView, 2.0, 30)
    rangeHandleBar.frame.size.height = 3.0
    masterView.addSubview(rangeHandleBar)
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    let dragBarX = scaleBarLine.frame.maxX - rangeHandleBar.frame.width
    let dragBarY = scaleBarLine.frame.maxY - rangeHandleBar.frame.size.height
    rangeHandleBar.frame.origin = CGPoint(x: dragBarX, y: dragBarY)
    
    userArrow.image = rangeTriangleUser
    userArrow.sizeToFit()
    masterView.addSubview(userArrow)
    userArrow.center.y = rangeHandleBar.center.y
    userArrow.frame.origin.x = rangeHandleBar.frame.maxX - userArrow.frame.width
    
    drawSquareRectOffView(rangeHandle, masterView, 8, 8)
    rangeHandle.layer.borderWidth = (masterWidth * 0.015)
    rangeHandle.layer.borderColor = yellowColor.CGColor
    rangeHandle.layer.cornerRadius = rangeHandle.frame.size.height/2
    rangeHandle.userInteractionEnabled = true
    masterView.addSubview(rangeHandle)
    rangeHandle.tag = 103
    
    rangeHandle.center.y = rangeHandleBar.center.y
    rangeHandle.center.x = rangeHandleBar.frame.minX - (rangeHandle.frame.size.width/2.03)
    
    completion()
    
}



func drawRangeLabel(masterView: UIView, rangeHorizontalBar: UIView, rangeVerticalScaleLine: UIView, rangeLabel: UILabel) {
    
    let rangeTopString = questionObjectFromGameBoardSend?.valueForKey(scaleLabelTop) as! String
    let rangeBottomString = questionObjectFromGameBoardSend?.valueForKey(scaleLabelBottom) as! String
    
    let rangeTopRegex = listMatches("\\d+", inString: rangeTopString)
    let rangeTopInt = rangeTopRegex[0].toInt()
    
    let rangeBottomRegex = listMatches("\\d+", inString: rangeBottomString)
    let rangeBottomInt = rangeBottomRegex[0].toInt()
    
    let range = rangeTopInt! - rangeBottomInt!
    let rangeIntervals = range / Int(rangeVerticalScaleLine.frame.height)
    
    rangeLabel.text = String(rangeBottomInt!)
    rangeLabel.textColor = UIColor.whiteColor()
    rangeLabel.font = fontMediumRegular
    rangeLabel.textAlignment = .Left
    rangeLabel.sizeToFit()
    
    masterView.addSubview(rangeLabel)
    
    let labelWidth = rangeHorizontalBar.frame.width
    let labelHeight = rangeLabel.frame.height
    
    rangeLabel.frame = CGRectMake(0, 0, labelWidth, labelHeight)
    
    rangeLabel.frame.origin.x = rangeHorizontalBar.frame.minX + 10.0
    rangeLabel.frame.origin.y = rangeHorizontalBar.frame.minY - labelHeight
    
}




func drawArrowLabel(masterView: UIView, rangeVerticalScaleLine: UIView, arrow: UIImageView, answer: Int) {
    
    let rangeTopString = questionObjectFromGameBoardSend?.valueForKey(scaleLabelTop) as! String
    let rangeBottomString = questionObjectFromGameBoardSend?.valueForKey(scaleLabelBottom) as! String
    
    let rangeTopRegex = listMatches("\\d+", inString: rangeTopString)
    let rangeTopInt = rangeTopRegex[0].toInt()
    
    let rangeBottomRegex = listMatches("\\d+", inString: rangeBottomString)
    let rangeBottomInt = rangeBottomRegex[0].toInt()
    
    arrow.image = rangeTriangleCorrect
    arrow.hidden = true
    arrow.sizeToFit()
    masterView.addSubview(arrow)
    
    let answerLineXCoord = rangeVerticalScaleLine.frame.minX
    
    let rangeStartPoint = Double(rangeVerticalScaleLine.frame.maxY)
    let yRange = Double(rangeTopInt! - rangeBottomInt!)
    let percent = ((Double(answer) - Double(rangeBottomInt!)) / (yRange))
    
    let answerLineYCoord = rangeStartPoint - (Double(rangeVerticalScaleLine.frame.height) * percent)
    
    arrow.frame.origin.x = answerLineXCoord
    arrow.center.y = CGFloat(answerLineYCoord)
    
    
}


















