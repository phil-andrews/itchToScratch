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
        
        fontBottom = robotoLight10!
        fontTiny = robotoLight12!
        fontSmallest = robotoLight14!
        fontSmaller = robotoLight16!
        fontSmall = robotoLight18!
        fontMedium = robotoLight20!
        fontLarge = robotoLight22!
        fontExtraLarge = robotoLight26!
        
        fontSmallRegular = robotoRegular20!
        fontMediumRegular = robotoRegular22!
        fontLargeRegular = robotoRegular24!
        fontExtraLargeRegular = robotoRegular26!
        
        case 568:
        
        fontBottom = robotoLight14!
        fontTiny = robotoLight16!
        fontSmallest = robotoLight18!
        fontSmaller = robotoLight20!
        fontSmall = robotoLight22!
        fontMedium = robotoLight24!
        fontLarge = robotoLight26!
        fontExtraLarge = robotoLight28!
        
        fontSmallRegular = robotoRegular22!
        fontMediumRegular = robotoRegular24!
        fontLargeRegular = robotoRegular26!
        fontExtraLargeRegular = robotoRegular28!

        
        case 667:
        
        fontBottom = robotoLight16!
        fontTiny = robotoLight18!
        fontSmallest = robotoLight20!
        fontSmaller = robotoLight22!
        fontSmall = robotoLight24!
        fontMedium = robotoLight26!
        fontLarge = robotoLight28!
        fontExtraLarge = robotoLight30!
        
        fontSmallRegular = robotoRegular24!
        fontMediumRegular = robotoRegular26!
        fontLargeRegular = robotoRegular28!
        fontExtraLargeRegular = robotoRegular30!

        
        case 736:
        
        fontBottom = robotoLight18!
        fontTiny = robotoLight20!
        fontSmallest = robotoLight22!
        fontSmaller = robotoLight24!
        fontSmall = robotoLight26!
        fontMedium = robotoLight28!
        fontLarge = robotoLight30!
        fontExtraLarge = robotoLight32!
        
        fontSmallRegular = robotoRegular26!
        fontMediumRegular = robotoRegular28!
        fontLargeRegular = robotoRegular30!
        fontExtraLargeRegular = robotoRegular32!
    
    default:
    
        fontBottom = robotoLight14!
        fontTiny = robotoLight16!
        fontSmallest = robotoLight18!
        fontSmaller = robotoLight20!
        fontSmall = robotoLight22!
        fontMedium = robotoLight24!
        fontLarge = robotoLight26!
        fontExtraLarge = robotoLight28!
        
        fontSmallRegular = robotoRegular24!
        fontMediumRegular = robotoRegular26!
        fontLargeRegular = robotoRegular28!
        fontExtraLargeRegular = robotoRegular30!
        
    }
    
    
    
}