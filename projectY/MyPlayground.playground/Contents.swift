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


//let hi = ["ImIE4VS8CF","LWkWRGpUyW","vd5zkmFF3K","v667XU7MRx","phYYKOarj9","6DCBEZuwgB","5qfRYcwCxW","z3tZHNC4Iq","xUHqmhXuMj","IaTSYcAGEI","ts4JkJVQze","ukdWzQ6gZR","mpx1kfKD56","4xVhxjxARY","5FMg5eZvEO","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","6H1b6HrJ07","6t4J21oNWc","MbHdCp1Uyf","MJsUmoUYF3","9HhRFxSnqm","9NXeaZzjPb","tgt53X6tEj","1AnOYcUHoQ","8Cb2kgGVMD","7VqcDFBlpj","OIWYA5L240","QLWNqyA7wR","AbMha3fy6j","9jJWSzbi9A","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","ImIE4VS8CF","EYBQ8QkCRS","EGDbzgdJ6o","v667XU7MRx","phYYKOarj9","6DCBEZuwgB","5qfRYcwCxW","z3tZHNC4Iq","xUHqmhXuMj","CD7mr9qt4M","CO3tEUAFGM","ukdWzQ6gZR","mpx1kfKD56","4xVhxjxARY","5FMg5eZvEO","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","6H1b6HrJ07","6t4J21oNWc","MbHdCp1Uyf","MJsUmoUYF3","9HhRFxSnqm","9NXeaZzjPb","tgt53X6tEj","1AnOYcUHoQ","8Cb2kgGVMD","7VqcDFBlpj","OIWYA5L240","QLWNqyA7wR","AbMha3fy6j","9jJWSzbi9A","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","udNKIbuMJM","PrZtijrbAz","Sd37qzfN70","KT4WRSlbYj","6DCBEZuwgB","nCKv5hhkJa","JTfFghVr4Q","YybiAg6oIb","dXcgDAQYmH","RKVMiVL7o4","b0FxLBWm6e","mpKAqvI9nA","eOdIaAK1TZ","uyYYeQJe84","afbYqkIkIR","CO3tEUAFGM","IH9N6OjH1M","Wi18Pme5ti","QDBLbbmWgS","ewocukmo50","HDoiZZLpfk","VDCpiwhkeu","9jJWSzbi9A","bze3nljO9S","zH4hTdyLm1","l42VwK1o3V","zjfe3PN5o1","drh0jEPrxJ","TYt7qAp3bO","P4OA1ROYFa","MkExFLFQr4","EGDbzgdJ6o","WttwRgshCG","vdP8GhwNs1","qEsfQ3DBrI","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV"]
//
//hi.count
//
//["1AnOYcUHoQ","1FhmLTjWjr","3zrbEV4Wqo","41LHfIRYp0","4xVhxjxARY","5FMg5eZvEO","5qfRYcwCxW","6DCBEZuwgB","6H1b6HrJ07","6t4J21oNWc","7VqcDFBlpj","8Cb2kgGVMD","9HhRFxSnqm","9NXeaZzjPb","9jJWSzbi9A","AbMha3fy6j","CD7mr9qt4M","CO3tEUAFGM","EGDbzgdJ6o","EYBQ8QkCRS","F3N1Samqyh","HDoiZZLpfk","IH9N6OjH1M","IaTSYcAGEI","IhZVUIitF8","ImIE4VS8CF","JTfFghVr4Q","KT4WRSlbYj","LWkWRGpUyW","MJsUmoUYF3","MbHdCp1Uyf","MkExFLFQr4"]

let bingURL = "https://platform.bing.com/geo/spatial/v1/public/geodata?spatialFilter=GetBoundary(40.759211,-73.984638,1,%27PostCode1%27,0,0)&key=Ak8iBpYFiN2_M3vtEa2YFXiWbOJi6eypNwGnPZM_tdKjcFbZ5jJPme1jay12h46K&$format=json"

extension String
{
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = find(self, char) {
            return distance(self.startIndex, idx)
        }
        return nil
    }
}

let data = "1,9x6hjiuuvHDFpiaj4C_2Jy3Y5yW-tX5yWF4t8Bks4B6yXk5hKrkQjn-FuqnB_3Ng69B8z_Jm-H-yD2jB8vjCioL8DkG6ouEtHB-rBtnEgdqIliC6rDm_Bw2B_Bw2B1mDo2DmvB-mE1wDzCk-J_O3rBwoBkvBYiT-Q7rB8c5JpaiP_cCC4R1z0Hx-Bo3H1tDu1Ex1F17EhMw8Y5P9uMrklB7JmT_B8B2FCCDrD0G-FuC-F7D7D9Tx-BmtB73B8RDFDziBxD0pECrvEltOpjGsj1Blv7JxuY8olFD-lF20IngHlC1tD0gY4gBqzkB9uM"

let safeCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-"
//
//var point = [AnyObject]()
//var pointsArray = [AnyObject]()
//
//
//for char in data {
//
//    var num = safeCharacters.indexOfCharacter(char)
//    
//    if num < 32  {
//        
//        if num != nil {
//            
//            point.append(num!)
//            pointsArray.append(point)
//            point = []
//            
//        }
//        
//    } else {
//        
//        
//        
//    }
//}
//
//
//for point in pointsArray {
//    
//    var result = Int()
//    
//    
//    
//}


var array = [1,2,3,4,5,6,7]

var count = Double(8)
var totalCities = Double(13)


var percentile = (100 * (count - 0.5)) / totalCities



["1AnOYcUHoQ","1FhmLTjWjr","3zrbEV4Wqo","41LHfIRYp0","4xVhxjxARY","5FMg5eZvEO","5qfRYcwCxW","6DCBEZuwgB","6H1b6HrJ07","6t4J21oNWc","7VqcDFBlpj","8Cb2kgGVMD","9HhRFxSnqm","9NXeaZzjPb","9jJWSzbi9A","AbMha3fy6j","CD7mr9qt4M","CO3tEUAFGM","EGDbzgdJ6o","EYBQ8QkCRS","F3N1Samqyh","HDoiZZLpfk","IH9N6OjH1M","IaTSYcAGEI","IhZVUIitF8","ImIE4VS8CF","JTfFghVr4Q","KT4WRSlbYj","LWkWRGpUyW","MJsUmoUYF3","MbHdCp1Uyf","MkExFLFQr4","OIWYA5L240","P4OA1ROYFa","PbkZdRZL1Q","PrZtijrbAz","QDBLbbmWgS","QLWNqyA7wR","RKVMiVL7o4","Sd37qzfN70","TYt7qAp3bO","UNERSnxcVW","Uw0CsEwFlF","VDCpiwhkeu","Wi18Pme5ti","Ws1utRc8km","WttwRgshCG","YybiAg6oIb","afbYqkIkIR","b0FxLBWm6e","bze3nljO9S","dXcgDAQYmH","drh0jEPrxJ","eOdIaAK1TZ","ewocukmo50","gNaPadiiTC","k8CqxtaCOF","kka7A9bMi8","l42VwK1o3V","mpKAqvI9nA","mpx1kfKD56","nCKv5hhkJa","nYAMfVaw0a","nu3N2lBvrU"]


["ImIE4VS8CF","LWkWRGpUyW","vd5zkmFF3K","v667XU7MRx","phYYKOarj9","6DCBEZuwgB","5qfRYcwCxW","z3tZHNC4Iq","xUHqmhXuMj","IaTSYcAGEI","ts4JkJVQze","ukdWzQ6gZR","mpx1kfKD56","4xVhxjxARY","5FMg5eZvEO","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","6H1b6HrJ07","6t4J21oNWc","MbHdCp1Uyf","MJsUmoUYF3","9HhRFxSnqm","9NXeaZzjPb","tgt53X6tEj","1AnOYcUHoQ","8Cb2kgGVMD","7VqcDFBlpj","OIWYA5L240","QLWNqyA7wR","AbMha3fy6j","9jJWSzbi9A","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","ImIE4VS8CF","EYBQ8QkCRS","EGDbzgdJ6o","v667XU7MRx","phYYKOarj9","6DCBEZuwgB","5qfRYcwCxW","z3tZHNC4Iq","xUHqmhXuMj","CD7mr9qt4M","CO3tEUAFGM","ukdWzQ6gZR","mpx1kfKD56","4xVhxjxARY","5FMg5eZvEO","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","6H1b6HrJ07","6t4J21oNWc","MbHdCp1Uyf","MJsUmoUYF3","9HhRFxSnqm","9NXeaZzjPb","tgt53X6tEj","1AnOYcUHoQ","8Cb2kgGVMD","7VqcDFBlpj","OIWYA5L240","QLWNqyA7wR","AbMha3fy6j","9jJWSzbi9A","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","udNKIbuMJM","PrZtijrbAz","Sd37qzfN70","KT4WRSlbYj","6DCBEZuwgB","nCKv5hhkJa","JTfFghVr4Q","YybiAg6oIb","dXcgDAQYmH","RKVMiVL7o4","b0FxLBWm6e","mpKAqvI9nA","eOdIaAK1TZ","uyYYeQJe84","afbYqkIkIR","CO3tEUAFGM","IH9N6OjH1M","Wi18Pme5ti","QDBLbbmWgS","ewocukmo50","HDoiZZLpfk","VDCpiwhkeu","9jJWSzbi9A","bze3nljO9S","zH4hTdyLm1","l42VwK1o3V","zjfe3PN5o1","drh0jEPrxJ","TYt7qAp3bO","P4OA1ROYFa","MkExFLFQr4","EGDbzgdJ6o","WttwRgshCG","vdP8GhwNs1","qEsfQ3DBrI","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV"]


["ImIE4VS8CF","LWkWRGpUyW","vd5zkmFF3K","v667XU7MRx","phYYKOarj9","nu3N2lBvrU","JTfFghVr4Q","z3tZHNC4Iq","xUHqmhXuMj","IaTSYcAGEI","ts4JkJVQze","ukdWzQ6gZR","mpx1kfKD56","nYAMfVaw0a","afbYqkIkIR","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","bze3nljO9S","zH4hTdyLm1","MbHdCp1Uyf","MJsUmoUYF3","k8CqxtaCOF","Ws1utRc8km","tgt53X6tEj","rv1hPIZSEb","EGDbzgdJ6o","WttwRgshCG","OIWYA5L240","QLWNqyA7wR","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV","ImIE4VS8CF","LWkWRGpUyW","vd5zkmFF3K","v667XU7MRx","phYYKOarj9","nu3N2lBvrU","JTfFghVr4Q","z3tZHNC4Iq","xUHqmhXuMj","IaTSYcAGEI","ts4JkJVQze","ukdWzQ6gZR","mpx1kfKD56","nYAMfVaw0a","afbYqkIkIR","w0JFBNI8nM","x81zIhYYLE","Wi18Pme5ti","QDBLbbmWgS","UNERSnxcVW","Uw0CsEwFlF","qWmdxgXkzE","rYXYqhfgwV","bze3nljO9S","zH4hTdyLm1","MbHdCp1Uyf","MJsUmoUYF3","k8CqxtaCOF","Ws1utRc8km","tgt53X6tEj","1AnOYcUHoQ","1FhmLTjWjr","WttwRgshCG","OIWYA5L240","QLWNqyA7wR","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","41LHfIRYp0","3zrbEV4Wqo","udNKIbuMJM","PrZtijrbAz","Sd37qzfN70","KT4WRSlbYj","6DCBEZuwgB","nCKv5hhkJa","JTfFghVr4Q","YybiAg6oIb","dXcgDAQYmH","RKVMiVL7o4","b0FxLBWm6e","mpKAqvI9nA","eOdIaAK1TZ","uyYYeQJe84","afbYqkIkIR","CO3tEUAFGM","IH9N6OjH1M","Wi18Pme5ti","QDBLbbmWgS","ewocukmo50","HDoiZZLpfk","VDCpiwhkeu","9jJWSzbi9A","bze3nljO9S","zH4hTdyLm1","l42VwK1o3V","zjfe3PN5o1","drh0jEPrxJ","TYt7qAp3bO","P4OA1ROYFa","MkExFLFQr4","EGDbzgdJ6o","WttwRgshCG","vdP8GhwNs1","qEsfQ3DBrI","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV"]


["udNKIbuMJM","PrZtijrbAz","41LHfIRYp0","3zrbEV4Wqo","6DCBEZuwgB","nCKv5hhkJa","JTfFghVr4Q","YybiAg6oIb","dXcgDAQYmH","RKVMiVL7o4","1AnOYcUHoQ","1FhmLTjWjr","eOdIaAK1TZ","uyYYeQJe84","afbYqkIkIR","CO3tEUAFGM","IH9N6OjH1M","Wi18Pme5ti","QDBLbbmWgS","ewocukmo50","HDoiZZLpfk","VDCpiwhkeu","9jJWSzbi9A","bze3nljO9S","zH4hTdyLm1","l42VwK1o3V","zjfe3PN5o1","drh0jEPrxJ","TYt7qAp3bO","P4OA1ROYFa","MkExFLFQr4","EGDbzgdJ6o","WttwRgshCG","vdP8GhwNs1","qEsfQ3DBrI","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV","udNKIbuMJM","PrZtijrbAz","Sd37qzfN70","KT4WRSlbYj","6DCBEZuwgB","nCKv5hhkJa","JTfFghVr4Q","YybiAg6oIb","dXcgDAQYmH","RKVMiVL7o4","b0FxLBWm6e","mpKAqvI9nA","eOdIaAK1TZ","uyYYeQJe84","afbYqkIkIR","CO3tEUAFGM","IH9N6OjH1M","Wi18Pme5ti","QDBLbbmWgS","ewocukmo50","HDoiZZLpfk","VDCpiwhkeu","9jJWSzbi9A","bze3nljO9S","zH4hTdyLm1","l42VwK1o3V","zjfe3PN5o1","drh0jEPrxJ","TYt7qAp3bO","P4OA1ROYFa","MkExFLFQr4","EGDbzgdJ6o","WttwRgshCG","vdP8GhwNs1","qEsfQ3DBrI","5qfRYcwCxW","PbkZdRZL1Q","kka7A9bMi8","gNaPadiiTC","pAT70HLzIV","4xVhxjxARY","5FMg5eZvEO","6H1b6HrJ07","6t4J21oNWc","7VqcDFBlpj","8Cb2kgGVMD","9HhRFxSnqm","9NXeaZzjPb"]





























