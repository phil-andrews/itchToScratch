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
    var opoonentStopper = UIImageView()
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

            setNeedsLayout()
                
            }
        }
        
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let bgColor = UIColor(hex: "282B35")
        
        contentView.backgroundColor = bgColor
        backgroundColor = bgColor
        
//        backgroundView = UIView(frame: CGRectZero)
//        contentView.
        
        opponentName = UILabel(frame: CGRectZero)
        opponentName.textAlignment = .Left
        opponentName.textColor = yellowColor
        contentView.addSubview(opponentName)
        opponentName.font = fontSmallerRegular
        
        opponentZoom = UIImageView(frame: CGRectZero)
        opponentZoom.image = opponentHelperZoom
        contentView.addSubview(opponentZoom)

        opponentTakeTwo = UIImageView(frame: CGRectZero)
        opponentTakeTwo.image = opponentHelperTakeTwo
        contentView.addSubview(opponentTakeTwo)

        opoonentStopper = UIImageView(frame: CGRectZero)
        opoonentStopper.image = opponentHelperStopper
        contentView.addSubview(opoonentStopper)

        opponentCategory1 = UIImageView(frame: CGRectZero)
        contentView.addSubview(opponentCategory1)

        opponentCategory2 = UIImageView(frame: CGRectZero)
        contentView.addSubview(opponentCategory2)

        opponentCategory3 = UIImageView(frame: CGRectZero)
        contentView.addSubview(opponentCategory3)

        opponentCategory4 = UIImageView(frame: CGRectZero)
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

        userCategory1 = UIImageView(frame: CGRectZero)
        userCategory1.backgroundColor = yellowColor
        contentView.addSubview(userCategory1)

        userCategory2 = UIImageView(frame: CGRectZero)
        userCategory2.backgroundColor = yellowColor
        contentView.addSubview(userCategory2)
        
        userCategory3 = UIImageView(frame: CGRectZero)
        contentView.addSubview(userCategory3)
        
        userCategory4 = UIImageView(frame: CGRectZero)
        contentView.addSubview(userCategory4)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        opponentName.frame.size.height = frame.size.height / 3
        opponentName.frame.size.width = frame.size.width / 3
        opponentName.frame.origin.x = frame.minX + 10.0
        opponentName.frame.origin.y = frame.minY + 5.0
        
        userCategory1.frame.size.height = 20.0
        userCategory1.frame.size.width = 20.0
        userCategory1.frame.origin.x = frame.minX + 10.0
        userCategory1.frame.origin.y = frame.maxY - userCategory1.frame.height - (userCategory1.frame.height * 0.1)
        
        userCategory2.frame.size.height = 20.0
        userCategory2.frame.size.width = 20.0
        userCategory2.frame.origin.x = userCategory1.frame.maxX + 5.0
        userCategory2.frame.origin.y = frame.maxY - userCategory2.frame.height - (userCategory2.frame.height * 0.1)




    }
    
    
    func setCategoryIcons(){
        
        println(matchDetails)
        
        let userCategoryWins = matchDetails?.valueForKey("player\(userNumber)CategoryWins") as! [String]
        
        let opponentCategoryWins = matchDetails?.valueForKey("player\(opponentNumber)CategoryWins") as! [String]
        
        let userCategoryArray = [userCategory1, userCategory2, userCategory3, userCategory4]

        for index in 0..<userCategoryWins.count {
            
            let imageView = userCategoryArray[index]
            imageView.image = UIImage(named: "\(userCategoryWins[index])")
            
        }
        
        let opponentCategoryArray = [opponentCategory1, opponentCategory2, opponentCategory3, opponentCategory4]
        
        for index in 0..<opponentCategoryWins.count {
            
            let imageView = opponentCategoryArray[index]
            imageView.image = UIImage(named: "\(opponentCategoryWins[index])")
            
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


