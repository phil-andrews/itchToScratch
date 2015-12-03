//
//  matchCellLayout.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/30/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse



func layoutCategoryIcons(cell: UITableViewCell, opponentCategoryArray: [UIImageView], userCategoryArray: [UIImageView]) {
    
    
    var opponentXOrigin = cell.frame.minX + 20.0
    
    for item in opponentCategoryArray {
        
        item.frame.size.height = cell.frame.size.width * 0.06
        item.frame.size.width = cell.frame.size.width * 0.06
        item.frame.origin.y = cell.bounds.maxY - item.frame.height - (item.frame.height * 0.40)
        item.frame.origin.x = opponentXOrigin
        item.layer.cornerRadius = 2.0
        item.backgroundColor = opponentColor
        
        opponentXOrigin = opponentXOrigin + (item.frame.width + 5.0)
        
    }
    
    var userXOrigin = cell.bounds.maxX - (cell.frame.size.width * 0.0656) - 20.0
    
    for item in userCategoryArray {
        
        item.frame.size.height = cell.frame.size.width * 0.06
        item.frame.size.width = cell.frame.size.width * 0.06
        item.frame.origin.y = cell.bounds.maxY - item.frame.height - (item.frame.height * 0.40)
        item.frame.origin.x = userXOrigin
        item.layer.cornerRadius = 2.0
        item.backgroundColor = userColor
        
        userXOrigin = userXOrigin - (item.frame.width) - 5.0
        
    }
    
}



func layoutHelperInventoryIcons(cell: UITableViewCell, opponentHelperIconArray: [UIImageView], userHelperIconArray: [UIImageView], opponentNameLabel: UILabel) {
    
    opponentNameLabel.sizeToFit()
    opponentNameLabel.frame.size.width = cell.frame.width / 2
    opponentNameLabel.numberOfLines = 1
    opponentNameLabel.adjustsFontSizeToFitWidth = true
    opponentNameLabel.minimumScaleFactor = 0.5
    opponentNameLabel.frame.origin.x = cell.bounds.minX + 17.5
    opponentNameLabel.frame.origin.y = cell.bounds.minY + 6.0
    
    var opponentXOrigin = opponentNameLabel.frame.origin.x
    
    for item in opponentHelperIconArray {
        
        item.frame.origin.y = opponentNameLabel.frame.maxY + 5.0
        item.frame.origin.x = opponentXOrigin
        item.frame.size.width = cell.frame.width * 0.03125
        item.frame.size.height = cell.frame.width * 0.03125
        
        opponentXOrigin = item.frame.maxX + 3.0
        
        item.contentMode = .ScaleAspectFit
    }
    
    var userXOrigin = cell.frame.width - (opponentNameLabel.frame.height) - 17.5
    
    for item in userHelperIconArray {
        
        item.frame.origin.y = cell.bounds.origin.y + 15.0
        item.frame.origin.x = userXOrigin
        item.frame.size.width = opponentNameLabel.frame.height * 0.75
        item.frame.size.height = opponentNameLabel.frame.height * 0.75
        
        userXOrigin = item.frame.origin.x - (item.frame.size.width) - 10.0
        
        item.contentMode = .ScaleAspectFit
        
    }
    
}


func layoutMiniGameboard(cell: UITableViewCell) {
  
    let width = cell.frame.width * 0.025
    
    let cellSpacing = cell.frame.width * 0.007
    var xCoord = cell.bounds.midX - (width * 2) - (cellSpacing * 1.5)
    var yCoord = cell.bounds.midY - (width * 2) - (cellSpacing * 1.5)
    
    for index in 0...15 {
        
        let view = UIView()
        view.frame.size.width = width
        view.frame.size.height = width
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.grayColor().CGColor
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = 0.5
        cell.contentView.addSubview(view)
        
        view.frame.origin.x = xCoord
        view.frame.origin.y = yCoord
        
        xCoord = xCoord + width + cellSpacing
        
        if (index + 1) % 4 == 0 {
            
            xCoord = cell.bounds.midX - (width * 2) - (cellSpacing * 1.5)
            yCoord = yCoord + width + cellSpacing
            
        }
        
        
    }
    
    
    
    
}



func turnIdentifier(cell: UITableViewCell, matchDetails: PFObject) {
    
    let turnBracket = UIView()
    turnBracket.frame.size.height = cell.frame.height
    turnBracket.frame.size.width = cell.frame.width * 0.03
    cell.contentView.addSubview(turnBracket)
    
    let userTurn = matchDetails.valueForKey("turn") as! String
    
    if userTurn == PFUser.currentUser()?.objectId {
        
        turnBracket.frame.origin.x = cell.frame.width - turnBracket.frame.width
        turnBracket.backgroundColor = userColor
        
    } else if userTurn != PFUser.currentUser()?.objectId {
        
        turnBracket.frame.origin = CGPoint(x: 0.0, y: 0.0)
        turnBracket.backgroundColor = opponentColor

    }
    
    
}


















