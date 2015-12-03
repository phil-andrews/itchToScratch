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


func displayQuestionContainer(masterView: UIViewController, question: PFObject, type: Int, completion: (UIView) -> Void) {

    let containerView = UIView()
    containerView.frame = masterView.view.bounds
    containerView.tag = 999
    
    let overLay = UIView()
    overLay.frame = masterView.view.bounds
    overLay.backgroundColor = backgroundColor
    overLay.alpha = 0.9

    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = masterView.view.bounds
    blurEffectView.alpha = 1.0
    
    containerView.addSubview(blurEffectView)
    containerView.addSubview(overLay)
    
    containerView.frame.origin.y += masterView.view.frame.height
    containerView.alpha = 0.98
    masterView.view.addSubview(containerView)
    
    completion(containerView)
    
}





func surveyQuestion() {
    
    
    
}




func animateContainerView(masterView: UIViewController, containerView: UIView, completion: () -> Void) {

    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
        
        containerView.frame.origin.y -= masterView.view.frame.height

        
    }) { (Bool) -> Void in
        
        completion()
        
    }
    
    
    
}



func dismissContainerView(containerView: UIView, completion: () -> Void) {
    
    delay(2.0, closure: { () -> () in
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            containerView.frame.origin.y += containerView.frame.height
            
            }, completion: { (Bool) -> Void in
                
                containerView.removeFromSuperview()
                
        })
        
    })
    
    
}



