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
        
        fontSmallestRegular = robotoRegular16!
        fontSmallerRegular = robotoRegular18!
        fontSmallRegular = robotoRegular20!
        fontMediumRegular = robotoRegular22!
        fontLargeRegular = robotoRegular24!
        fontExtraLargeRegular = robotoRegular26!
        
        fontSmallestMedium = robotoMedium16!
        fontSmallerMedium = robotoMedium18!
        fontSmallMedium = robotoMedium20!
        fontMediumMedium = robotoMedium22!
        fontLargeMedium = robotoMedium24!
        fontExtraLargeMedium = robotoMedium26!
        
        case 568:
        
        fontBottom = robotoLight14!
        fontTiny = robotoLight16!
        fontSmallest = robotoLight18!
        fontSmaller = robotoLight20!
        fontSmall = robotoLight22!
        fontMedium = robotoLight24!
        fontLarge = robotoLight26!
        fontExtraLarge = robotoLight28!
        
        fontSmallestRegular = robotoRegular18!
        fontSmallerRegular = robotoRegular20!
        fontSmallRegular = robotoRegular22!
        fontMediumRegular = robotoRegular24!
        fontLargeRegular = robotoRegular26!
        fontExtraLargeRegular = robotoRegular28!
        
        fontSmallestMedium = robotoMedium18!
        fontSmallerMedium = robotoMedium20!
        fontSmallMedium = robotoMedium22!
        fontMediumMedium = robotoMedium24!
        fontLargeMedium = robotoMedium26!
        fontExtraLargeMedium = robotoMedium28!

        
        case 667:
        
        fontBottom = robotoLight16!
        fontTiny = robotoLight18!
        fontSmallest = robotoLight20!
        fontSmaller = robotoLight22!
        fontSmall = robotoLight24!
        fontMedium = robotoLight26!
        fontLarge = robotoLight28!
        fontExtraLarge = robotoLight30!
        
        fontSmallestRegular = robotoRegular20!
        fontSmallerRegular = robotoRegular22!
        fontSmallRegular = robotoRegular24!
        fontMediumRegular = robotoRegular26!
        fontLargeRegular = robotoRegular28!
        fontExtraLargeRegular = robotoRegular30!
        
        fontSmallestMedium = robotoMedium20!
        fontSmallerMedium = robotoMedium22!
        fontSmallMedium = robotoMedium24!
        fontMediumMedium = robotoMedium26!
        fontLargeMedium = robotoMedium28!
        fontExtraLargeMedium = robotoMedium30!

        
        case 736:
        
        fontBottom = robotoLight18!
        fontTiny = robotoLight20!
        fontSmallest = robotoLight22!
        fontSmaller = robotoLight24!
        fontSmall = robotoLight26!
        fontMedium = robotoLight28!
        fontLarge = robotoLight30!
        fontExtraLarge = robotoLight32!
        
        fontSmallestRegular = robotoRegular22!
        fontSmallerRegular = robotoRegular24!
        fontSmallRegular = robotoRegular26!
        fontMediumRegular = robotoRegular28!
        fontLargeRegular = robotoRegular30!
        fontExtraLargeRegular = robotoRegular32!
        
        fontSmallestMedium = robotoMedium22!
        fontSmallerMedium = robotoMedium24!
        fontSmallMedium = robotoMedium26!
        fontMediumMedium = robotoMedium28!
        fontLargeMedium = robotoMedium30!
        fontExtraLargeMedium = robotoMedium32!
    
    default:
    
        fontBottom = robotoLight14!
        fontTiny = robotoLight16!
        fontSmallest = robotoLight18!
        fontSmaller = robotoLight20!
        fontSmall = robotoLight22!
        fontMedium = robotoLight24!
        fontLarge = robotoLight26!
        fontExtraLarge = robotoLight28!
        
        fontSmallestRegular = robotoRegular20!
        fontSmallerRegular = robotoRegular22!
        fontSmallRegular = robotoRegular24!
        fontMediumRegular = robotoRegular26!
        fontLargeRegular = robotoRegular28!
        fontExtraLargeRegular = robotoRegular30!
        
    }
    
    
}




func fontAdjuster(labelText: String, fontS: UIFont, fontM: UIFont, fontL: UIFont) -> UIFont {
    
    var font = fontS
    
    let textLength = labelText.length
    
    switch(textLength) {
        
    case _ where textLength < 25:
        
        font = fontL
        
    case _ where textLength >= 25:
        
        font = fontM
        
    case _ where textLength >= 50:
        
        font = fontL
        
    default:
        
        font = fontS
        
    }
    
    return font
    
}

