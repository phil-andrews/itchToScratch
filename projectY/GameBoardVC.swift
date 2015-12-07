//
//  GameBoardVC.swift
//  projectY
//
//  Created by Philip Ondrejack on 12/6/15.
//  Copyright © 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse


class GameBoardVC: UIViewController {

    var matchObject : PFObject?
    var questionObjects = [PFObject]()
    
    let opponentNameLabel = UILabel()
    let opponentProfilePicture = UIImageView()
    let userNameLabel = UILabel()
    let userProfilePicture = UIImageView()
    
    let opponentZoom = UIImageView()
    let opponentTakeTwo = UIImageView()
    let opponentStopper = UIImageView()

    let userZoom = UIImageView()
    let userTakeTwo = UIImageView()
    let userStopper = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        
        self.drawUserNamesAndProfilePicture()
        drawGameBoard(self)

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func drawUserNamesAndProfilePicture() {
        
        let pictureSize = self.view.frame.width * 0.07
        
        opponentProfilePicture.frame.size = CGSizeMake(pictureSize, pictureSize)
        opponentProfilePicture.backgroundColor = opponentColor
        opponentProfilePicture.layer.cornerRadius = opponentProfilePicture.frame.height/2
        opponentProfilePicture.frame.origin.x = self.view.frame.width * 0.04
        opponentProfilePicture.frame.origin.y = self.view.frame.height * 0.06
        
        userProfilePicture.frame.size = CGSizeMake(pictureSize, pictureSize)
        userProfilePicture.backgroundColor = userColor
        userProfilePicture.layer.cornerRadius = userProfilePicture.frame.height/2
        userProfilePicture.frame.origin.x = self.view.frame.width * 0.04
        userProfilePicture.frame.origin.y = self.view.frame.height * 0.92
        
        self.view.addSubview(opponentProfilePicture)
        self.view.addSubview(userProfilePicture)
        
        
        let nameLabelWidth = self.view.frame.width * 0.55
        let nameLabelHeight = self.view.frame.height * 0.05
        
        userNameLabel.frame.size = CGSizeMake(nameLabelWidth, nameLabelHeight)
        userNameLabel.text = globalUser?.valueForKey(displayName) as? String
        userNameLabel.font = fontSmallRegular
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.minimumScaleFactor = 0.5
        userNameLabel.textColor = userColor
        userNameLabel.frame.origin.x = userProfilePicture.frame.maxX + 5.0
        userNameLabel.center.y = userProfilePicture.center.y

        opponentNameLabel.frame.size = CGSizeMake(nameLabelWidth, nameLabelHeight)
        opponentNameLabel.text = matchObject?.valueForKey(player2UserName) as? String
        opponentNameLabel.font = fontSmallRegular
        opponentNameLabel.adjustsFontSizeToFitWidth = true
        opponentNameLabel.minimumScaleFactor = 0.5
        opponentNameLabel.textColor = opponentColor
        opponentNameLabel.frame.origin.x = opponentProfilePicture.frame.maxX + 5.0
        opponentNameLabel.center.y = opponentProfilePicture.center.y
        
        self.view.addSubview(userNameLabel)
        self.view.addSubview(opponentNameLabel)
        
        queryForAndReturnProfilePicture((globalUser?.objectId)!) { (image) -> Void in
            
            self.userProfilePicture.image = image
            
        }
        
        queryForAndReturnProfilePicture(matchObject?.valueForKey(player2IdKey) as! String) { (image) -> Void in
            
            self.opponentProfilePicture.image = image
            
        }
        
    }


}
