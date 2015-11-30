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
    
    var userZoom: UIImageView!
    var userTakeTwo: UIImageView!
    var userStopper: UIImageView!
    var userCategory1: UIImageView!
    var userCategory2: UIImageView!
    var userCategory3: UIImageView!
    var userCategory4: UIImageView!
    
    
    var opponentName = UILabel()
    var opponentZoom: UIImageView!
    var opponentTakeTwo: UIImageView!
    var opoonentStopper: UIImageView!
    var opponentCategory1: UIImageView!
    var opponentCategory2: UIImageView!
    var opponentCategory3: UIImageView!
    var opponentCategory4: UIImageView!
    
    var userNumber = 0
    var opponentNumber = 0
    
    var matchDetails: PFObject? {
        
        didSet {
            
            if let m = matchDetails as PFObject? {
            
                println(m)
                
            playerNumberOneOrTwo()
            opponentName.text = matchDetails?.valueForKey("player\(opponentNumber)UserName") as? String
            println(opponentName.text)
            //setCategoryIcons()
            setNeedsLayout()
                
            }
        }
        
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        println(matchDetails)
        
        opponentName = UILabel(frame: CGRectZero)
        opponentName.backgroundColor = UIColor.redColor()
        opponentName.textAlignment = .Center
        opponentName.textColor = lightColoredFont
        contentView.addSubview(opponentName)

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
        contentView.addSubview(userCategory1)

        userCategory2 = UIImageView(frame: CGRectZero)
        contentView.addSubview(userCategory2)
        
        userCategory3 = UIImageView(frame: CGRectZero)
        contentView.addSubview(userCategory3)
        
        userCategory4 = UIImageView(frame: CGRectZero)
        contentView.addSubview(userCategory4)
        
        setNeedsDisplay()
        setNeedsLayout()
        
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = UIColor.clearColor()
//        selectionStyle = .None
//        
//        opponentName = UILabel(frame: CGRectZero)
//        opponentName.backgroundColor = UIColor.redColor()
//        opponentName.textAlignment = .Left
//        opponentName.font = fontTiny
//        contentView.addSubview(opponentName)
//        
//        opponentZoom = UIImageView(frame: CGRectZero)
//        opponentZoom.image = opponentHelperZoom
//        contentView.addSubview(opponentZoom)
//        
//        opponentTakeTwo = UIImageView(frame: CGRectZero)
//        opponentTakeTwo.image = opponentHelperTakeTwo
//        contentView.addSubview(opponentTakeTwo)
//        
//        opoonentStopper = UIImageView(frame: CGRectZero)
//        opoonentStopper.image = opponentHelperStopper
//        contentView.addSubview(opoonentStopper)
//        
//        opponentCategory1 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(opponentCategory1)
//        
//        opponentCategory2 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(opponentCategory2)
//        
//        opponentCategory3 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(opponentCategory3)
//        
//        opponentCategory4 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(opponentCategory4)
//        
//        userZoom = UIImageView(frame: CGRectZero)
//        userZoom.image = userHelperZoom
//        contentView.addSubview(userZoom)
//        
//        userTakeTwo = UIImageView(frame: CGRectZero)
//        userTakeTwo.image = userHelperTakeTwo
//        contentView.addSubview(userTakeTwo)
//        
//        userStopper = UIImageView(frame: CGRectZero)
//        userStopper.image = userHelperStopper
//        contentView.addSubview(userStopper)
//        
//        userCategory1 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(userCategory1)
//        
//        userCategory2 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(userCategory2)
//        
//        userCategory3 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(userCategory3)
//        
//        userCategory4 = UIImageView(frame: CGRectZero)
//        contentView.addSubview(userCategory4)
//
//    }

//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        
//    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        opponentName.frame.size.height = frame.size.height / 3
        opponentName.frame.size.width = frame.size.width
        opponentName.center.x = center.x
        opponentName.center.y = center.y

    }
    
    
    func setCategoryIcons(){
        
        let userCategoryWins = matchDetails?.valueForKey("player\(userNumber)CategoryWins") as! [String]
        
        switch(userCategoryWins.count) {
            
        case 1:
            
            userCategory1.image = UIImage(named: "\(userCategoryWins[0])")
            
            fallthrough
            
        case 2:
            
            userCategory2.image = UIImage(named: "\(userCategoryWins[1])")
            
            fallthrough
            
        case 3:
            
            userCategory3.image = UIImage(named: "\(userCategoryWins[2])")
            
            fallthrough
            
        case 4:
            
            userCategory4.image = UIImage(named: "\(userCategoryWins[3])")
            
        default :
            
            break
            
        }
        
        let opponentCategoryWins = matchDetails?.valueForKey("player\(opponentNumber)CategoryWins") as! [String]
        
        switch(opponentCategoryWins.count) {
            
        case 1:
            
            opponentCategory1.image = UIImage(named: "\(opponentCategoryWins[0])")
            
            fallthrough
            
        case 2:
            
            opponentCategory2.image = UIImage(named: "\(opponentCategoryWins[1])")
            
            fallthrough
            
        case 3:
            
            opponentCategory3.image = UIImage(named: "\(opponentCategoryWins[2])")
            
            fallthrough
            
        case 4:
            
            opponentCategory4.image = UIImage(named: "\(opponentCategoryWins[3])")
            
        default :
            
            break
            
        }
        
    }

    
    func playerNumberOneOrTwo() {
        
        var numberToReturn = Int()
        
        let userID = PFUser.currentUser()?.objectId
        let matchObjectPlayerOne = matchDetails!.valueForKey(player1IdKey) as! String
        let matchObjectPlayerTwo = matchDetails!.valueForKey(player2IdKey) as! String
        
        if userID == matchObjectPlayerOne {
            
            userNumber = 1
            opponentNumber = 2
            
        } else if userID == matchObjectPlayerTwo {
            
            userNumber = 2
            opponentNumber = 1

            
        }
        
    }
    
}


