//: Playground - noun: a place where people can play

import UIKit
import Foundation
//import XCPlayground


//var array: [NSMutableArray] = [["l1BdqofscX","l1BdqofscX","l1BdqofscX"], ["l1Bdqo0000", "l1Bdqo0000", "l1Bdqo0000", "l1Bdqo0000"], ["l1Bdqo1234", "l1Bdqo1234", "l1Bdqo1234", "l1Bdqo1234"], ["l1Bdqo8976"], ["POLqo8976", "POLdqo8976", "POLdqo8976", "POLdqo8976", "POLdqo8976", "l1Bdqo8976", "POLdqo8976"] ]
//
//
//var array2 = [1,2,5,10,1,3,5,89]
//
//array2.sort(>)
//
//
//var newArray: NSMutableArray = []
//
//var newDict = [String: Int]()
//
//
//for index in 0..<array.count {
//    
//    let number = array[index].count
//    
//    newArray.insertObject(number, atIndex: 0)
//
//    let key1 = array[index][0] as! String
//    let value = array[index].count
//    newDict[key1] = value
//    
//}
//
//newDict
//newDict.values
//newArray
//
//var sortedArray = Array(newDict.values).sorted(>)
//var sortedKeys = NSMutableArray()
//
//var barry = newDict.keys
//barry.array
//barry.array.count
//
//var count = 0
//
//for item in barry.array {
//    
//        if let dictItem = newDict[item] {
//            
//            if dictItem == sortedArray[count] {
//                
//                println("hit")
//                
//                sortedKeys.insertObject(dictItem, atIndex: count)
//                
//                ++count
//                
//            }
//            
//        }
//    
//}



var locationArray = [["l1BdqofscX","l1BdqofscX","l1BdqofscX"], ["l1Bdqo0000", "l1Bdqo0000", "l1Bdqo0000", "l1Bdqo0000"], ["l1Bdqo1234", "l1Bdqo1234", "l1Bdqo1234", "l1Bdqo1234"], ["l1Bdqo8976"], ["POLqo8976", "POLdqo8976", "POLdqo8976", "POLdqo8976", "POLdqo8976", "l1Bdqo8976", "POLdqo8976"]]

var locationArrayCount = NSMutableArray()
var locationArraySingleIds = NSMutableArray()


for item in locationArray {
    
    locationArrayCount.addObject(item.count)
    locationArraySingleIds.addObject(item[0])
}

locationArrayCount
locationArraySingleIds

var locationDict = [String: Int]()

for index in 0..<locationArray.count {
    
    var id = locationArraySingleIds[index] as! String
    var locationCount = locationArrayCount[index] as! Int
    
    locationDict[id] = locationCount
}

locationDict

extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        var array = Array(self.keys)
        sort(&array, isOrderedBefore)
        return array
    }
    
    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
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

locationDict.sortedKeysByValue(>)
locationDict.keysSortedByValue(>)


[["l1BdqofscX","l1BdqofscX","l1BdqofscX"],["7cZwFnDOJ9","7cZwFnDOJ9","7cZwFnDOJ9","7cZwFnDOJ9","7cZwFnDOJ9","7cZwFnDOJ9"], ["FsXYJTOh2p", "FsXYJTOh2p", "FsXYJTOh2p", "FsXYJTOh2p", "FsXYJTOh2p", "FsXYJTOh2p", "FsXYJTOh2p", "FsXYJTOh2p"], ["l0ro5tEG2K", "l0ro5tEG2K", "l0ro5tEG2K", "l0ro5tEG2K", "l0ro5tEG2K", "l0ro5tEG2K", "l0ro5tEG2K"]]










