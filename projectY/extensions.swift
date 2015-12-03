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
        array.sortInPlace(isOrderedBefore)
        return array
    }
    

    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        var array = Array(self)
        array.sortInPlace {
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


