//
//  matchListGetMatchButtons.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import UIKit
import Foundation



func drawGetMatchButtons(viewController: UIViewController) {
    
    let addMatchButton = UIButton()
    let inviteButton = UIButton()
    
    let buttonWidth = viewController.view.frame.width * 0.315
    let buttonHeight = viewController.view.frame.height * 0.065
    
    addMatchButton.frame.size.width = buttonWidth
    addMatchButton.frame.size.height = buttonHeight
    addMatchButton.backgroundColor = midColor
    addMatchButton.layer.cornerRadius = buttonHeight/2
    addMatchButton.addTarget(viewController, action: Selector("getNewMatch"), forControlEvents: .TouchUpInside)
    
    inviteButton.frame.size.width = buttonWidth
    inviteButton.frame.size.height = buttonHeight
    inviteButton.backgroundColor = lowestColor
    inviteButton.layer.cornerRadius = buttonHeight/2
    inviteButton.setTitle("friend", forState: .Normal)
    inviteButton.contentHorizontalAlignment = .Left
    inviteButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 12.5, 0.0, 0.0)
    inviteButton.titleLabel?.font = fontSmallestRegular
    inviteButton.addTarget(viewController, action: Selector("inviteToMatch:"), forControlEvents: .TouchUpInside)
    
    viewController.view.addSubview(addMatchButton)
    viewController.view.addSubview(inviteButton)
    
    addMatchButton.center.x = (viewController.view.frame.width / 4)
    addMatchButton.center.y = (viewController.view.frame.height * 0.92)
    
    inviteButton.center.x = (viewController.view.frame.width / 4) * 3
    inviteButton.center.y = (viewController.view.frame.height * 0.92)
    
}


