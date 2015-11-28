//
//  RangeQuestionCheck.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/27/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import Parse
import UIKit




func animateComponentsToCenterX(masterView: UIViewController, userAnswer: Int, verticalScaleLine: UIView, rangeHorizontalBar: UIView, rangeLabel: UILabel, correctArrow: UIImageView, userArrow: UIImageView, opponentArrow: UIImageView, completion: () -> ()) {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [Int]
    let topLabel = masterView.view.viewWithTag(101) as! UILabel
    let bottomLabel = masterView.view.viewWithTag(102) as! UILabel
    let handle = masterView.view.viewWithTag(103)
    let yCoordToAnimateTo = correctArrow.center.y
    correctArrow.center.y = verticalScaleLine.frame.maxY
        
        UIView.animateWithDuration(0.20, animations: { () -> Void in
            
            rangeLabel.sizeToFit()
            
            handle!.alpha = 0.0
            rangeHorizontalBar.alpha = 0.0
            
        }) { (Bool) -> Void in
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                rangeLabel.center.y = userArrow.center.y
                rangeLabel.frame.origin.x = userArrow.frame.minX - rangeLabel.frame.width - 10.0
                
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(0.35, animations: { () -> Void in
                    
                    let masterViewCenterX = masterView.view.center.x
                    
                    topLabel.center.x = masterViewCenterX
                    bottomLabel.center.x = masterViewCenterX
                    verticalScaleLine.center.x = masterViewCenterX
                    userArrow.frame.origin.x = verticalScaleLine.frame.maxX - userArrow.frame.width
                    rangeLabel.frame.origin.x = userArrow.frame.minX - rangeLabel.frame.width - 10.0
                    
                }, completion: { (Bool) -> Void in
                    
                    correctArrow.frame.origin.x = verticalScaleLine.frame.minX
                    
                    let correctLabel = UILabel()
                    correctLabel.alpha = 0.0
                    correctLabel.text = String(answers[0])
                    correctLabel.font = fontMediumRegular
                    correctLabel.textColor = UIColor.whiteColor()
                    correctLabel.sizeToFit()
                    masterView.view.addSubview(correctLabel)
                    
                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                        
                        correctArrow.hidden = false
                        correctArrow.center.y = yCoordToAnimateTo
                        
                        }) { (Bool) -> Void in
                            
                            correctLabel.frame.origin.x = correctArrow.frame.maxX + 10.0
                            correctLabel.frame.origin.y = correctArrow.frame.maxY - correctLabel.frame.height
                            
                            UIView.animateWithDuration(0.15, animations: { () -> Void in
                                
                                correctLabel.alpha = 1.0
                                
                                }, completion: { (Bool) -> Void in
                                    
                                    completion()
                                    
                            })
                            
                    }
                    
                    
                })
                
                
            })
            
        }

}


func animateOpponentArrowAndLabel(masterView: UIViewController, userAnswer: Int, verticalScaleLine: UIView, rangeHorizontalBar: UIView, rangeLabel: UILabel, correctArrow: UIImageView, userArrow: UIImageView, opponentArrow: UIImageView, completion: () -> ()) {
    
    let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [Int]
    let opponentAnswerArray = currentLocationObject?.valueForKey(opponentsQuestionsAnswered) as! NSArray
    
    let opponentAnswer = opponentAnswerArray[0] as! Int
    let distanceBetweenOpponentAndActual = abs(answers[0] - opponentAnswer)
    let distanceBetweenUserAndActual = abs(answers[0] - userAnswer)
    
    let answer = opponentAnswerArray[0] as! Int
    drawArrowLabel(masterView.view, verticalScaleLine, opponentArrow, answer)
    
    let yCoordToAnimateTo = opponentArrow.center.y
    opponentArrow.image = rangeTriangleOpponent
    opponentArrow.center.y = verticalScaleLine.frame.maxY
    opponentArrow.frame.origin.x = verticalScaleLine.frame.maxX - opponentArrow.frame.width
    
    let opponentAnswerLabel = UILabel()
    opponentAnswerLabel.alpha = 0.0
    opponentAnswerLabel.text = String(answer)
    opponentAnswerLabel.font = fontMediumRegular
    opponentAnswerLabel.textColor = UIColor.whiteColor()
    opponentAnswerLabel.sizeToFit()
    masterView.view.addSubview(opponentAnswerLabel)
    
    UIView.animateWithDuration(1.0, animations: { () -> Void in
        
        opponentArrow.hidden = false
        opponentArrow.center.y = yCoordToAnimateTo
        
        }, completion: { (Bool) -> Void in
            
            opponentAnswerLabel.center.y = opponentArrow.center.y
            opponentAnswerLabel.center.x = rangeLabel.center.x
            
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                
                opponentAnswerLabel.alpha = 1.0
                
                }, completion: { (Bool) -> Void in
                    
                    completion()
                    
            })
            
    })
    
    
}


func compareAnswersAgainstEachOtherAndActual(masterView: UIViewController, userAnswer: Int, verticalScaleLine: UIView, rangeHorizontalBar: UIView, rangeLabel: UILabel, correctArrow: UIImageView, userArrow: UIImageView, opponentArrow: UIImageView, completion: () -> ()) {
    
        let answers = questionObjectFromGameBoardSend?.valueForKey(questionAnswersKey) as! [Int]
        let opponentAnswerArray = currentLocationObject?.valueForKey(opponentsQuestionsAnswered) as! NSArray
        
        let opponentAnswer = opponentAnswerArray[0] as! Int
        let distanceBetweenOpponentAndActual = abs(answers[0] - opponentAnswer)
        let distanceBetweenUserAndActual = abs(answers[0] - userAnswer)

        if opponentAnswerArray.count == 0 {
            
            
                    // current closest
            
            
            
        } else if opponentAnswerArray.count != 0 {


            if distanceBetweenUserAndActual < distanceBetweenOpponentAndActual {
                
                // user is closest
                
            } else if distanceBetweenUserAndActual > distanceBetweenOpponentAndActual {
                
                // opponent closest
                
            } else if distanceBetweenUserAndActual == distanceBetweenOpponentAndActual {
                
                // tie
                
            }
            
        }
        
    }
