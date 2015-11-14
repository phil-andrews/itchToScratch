//
//  File.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI
import Bolts



func populateGameBoard(masterView: UIView, parseObjects: [PFObject], sortedObjectIDs: [String], locationObject: PFObject) {

    var questionObjects = parseObjects
    
    let numberOfUsersAtLocation = locationObject.valueForKey(usersLoggedInAtLocationCount) as! Double
    var goalToHit: Double = numberOfUsersAtLocation/2
    
    for index in 0..<40 {
        
        var question: PFObject?
        
        for object in parseObjects {
            
            if object.objectId == sortedObjectIDs[index] {
            
                question = object
                
                break
                
            }
        }
        
        
        let view = masterView.viewWithTag(index + 1)
        
        if let button = view as? UIButton {
            
            button.alpha = 0.0
            
            let questionType = question!.valueForKey(questionCategoryKey) as! String
            let backgroundImage = UIImage(named: questionType)
            button.setBackgroundImage(backgroundImage, forState: .Normal)
            
            let numberCorrect = locationObject.valueForKey("ans\(index)") as! Double
            button.backgroundColor = lightColoredFont
            
            let randomNumber = arc4random_uniform(UInt32(4))
            let randomDuration = Double(randomNumber) * 0.1
            
            UIView.animateWithDuration(randomDuration, animations: { () -> Void in
                
                button.alpha = 1.0
                
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    button.backgroundColor = buttonColoring(goalToHit, numberCorrect)
                    
                })
                
            })
        
        }
    }
    
}



func drawButtons(masterView: UIView, vc: UIViewController, action: String, completion: () -> Void) {
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    var count = 1
    var buttonCount = 0
    
    
    var yOrigin = (onePercentOfHeight * 6.86)
    var xOrigin = (masterWidth - (((onePercentOfHeight * 9.507) * 5) + ((onePercentOfWidth * 1.562) * 4)))/2
    var yOffset = yOrigin
    var xOffset = xOrigin
    
    while count < 41 {
        
        var button = UIButton()
        button.tag = count
        button.setBackgroundImage(science, forState: .Normal)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(vc, action: Selector(action), forControlEvents: .TouchUpInside)
        
        drawSquareRectOffView(button, masterView, 9.507, 9.507)
        button.frame.origin.x = xOffset
        button.frame.origin.y = yOffset
        
        xOffset = button.frame.maxX + (onePercentOfWidth * 1.562)
        
        if count % 5 == 0 {
            
            xOffset = xOrigin
            yOffset = button.frame.maxY + (onePercentOfWidth * 1.562)
            
        }
        
        masterView.addSubview(button)

        
        ++count
        
    }
    
    
completion()

}



func buttonColoring(goalToHit: Double, correctAnswers: Double) -> UIColor {
    
    var colorToReturn = UIColor()
    var numberOfCorrect = correctAnswers
    
    if numberOfCorrect == 0 {
        
        numberOfCorrect = 0.01
        
    }
    
    var minimum: Double = 1.0
    var workingGoal = Double()
    
    if goalToHit < minimum {
        
        workingGoal = minimum
        
    } else {
        
        workingGoal = goalToHit
        
    }
    
    
    let percentage = (numberOfCorrect / workingGoal)
    
    switch(percentage) {
        
    case _ where percentage <= 0.10:
        
        colorToReturn = lightColoredFont
        
    case _ where percentage <= 0.25:
        
        colorToReturn = lowestColor
        
    case _ where percentage <= 0.4:
        
        colorToReturn = lowColor
        
    case _ where percentage <= 0.6:
        
        colorToReturn = midColor
        
    case _ where percentage <= 0.8:
        
        colorToReturn = highColor
        
    case _ where percentage <= 1:
        
        colorToReturn = highestColor
        
    case _ where percentage >= 1:
        
        colorToReturn = highestColor
        
    default:
        
        colorToReturn = lowColor
        
        
    }
    
    
    return colorToReturn
    
}



func drawCityLabel(masterView: UIView, locationObject: PFObject) {
    
    let masterHeight = masterView.frame.height
    let masterWidth = masterView.frame.width
    let onePercentOfWidth = masterWidth/100
    let onePercentOfHeight = masterHeight/100
    
    var cityLabel = UILabel()
    var cityTitle = locationObject.valueForKey(locality) as! String
    cityLabel.text = cityTitle
    cityLabel.textColor = lightColoredFont
    cityLabel.font = fontSmaller
    cityLabel.sizeToFit()
    cityLabel.frame.origin.x = centerXAlignment(cityLabel, masterView)
        
    let labelOffset = ((onePercentOfHeight * 9.507) * 8) + ((onePercentOfHeight * 1.562) * 9.5)
    
    cityLabel.frame.origin.y = labelOffset
    
    masterView.addSubview(cityLabel)
    
}


func animateButtonColors(goalToHit: Double, correctAnswers: Double, startColor: UIColor) {
    
    let colors = [lightColoredFont, lowColor, lowestColor, midColor, highColor, highestColor]
    
    var endColor = buttonColoring(goalToHit, correctAnswers)
    
    
    
    
}



