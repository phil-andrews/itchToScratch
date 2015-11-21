//
//  indicatorLightHandler.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/21/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



func indicatorLightSelector() -> [Int] {
    
    var arrayToReturn = [Int]()
    
    let number = questionObjectFromGameBoardSend?.valueForKey(numberOfAnswersKey) as! Int
    
    switch(number) {
        
    case 2:
        
        arrayToReturn = [0, 1]
        
    case 3:
        
        arrayToReturn = [2, 0, 1]
        
    case 4:
        
        arrayToReturn = [2, 0, 1, 3]
        
    case 5:
        
        arrayToReturn = [4, 2, 0, 1, 3]
        
    default:
        
        break
        
    }
    
    return arrayToReturn
}



func animationForIndicatorLightFilledCorrect(indicatorLight: UIView, color: UIColor) {
    
    
    UIView.animateWithDuration(0.15, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0, options: nil, animations: { () -> Void in
        
        indicatorLight.transform = CGAffineTransformMakeScale(1.1, 1.5)
        indicatorLight.backgroundColor = color
        indicatorLight.layer.borderColor = color.CGColor
        
    }) { (Bool) -> Void in
        
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            
            indicatorLight.transform = CGAffineTransformIdentity
            
        })
        
    }
    
}


func animateForIndicatorLightFilledIncorrect(indicatorLight: UIView, color: UIColor) {
    
    
    UIView.animateWithDuration(0.15, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0, options: nil, animations: { () -> Void in
        
        indicatorLight.transform = CGAffineTransformMakeScale(0.1, 0.2)
        indicatorLight.backgroundColor = color
        indicatorLight.layer.borderColor = color.CGColor
        
        }) { (Bool) -> Void in
            
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                
                indicatorLight.transform = CGAffineTransformIdentity
                
            })
            
    }
    
    
    
    
}



















