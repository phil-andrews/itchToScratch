//
//  utilities.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/20/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit



//Regex
//////////
////////////

func listMatches(pattern: String, inString string: String) -> [String] {
    let regex = NSRegularExpression(pattern: pattern, options: .allZeros, error: nil)
    let range = NSMakeRange(0, count(string))
    let matches = regex?.matchesInString(string, options: .allZeros, range: range) as! [NSTextCheckingResult]
    
    return matches.map {
        let range = $0.range
        return (string as NSString).substringWithRange(range)
    }
}


func drawPercentageRectOffView(view: UIView, masterView: UIView, heightPercentage: CGFloat,  widthPercentage: CGFloat) -> UIView {
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    view.frame = CGRectMake(0.0, 0.0, onePercentOfWidth * widthPercentage, onePercentOfHeight * heightPercentage)
        
    return view
    
}



func drawSquareRectOffView(view: UIView, masterView: UIView, heightPercentage: CGFloat,  widthPercentage: CGFloat) -> UIView {
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.height
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    view.frame = CGRectMake(0.0, 0.0, onePercentOfWidth * widthPercentage, onePercentOfHeight * heightPercentage)
    
    return view
    
}


func drawPercentageRectOffFloat(view: UIView, masterView: UIView, masterHeight: CGFloat, percentage: CGFloat, paddingWidth: CGFloat) -> UIView {
    
    let masterWidth = masterView.frame.width
    let onePercentOfHeight = masterHeight/100
    let onePercentOfWidth = masterWidth/100
    
    view.frame = CGRectMake(0.0, 0.0, masterWidth - paddingWidth , onePercentOfHeight * percentage)
    
    return view
    
}


func centerXAlignment(view: UIView, masterView: UIView) -> CGFloat {
    
    let masterViewWidth = masterView.frame.width
    let masterViewWidthMidPoint = masterViewWidth/2
    let viewWidth = view.frame.width
    let viewWidthMidPoint = viewWidth/2
    
    let x = masterViewWidthMidPoint - viewWidthMidPoint
    
    return x
    
}



func centerYAlignment(view: UIView, masterView: UIView) -> CGFloat {
    
    let masterViewHeight = masterView.frame.height
    let masterViewHeightMidpoint = masterViewHeight/2
    let viewHeight = view.frame.height
    let viewHeightMidPoint = viewHeight/2
    
    let y = masterViewHeightMidpoint - viewHeightMidPoint
    
    return y
    
}


func alignViewCenterYX(sView: UIView, mView: UIView) -> CGPoint {
    
    var points = CGPoint()
    
    points = CGPoint(x: centerXAlignment(sView, mView), y: centerYAlignment(sView, mView))
    
    return points
}



func addOrdinalIndicator(number: Int) -> String {
    
    var returnString = String()

    for index in 11...19 {
        
        if number%100 == index {
            
            returnString = "\(number)th"
            return returnString
            
        }
        
    }
    
    if number%10 == 1 {
        
        returnString = "\(number)st"
        return returnString
        
    }
    
    if number%10 == 2 {
        
        returnString = "\(number)nd"
        return returnString
        
    }
    
    if number%10 == 3 {
        
        returnString = "\(number)rd"
        return returnString
        
    }
    
    if number%10 == 0 {
        
        returnString = "\(number)th"
        return returnString
        
    }
    
    for index in 4...9 {
        
        if number%10 == index {
            
            returnString = "\(number)th"
            return returnString
            
        }
        
    }
    
    return returnString
}


func styleButton(button: UIButton, state: UIControlState, bgColor: UIColor, fontColor: UIColor, title: String, cornerRadius: CGFloat) {
    
    button.setTitle(title, forState: state)
    button.setTitleColor(fontColor, forState: state)
    button.backgroundColor = bgColor
    button.layer.cornerRadius = cornerRadius
    
}


//func delay(delay:Double, closure:()->()) {
//    dispatch_after(
//        dispatch_time(
//            DISPATCH_TIME_NOW,
//            Int64(delay * Double(NSEC_PER_SEC))
//        ),
//        dispatch_get_main_queue(), closure)
//}



