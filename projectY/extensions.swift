//
//  extensions.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/5/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit


extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        var array = Array(self.keys)
        sort(&array, isOrderedBefore)
        return array
    }
    

    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        var array = Array(self)
        sort(&array) {
            let (lk, lv) = $0
            let (rk, rv) = $1
            return isOrderedBefore(lv, rv)
        }
        return array.map {
            let (k, v) = $0
            return k
        }
    }
    
}


extension UIView
{
    func colorOfPoint (point: CGPoint) -> UIColor
    {
        var pixel = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, bitmapInfo)
        
        CGContextTranslateCTM(context, -point.x, -point.y)
        
        self.layer.renderInContext(context)
        
        let colorToReturn = UIColor(red: CGFloat(pixel [0]) / 255.0, green: CGFloat(pixel [1]) / 255.0, blue: CGFloat(pixel [2]) / 255.0 , alpha: CGFloat(pixel [3]) / 255.0)
        
        return colorToReturn
    }
}

