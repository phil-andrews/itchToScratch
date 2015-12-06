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
    
    let plusCross = UIImageView()
    plusCross.image = UIImage(named: "plusCross")
    plusCross.frame.size.height = addMatchButton.frame.height * 0.65
    plusCross.frame.size.width = addMatchButton.frame.height * 0.65
    
    addMatchButton.addSubview(plusCross)
    plusCross.center.y = addMatchButton.center.y
    plusCross.center.x = addMatchButton.center.x
    
    inviteButton.frame.size.width = buttonWidth
    inviteButton.frame.size.height = buttonHeight
    inviteButton.backgroundColor = lowestColor
    inviteButton.layer.cornerRadius = buttonHeight/2
    inviteButton.setTitle("invite", forState: .Normal)
    inviteButton.contentHorizontalAlignment = .Left
    inviteButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 17.5, 0.0, 0.0)
    inviteButton.titleLabel?.font = fontSmallestRegular
    inviteButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    inviteButton.addTarget(viewController, action: Selector("inviteToMatch:"), forControlEvents: .TouchUpInside)
    
    let plusCrossInvite = UIImageView()
    plusCrossInvite.image = UIImage(named: "plusCross")
    plusCrossInvite.frame.size.height = inviteButton.frame.height * 0.60
    plusCrossInvite.frame.size.width = inviteButton.frame.height * 0.60
    
    inviteButton.addSubview(plusCrossInvite)
    plusCrossInvite.center.y = inviteButton.center.y
    plusCrossInvite.center.x = inviteButton.center.x * 1.60
    
    viewController.view.addSubview(addMatchButton)
    viewController.view.addSubview(inviteButton)
    
    addMatchButton.center.x = (viewController.view.frame.width / 4)
    addMatchButton.center.y = (viewController.view.frame.height * 0.92)
    
    inviteButton.center.x = (viewController.view.frame.width / 4) * 3
    inviteButton.center.y = (viewController.view.frame.height * 0.92)
    
}


