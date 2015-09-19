//
//  sizeAdapt.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/17/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

func setFonts(view: UIView) {
    
    let viewHeight = view.frame.height
    
    switch(viewHeight) {
        
        case 480:
        
        font1 = robotoLight18!
        font2 = robotoLight20!
        font3 = robotoLight22!
        font4 = robotoLight26!
        
        font1Regular = robotoRegular20!
        font2Regular = robotoRegular22!
        font3Regular = robotoRegular24!
        font4Regular = robotoRegular26!
        
        case 568:
        
        font1 = robotoLight22!
        font2 = robotoLight24!
        font3 = robotoLight26!
        font4 = robotoLight28!
        
        font1Regular = robotoRegular22!
        font2Regular = robotoRegular24!
        font3Regular = robotoRegular26!
        font4Regular = robotoRegular28!

        
        case 667:
        
        font1 = robotoLight24!
        font2 = robotoLight26!
        font3 = robotoLight28!
        font4 = robotoLight30!
        
        font1Regular = robotoRegular24!
        font2Regular = robotoRegular26!
        font3Regular = robotoRegular28!
        font4Regular = robotoRegular30!

        
        case 736:
        
        font1 = robotoLight26!
        font2 = robotoLight28!
        font3 = robotoLight30!
        font4 = robotoLight32!
        
        font1Regular = robotoRegular26!
        font2Regular = robotoRegular28!
        font3Regular = robotoRegular30!
        font4Regular = robotoRegular32!
    
    default:
    
        font1 = robotoLight24!
        font2 = robotoLight26!
        font3 = robotoLight28!
        font4 = robotoLight30!
        
        font1Regular = robotoRegular24!
        font2Regular = robotoRegular26!
        font3Regular = robotoRegular28!
        font4Regular = robotoRegular30!
        
    }
    
    
    
}