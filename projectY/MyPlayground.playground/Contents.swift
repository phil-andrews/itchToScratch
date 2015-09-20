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


//
//var locationArray = [["l1BdqofscX","l1BdqofscX","l1BdqofscX"], ["l1Bdqo0000", "l1Bdqo0000", "l1Bdqo0000", "l1Bdqo0000"], ["l1Bdqo1234", "l1Bdqo1234", "l1Bdqo1234", "l1Bdqo1234"], ["l1Bdqo8976"], ["POLqo8976", "POLdqo8976", "POLdqo8976", "POLdqo8976", "POLdqo8976", "l1Bdqo8976", "POLdqo8976"]]
//
//var locationArrayCount = NSMutableArray()
//var locationArraySingleIds = NSMutableArray()
//
//
//for item in locationArray {
//    
//    locationArrayCount.addObject(item.count)
//    locationArraySingleIds.addObject(item[0])
//}
//
//locationArrayCount
//locationArraySingleIds
//
//var locationDict = [String: Int]()
//
//for index in 0..<locationArray.count {
//    
//    var id = locationArraySingleIds[index] as! String
//    var locationCount = locationArrayCount[index] as! Int
//    
//    locationDict[id] = locationCount
//}
//
//locationDict
//
//extension Dictionary {
//    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
//        var array = Array(self.keys)
//        sort(&array, isOrderedBefore)
//        return array
//    }
//    
//    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
//    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
//        return sortedKeys {
//            isOrderedBefore(self[$0]!, self[$1]!)
//        }
//}
//    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
//        var array = Array(self)
//        sort(&array) {
//            let (lk, lv) = $0
//            let (rk, rv) = $1
//            return isOrderedBefore(lv, rv)
//        }
//        return array.map {
//            let (k, v) = $0
//            return k
//        }
//    }
//
//}
//
//locationDict.sortedKeysByValue(>)
//locationDict.keysSortedByValue(>)



var text: NSMutableString = "the quick brown fox jumped over the lazy dog over and over until it was time for dinner"
var textView = UITextView(frame: CGRectMake(0.0, 0.0, 200.0, 200.0))
textView.textColor = UIColor.redColor()

let stringToColor = "jumped"
var range = (text as NSString).rangeOfString(stringToColor as String)

var attributedString = NSMutableAttributedString(string: text as String)

attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: range)


let newText = "hth"

textView.attributedText = attributedString
var attString = textView.characterRangeAtPoint(CGPoint(x: 150.0, y: 10.0))



//var newString = NSRange(attString)
//attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: attString)

var blueString = "the quick brown fox jumped over the lazy dog over and over until it was time for dinner"
textView.text.componentsSeparatedByString("\n")


let hi = ["ImIE4VS8CF","LWkWRGpUyW","vd5zkmFF3K","v667XU7MRx","phYYKOarj9","6DCBEZuwgB","5qfRYcwCxW","z3tZHNC4Iq","xUHqmhXuMj","IaTSYcAGEI","ts4JkJVQze","ukdWzQ6gZR","mpx1kfKD56","4xVhxjxARY","5FMg5eZvEO","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","6H1b6HrJ07","6t4J21oNWc","MbHdCp1Uyf","MJsUmoUYF3","9HhRFxSnqm","9NXeaZzjPb","tgt53X6tEj","1AnOYcUHoQ","8Cb2kgGVMD","7VqcDFBlpj","OIWYA5L240","QLWNqyA7wR","AbMha3fy6j","9jJWSzbi9A","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","ImIE4VS8CF","EYBQ8QkCRS","EGDbzgdJ6o","v667XU7MRx","phYYKOarj9","6DCBEZuwgB","5qfRYcwCxW","z3tZHNC4Iq","xUHqmhXuMj","CD7mr9qt4M","CO3tEUAFGM","ukdWzQ6gZR","mpx1kfKD56","4xVhxjxARY","5FMg5eZvEO","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","6H1b6HrJ07","6t4J21oNWc","MbHdCp1Uyf","MJsUmoUYF3","9HhRFxSnqm","9NXeaZzjPb","tgt53X6tEj","1AnOYcUHoQ","8Cb2kgGVMD","7VqcDFBlpj","OIWYA5L240","QLWNqyA7wR","AbMha3fy6j","9jJWSzbi9A","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","udNKIbuMJM","PrZtijrbAz","Sd37qzfN70","KT4WRSlbYj","6DCBEZuwgB","nCKv5hhkJa","JTfFghVr4Q","YybiAg6oIb","dXcgDAQYmH","RKVMiVL7o4","b0FxLBWm6e","mpKAqvI9nA","eOdIaAK1TZ","uyYYeQJe84","afbYqkIkIR","CO3tEUAFGM","IH9N6OjH1M","Wi18Pme5ti","QDBLbbmWgS","ewocukmo50","HDoiZZLpfk","VDCpiwhkeu","9jJWSzbi9A","bze3nljO9S","zH4hTdyLm1","l42VwK1o3V","zjfe3PN5o1","drh0jEPrxJ","TYt7qAp3bO","P4OA1ROYFa","MkExFLFQr4","EGDbzgdJ6o","WttwRgshCG","vdP8GhwNs1","qEsfQ3DBrI","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV"]

hi.count

["1AnOYcUHoQ","1FhmLTjWjr","3zrbEV4Wqo","41LHfIRYp0","4xVhxjxARY","5FMg5eZvEO","5qfRYcwCxW","6DCBEZuwgB","6H1b6HrJ07","6t4J21oNWc","7VqcDFBlpj","8Cb2kgGVMD","9HhRFxSnqm","9NXeaZzjPb","9jJWSzbi9A","AbMha3fy6j","CD7mr9qt4M","CO3tEUAFGM","EGDbzgdJ6o","EYBQ8QkCRS","F3N1Samqyh","HDoiZZLpfk","IH9N6OjH1M","IaTSYcAGEI","IhZVUIitF8","ImIE4VS8CF","JTfFghVr4Q","KT4WRSlbYj","LWkWRGpUyW","MJsUmoUYF3","MbHdCp1Uyf","MkExFLFQr4"]




































