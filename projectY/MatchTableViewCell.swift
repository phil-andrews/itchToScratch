//
//  MatchTableViewCell.swift
//  projectY
//
//  Created by Philip Ondrejack on 11/29/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import UIKit
import Parse

class MatchTableViewCell: UITableViewCell {
    
    var userZoom = UIImageView()
    var userTakeTwo = UIImageView()
    var userStopper = UIImageView()
    
    var userCategory1 = UIImageView()
    var userCategory2 = UIImageView()
    var userCategory3 = UIImageView()
    var userCategory4 = UIImageView()
    
    var opponentName = UILabel()
    var opponentZoom = UIImageView()
    var opponentTakeTwo = UIImageView()
    var opponentStopper = UIImageView()
    var opponentCategory1 = UIImageView()
    var opponentCategory2 = UIImageView()
    var opponentCategory3 = UIImageView()
    var opponentCategory4 = UIImageView()
    
    
    var userNumber = 0
    var opponentNumber = 0
    
    var matchDetails: PFObject? {
        
        didSet {
            
            if let m = matchDetails as PFObject? {
                
            playerNumberOneOrTwo(m)
            opponentName.text = matchDetails!.valueForKey("player\(opponentNumber)UserName") as? String
            setCategoryIcons()
                
            }
        }
        
    }

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let bgColor = UIColor(hex: "282B35")
        
        contentView.backgroundColor = bgColor
        backgroundColor = bgColor
        
        opponentName.textAlignment = .Left
        opponentName.textColor = opponentColor
        opponentName.font = fontSmallerRegular
        contentView.addSubview(opponentName)
        
        opponentZoom = UIImageView(frame: CGRectZero)
        opponentZoom.image = opponentHelperZoom
        contentView.addSubview(opponentZoom)

        opponentTakeTwo = UIImageView(frame: CGRectZero)
        opponentTakeTwo.image = opponentHelperTakeTwo
        contentView.addSubview(opponentTakeTwo)

        opponentStopper = UIImageView(frame: CGRectZero)
        opponentStopper.image = opponentHelperStopper
        contentView.addSubview(opponentStopper)

        opponentCategory1 = UIImageView(frame: CGRectZero)
        opponentCategory1.hidden = true
        contentView.addSubview(opponentCategory1)

        opponentCategory2 = UIImageView(frame: CGRectZero)
        opponentCategory2.hidden = true
        contentView.addSubview(opponentCategory2)

        opponentCategory3 = UIImageView(frame: CGRectZero)
        opponentCategory3.hidden = true
        contentView.addSubview(opponentCategory3)

        opponentCategory4 = UIImageView(frame: CGRectZero)
        opponentCategory4.hidden = true
        contentView.addSubview(opponentCategory4)

        userZoom = UIImageView(frame: CGRectZero)
        userZoom.image = userHelperZoom
        contentView.addSubview(userZoom)

        userTakeTwo = UIImageView(frame: CGRectZero)
        userTakeTwo.image = userHelperTakeTwo
        contentView.addSubview(userTakeTwo)

        userStopper = UIImageView(frame: CGRectZero)
        userStopper.image = userHelperStopper
        contentView.addSubview(userStopper)

        userCategory1.hidden = true
        contentView.addSubview(userCategory1)

        userCategory2.hidden = true
        contentView.addSubview(userCategory2)
        
        userCategory3.hidden = true
        contentView.addSubview(userCategory3)
        
        userCategory4.hidden = true
        contentView.addSubview(userCategory4)
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let userCategoryArray = [userCategory1, userCategory2, userCategory3, userCategory4]
        let opponentCategoryArray = [opponentCategory1, opponentCategory2, opponentCategory3, opponentCategory4]
        let userHelperIconArray = [userZoom, userTakeTwo, userStopper]
        let opponentHelperIconArray = [opponentZoom, opponentTakeTwo, opponentStopper]
        
        layoutCategoryIcons(self, opponentCategoryArray, userCategoryArray)
        layoutHelperInventoryIcons(self, opponentHelperIconArray, userHelperIconArray, opponentName)
        layoutMiniGameboard(self)
        turnIdentifier(self, matchDetails!)
        
    }
    
    
    
    func setCategoryIcons(){
        
        let userCategoryWins = matchDetails?.valueForKey("player\(userNumber)CategoryWins") as! [String]
        
        let opponentCategoryWins = matchDetails?.valueForKey("player\(opponentNumber)CategoryWins") as! [String]
        
        let userCategoryArray = [userCategory1, userCategory2, userCategory3, userCategory4]

        for index in 0..<userCategoryWins.count {
            
            let imageView = userCategoryArray[index]
            imageView.hidden = false
            imageView.image = UIImage(named: "leader\(userCategoryWins[index])")
            imageView.contentMode = .ScaleAspectFit
            
        }
        
        let opponentCategoryArray = [opponentCategory1, opponentCategory2, opponentCategory3, opponentCategory4]
        
        for index in 0..<opponentCategoryWins.count {
            
            let imageView = opponentCategoryArray[index]
            imageView.hidden = false
            imageView.image = UIImage(named: "leader\(opponentCategoryWins[index])")
            imageView.contentMode = .ScaleAspectFit

        }
        
    }

    
    func playerNumberOneOrTwo(matchObject: PFObject) {
        
        var numberToReturn = Int()
        
        let userID = PFUser.currentUser()?.objectId
        
        let matchObjectPlayerOne = matchObject.valueForKey(player1IdKey) as! String
        let matchObjectPlayerTwo = matchObject.valueForKey(player2IdKey) as! String
        
        if userID == matchObjectPlayerOne {
            
            userNumber = 1
            opponentNumber = 2
            
        } else if userID == matchObjectPlayerTwo {
            
            userNumber = 2
            opponentNumber = 1

            
        }
     
    }
    
}


