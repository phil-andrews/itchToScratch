//
//  QuestionDetailUI.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/31/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Parse
import ParseUI
import Bolts
import SpriteKit

var questionObjectFromGameBoardSend: PFObject?

func displayQuestionContainer(masterView: UIViewController, question: PFObject, type: Int, completion: (UIView) -> Void) {

    let containerView = UIView()
    containerView.frame = masterView.view.bounds
    containerView.tag = 999
    
    let overLay = UIImageView()
    overLay.frame = masterView.view.bounds
    let image = UIImage(named: "blurEffect")
    overLay.image = image
    
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    var blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = masterView.view.bounds
    blurEffectView.alpha = 1.0
    
    containerView.addSubview(blurEffectView)
    containerView.addSubview(overLay)
    
    containerView.frame.origin.y += masterView.view.frame.height
    containerView.alpha = 0.98
    masterView.view.addSubview(containerView)
    
    completion(containerView)
    
}






func singleAnswerQuestionNoImage() {
    
    
    
    
    
}



func singleAnswerQuestionWithImage() {
    
    
    
    
    
}



func multipleAnswerQuestionWithImage() {
    
    
    
    
    
}








func multipleAnswerQuestionNoImage() {
    
    
    
    
}




func numberRangeQuestion() {
    
    
    
    
    
}



func surveyQuestion() {
    
    
    
}




func checkAnswerSubmitted() {
    
    let question = questionObjectFromGameBoardSend
    let type = question!.valueForKey(questionType) as! Int
    let questionString = question!.valueForKey(questionAsk) as! String
    let category = question!.valueForKey(questionCategory) as! String
    let answersNeeded = question!.valueForKey(numberOfAnswers) as! Int
    var answerArray = question!.valueForKey(questionAnswers) as! NSMutableArray
    
    
    println("func ran")
    
    
    
    
}


func animateContainerView(masterView: UIViewController, containerView: UIView) {
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
        
        containerView.frame.origin.y -= masterView.view.frame.height
        
    })
    
    
    
}





