//
//  File.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import UIKit
import Parse



func drawGameBoard(viewController: UIViewController) {
    
    let buttonSpacing = viewController.view.frame.width * 0.02
    let buttonSize = viewController.view.frame.width * 0.175

    var xCoord = viewController.view.center.x - (buttonSpacing * 1.5) - (buttonSize * 2)
    var yCoord = viewController.view.center.y - (buttonSpacing * 1.5) - (buttonSize * 2)
    
    for index in 1...16 {
        
        let boardButton = UIButton()
        boardButton.tag = index
        boardButton.frame.size = CGSizeMake(buttonSize, buttonSize)
        boardButton.backgroundColor = UIColor.grayColor()
        
        viewController.view.addSubview(boardButton)
        
        boardButton.frame.origin.x = xCoord
        boardButton.frame.origin.y = yCoord
        
        xCoord = xCoord + buttonSpacing + buttonSize
        
        if index % 4 == 0 {
            
            xCoord = viewController.view.center.x - (buttonSpacing * 1.5) - (buttonSize * 2)
            yCoord = yCoord + buttonSpacing + buttonSize
            
        }
        
        
    }
    
}

