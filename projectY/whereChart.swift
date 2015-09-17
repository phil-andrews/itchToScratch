//
//  whereChart.swift
//  projectY
//
//  Created by Philip Ondrejack on 9/10/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Charts
import Parse
import ParseUI

var whereChartValues = [Int]()
var whereChartLocationNames = [String]()
var locationLabel1 = UILabel()
var locationLabel2 = UILabel()
var locationLabel3 = UILabel()
var locationLabel4 = UILabel()
var locationLabel5 = UILabel()

var bar1 = UIButton()
var bar2 = UIButton()
var bar3 = UIButton()
var bar4 = UIButton()
var bar5 = UIButton()

var answerCount1 = SpringButton()
var answerCount2 = SpringButton()
var answerCount3 = SpringButton()
var answerCount4 = SpringButton()
var answerCount5 = SpringButton()


let locationBars = [bar1, bar2, bar3, bar4, bar5]
let locationLabels = [locationLabel1, locationLabel2, locationLabel3, locationLabel4, locationLabel5]
let answerCountLabels = [answerCount1, answerCount2, answerCount3, answerCount4, answerCount5]

public class PPChart {
    
    func makeWhereChart(playedAreasDict: [String:Int], contentView: UIView, parentView: UIView, locationObjects: [PFObject], completion: () -> Void) {
        
            var totalAnswers = 0
            
            for item in playedAreasDict.values {
                
                totalAnswers = totalAnswers + item
                
            }
                
                
            if totalAnswers == 0 {
                    
                let hintView = UIImageView(frame: CGRectMake(0.0, 633.0, 320.0, 467.0))
                hintView.image = UIImage(named: "zeroDataWhereChart")
                contentView.addSubview(hintView)
                
                return
                    
            }
            
            if playedAreasDict.count == 1 {
                
                let hintView = UIImageView(frame: CGRectMake(0.0, 633.0, 320.0, 467.0))
                hintView.image = UIImage(named: "oneDataWhereChart")
                contentView.addSubview(hintView)
                
            }
            
            var scale = setChartScale(totalAnswers)
            var keys = [String]()
            var values = [Int]()
            
            if playedAreasDict.count >= 5 {
                
                keys = playedAreasDict.sortedKeysByValue(>)
                
                for index in 0..<keys.count {
                    
                    let key: String = keys[index] as String
                    
                    let value: Int = playedAreasDict[key]!
                    
                    keys.append(key)
                    values.append(value)
                    
                    
                }
                
            } else if playedAreasDict.count < 5 {
                
                for index in 0..<playedAreasDict.count {
                    
                    let keysArray = Array(playedAreasDict.keys)
                    
                    let key: String = keysArray[index]
                    keys.insert(key, atIndex: 0)
                    
                    let keyValue: Int = playedAreasDict[key]!
                    values.insert(keyValue, atIndex: 0)
                    
                }
                
            }
                
                for index in 0..<keys.count {
                    
                    for item in locationObjects {
                                            
                        if item.objectId == keys[index] {
                            
                            let locationName = item.valueForKey(locality) as! String
                            
                            whereChartLocationNames.insert(locationName, atIndex: index)
                            
                        }
                        
                    }
                    
                }
                
            
            whereChartValues = values
            
            let colors = [lowestColor, lowColor, midColor, highColor, highestColor]
        
            let parentFrameHeightPercentageOffset: CGFloat = (parentView.frame.height/100) * 5
        
            println(parentFrameHeightPercentageOffset)
            
            let height: CGFloat = 41.0
            var width = CGFloat()
            let xCord: CGFloat = -2.0
            var yCord: CGFloat = parentView.frame.height + parentFrameHeightPercentageOffset
        
        println(yCord)
            
            var count = 0
            
            for item in values {
                
                width = CGFloat(item) * CGFloat(scale)
                
                var bar = locationBars[count]
                bar.frame = CGRectMake(xCord, yCord, width, height)
                bar.userInteractionEnabled = true
                bar.enabled = true
                bar.backgroundColor = colors[count]
                bar.addTarget(Accounts().childView, action: "whereChartBarPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                bar.tag = count
                bar.alpha = 0.0
                bar.center.x -= bar.bounds.width
             
                contentView.addSubview(bar)
       
                var numberLabelXCord = width + 10.0
                var numberLabelYCord = yCord + 6.0
                var numberLabelWidth = CGFloat(28.0)
                var numberLabelHeight = CGFloat(29.0)
            
                answerCountLabels[count].frame = CGRectMake(numberLabelXCord, numberLabelYCord, numberLabelWidth, numberLabelHeight)
                answerCountLabels[count].setTitle(String(item), forState: .Normal)
                answerCountLabels[count].titleLabel?.font = robotoRegular20
                answerCountLabels[count].titleLabel?.text = String(item)
                answerCountLabels[count].titleLabel?.textColor = lightColoredFont
                answerCountLabels[count].addTarget(Accounts().childView, action: "whereChartBarPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                
                answerCountLabels[count].titleLabel!.alpha = 0.0
                
                contentView.addSubview(answerCountLabels[count])
                
                yCord = yCord + 80.0
                
                ++count
                
            }
                
                contentView.addSubview(locationLabel1)
                contentView.addSubview(locationLabel2)
                contentView.addSubview(locationLabel3)
                contentView.addSubview(locationLabel4)
                contentView.addSubview(locationLabel5)
                

            completion()
        
    }
        
        func handleButtonPress(sender: UIButton) {
            
            println("button was pressed")
            
        }


    func setChartScale(totalAnswers: Int) -> Int {
        
        var scale = Int()
        let areaWidth = 300
        
        println(totalAnswers)
        switch(totalAnswers) {
            
        case 0...25:
            
            scale = areaWidth/15
            
        case 26...75:
            
            scale = areaWidth/65
            
        case 76...150:
            
            scale = areaWidth/140
            
        case 151...250:
            
            scale = areaWidth/250
            
        case 251...400:
            
            scale = areaWidth/390
            
        case 401...600:
            
            scale = areaWidth/590
            
        case 601...800:
            
            scale = areaWidth/790
            
        case 801...1000:
            
            scale = areaWidth/990
            
        default:
            
            scale = 100
            
        }
        
        return scale
        
    }


    func queryForPlacesPlayed(completion: (locationObjects: [PFObject], playedAreasDict: [String:Int]) -> Void) {
        
        let user = PFUser.currentUser()
        var locationArray = user?.valueForKey(whereUserAnswered) as! NSArray
        
        var locationArrayCount = NSMutableArray()
        var locationArraySingleIds = NSMutableArray()
        
        for item in locationArray {
            
            locationArrayCount.addObject(item.count)
            locationArraySingleIds.addObject(item[0])
        }
        
        var locationDict = [String: Int]()
        
        for index in 0..<locationArray.count {
            
            var id = locationArraySingleIds[index] as! String
            var locationCount = locationArrayCount[index] as! Int
            
            locationDict[id] = locationCount
        }
        
        let sortedDictKeys = locationDict.sortedKeysByValue(>)
        
        let query = PFQuery(className: LocationClass)
        query.whereKey(objectId, containedIn: sortedDictKeys)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    completion(locationObjects: objects, playedAreasDict: locationDict)
                    
                }
            } else if error != nil {
                
                println(error!.localizedDescription)
            }
            
        }
        
    }

}


