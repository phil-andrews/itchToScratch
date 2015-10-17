//
//  makeBackground.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/4/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit



func animationLoop1(floatView: UIView) {
    
    let colorsArray = [lowestColor, lowColor, midColor, highColor, highestColor]
    var colorNumber = Int(arc4random_uniform(5))
    var color = colorsArray[colorNumber]
    floatView.layer.borderWidth = 1.5
    floatView.layer.borderColor = color.CGColor
    floatView.alpha = 0.0
    
    var randomY = CGFloat(arc4random_uniform(568))
    floatView.frame.origin.y = randomY
    
    var randomD = NSTimeInterval(arc4random_uniform(3))
    
    delay(0.5){
        
        UIView.animateWithDuration(2.0, delay: randomD, options: nil, animations: { () -> Void in
            
            floatView.alpha = 0.7
            
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    
                    floatView.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        animationLoop2(floatView)
                        
                })
                
        })
        
    }
    
    
}

func animationLoop2(floatView: UIView) {
    
    let colorsArray = [lowestColor, lowColor, midColor, highColor, highestColor]
    var colorNumber = Int(arc4random_uniform(5))
    var color = colorsArray[colorNumber]
    floatView.layer.borderWidth = 1.5
    floatView.layer.borderColor = color.CGColor
    floatView.alpha = 0.0
    
    var randomY = CGFloat(arc4random_uniform(568))
    floatView.frame.origin.y = randomY
    
    var randomD = NSTimeInterval(arc4random_uniform(3))
    
    delay(0.5){
        
        UIView.animateWithDuration(2.0, delay: randomD, options: nil, animations: { () -> Void in
            
            floatView.alpha = 0.7
            
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    
                    floatView.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        animationLoop1(floatView)
                        
                })
                
        })
        
    }
    
}


func activityIndicator() {
    
    
    
    
    
}


func makeBackground() -> UIView {
    
    let backRect = UIView()
    backRect.frame = backRect.bounds
    backRect.backgroundColor = backgroundColor
    
    let floater1 = UIView(frame: CGRectMake(10.0, 0.0, 25, 25))
    let floater2 = UIView(frame: CGRectMake(35.0, 0.0, 25, 25))
    let floater3 = UIView(frame: CGRectMake(60.0, 0.0, 25, 25))
    let floater4 = UIView(frame: CGRectMake(85.0, 0.0, 25, 25))
    let floater5 = UIView(frame: CGRectMake(110.0, 0.0, 25, 25))
    let floater6 = UIView(frame: CGRectMake(135.0, 0.0, 25, 25))
    let floater7 = UIView(frame: CGRectMake(160.0, 0.0, 25, 25))
    let floater8 = UIView(frame: CGRectMake(185.0, 0.0, 25, 25))
    let floater9 = UIView(frame: CGRectMake(210.0, 0.0, 25, 25))
    let floater10 = UIView(frame: CGRectMake(235.0, 0.0, 25, 25))
    let floater11 = UIView(frame: CGRectMake(260.0, 0.0, 25, 25))
    let floater12 = UIView(frame: CGRectMake(285.0, 0.0, 25, 25))
    
    
    backRect.addSubview(floater1)
    backRect.addSubview(floater2)
    backRect.addSubview(floater3)
    backRect.addSubview(floater4)
    backRect.addSubview(floater5)
    backRect.addSubview(floater6)
    backRect.addSubview(floater7)
    backRect.addSubview(floater8)
    backRect.addSubview(floater9)
    backRect.addSubview(floater10)
    backRect.addSubview(floater11)
    backRect.addSubview(floater12)
    
    animationLoop1(floater1)
    animationLoop1(floater2)
    animationLoop1(floater3)
    animationLoop1(floater4)
    animationLoop1(floater5)
    animationLoop1(floater6)
    animationLoop1(floater7)
    animationLoop1(floater8)
    animationLoop1(floater9)
    animationLoop1(floater10)
    animationLoop1(floater11)
    animationLoop1(floater12)
    
    return backRect
}

func animateWhereChartBar(chartBar: UIButton, barLabel: SpringButton, delay: NSTimeInterval) {
    
    if chartBar.alpha == 1.0 {
        
        return
    }
    
    chartBar.alpha = 1.0
    
    UIView.animateWithDuration(0.35, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: nil, animations: { () -> Void in
        
        chartBar.center.x += chartBar.bounds.width
        
    }) { (Bool) -> Void in
    
        barLabel.titleLabel!.alpha = 1.0
        
        barLabel.animation = "pop"
        barLabel.curve = "easeInOutExpo"
        barLabel.delay = 0.15
        barLabel.duration = 0.5
        barLabel.animate()
        
    }
    
}













