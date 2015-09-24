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
var whereChartKeysObjectIDs = [String]()
var userRankingsOverall = [Int]()
var userRankingPercentile = [Int]()

var percentileRankingLabel = UILabel()
var percentileRankingOverLabel = UILabel()

var overallRankingLabel = UILabel()
var overallRankingOverLabel = UILabel()

var statusLabel = UILabel()
var statusOverLabel = UILabel()

var checkmarkImage = UIView()


var bottomBackGround = UIView()

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
let answerCountLabels: [SpringButton] = [answerCount1, answerCount2, answerCount3, answerCount4, answerCount5]

public class PPChart {
    
    func makeWhereChart(playedAreasDict: [String:Int], contentView: UIView, parentView: UIView, locationObjects: [PFObject], completion: () -> Void) {
        
            var totalAnswers = 0
        
            println(playedAreasDict.count)
            
            for item in playedAreasDict.values {
                
                totalAnswers = totalAnswers + item
                
            }
        
            var hintView = UIImageView()
            let parentViewHeight = parentView.frame.height
            let parentViewPercentage = parentViewHeight/100
            let yCordHintImage = parentViewHeight + (parentViewPercentage * 20)
        
            if totalAnswers == 0 {
                    
                hintView = UIImageView(frame: CGRectMake(0.0, yCordHintImage, 320, 467))
                hintView.image = UIImage(named: "zeroDataWhereChart")
                contentView.addSubview(hintView)
                hintView.backgroundColor = UIColor.redColor()
                
                return
                    
            }
            
            if playedAreasDict.count == 1 {
                
                whereChartKeysObjectIDs = playedAreasDict.sortedKeysByValue(>)
                
                hintView = UIImageView(frame: CGRectMake(0.0, yCordHintImage, 320, 467.0))
                hintView.image = UIImage(named: "oneDataWhereChart")
                contentView.addSubview(hintView)
                hintView.backgroundColor = UIColor.redColor()

            }
        
            var scale = setChartScale(totalAnswers, view: contentView)
            var keys = [String]()
            var values = [Int]()
            
            if playedAreasDict.count >= 5 {
                
                hintView.hidden = true
                
                keys = playedAreasDict.sortedKeysByValue(>)
                
                for index in 0..<keys.count {
                    
                    let key: String = keys[index] as String
                    
                    let value: Int = playedAreasDict[key]!
                    
                    values.append(value)
                    
                    if index == 4 {
                        
                        whereChartKeysObjectIDs = keys
                        
                        break
                    }
                    
                    
                }
                
            } else if playedAreasDict.count < 5 {
                
                hintView.hidden = true
                
                for index in 0..<playedAreasDict.count {
                    
                    let keysArray = Array(playedAreasDict.keys)
                    
                    let key: String = keysArray[index]
                    keys.insert(key, atIndex: 0)
                    
                    let keyValue: Int = playedAreasDict[key]!
                    values.insert(keyValue, atIndex: 0)
                    
                    whereChartKeysObjectIDs = keys
                    
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
            
            let colors = [lowestColor, lowColor, midColor, highColor, orangeColor]
        
            let parentViewHeightPercentage = parentView.frame.height/100
        
            let parentFrameHeightPercentageOffset: CGFloat = parentViewHeightPercentage * 12.5
        
            let height: CGFloat = parentViewHeightPercentage * 12.5
            var width = CGFloat()
            let xCord: CGFloat = -2.0
            var yCord: CGFloat = parentView.frame.height + parentFrameHeightPercentageOffset
        
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
       
                var numberLabelXCord = width - 10.0
                var numberLabelWidth: CGFloat = 55.0
                var numberLabelHeight = height
                var numberLabelYCord = bar.center.y - (numberLabelHeight/2)
                
                answerCountLabels[count].frame = CGRectMake(numberLabelXCord, numberLabelYCord, numberLabelWidth, height)
                answerCountLabels[count].setTitle(String(item), forState: .Normal)
                answerCountLabels[count].setTitleColor(lightColoredFont, forState: .Normal)
                answerCountLabels[count].setTitle(String(item), forState: .Normal)
                answerCountLabels[count].setTitleColor(backgroundColor, forState: UIControlState.Selected)
                answerCountLabels[count].setTitle(String(item), forState: UIControlState.Highlighted)
                answerCountLabels[count].setTitleColor(backgroundColor, forState: UIControlState.Highlighted)
                answerCountLabels[count].titleLabel?.font = fontLarge
                answerCountLabels[count].titleLabel?.textAlignment = .Right
                
                answerCountLabels[count].addTarget(Accounts().childView, action: "whereChartBarPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                
                answerCountLabels[count].userInteractionEnabled = true
                
                answerCountLabels[count].tag = count
                
                answerCountLabels[count].titleLabel!.alpha = 0.0
                
                contentView.addSubview(answerCountLabels[count])
                contentView.sendSubviewToBack(answerCountLabels[count])
                
                yCord = yCord + height + (parentViewHeightPercentage)
                
                ++count
                
            }
        
            println(parentViewHeightPercentage)
            println(contentView.frame.height)
        
            bottomBackGround.frame = CGRectMake(0.0, parentViewHeightPercentage * 190, parentView.frame.width, parentViewHeightPercentage * 15)
            bottomBackGround.layer.borderWidth = 1.0
            bottomBackGround.layer.borderColor = UIColor.whiteColor().CGColor
        
            bottomBackGround.hidden = true
            checkmarkImage.hidden = true
        
            contentView.addSubview(bottomBackGround)
            contentView.sendSubviewToBack(bottomBackGround)
        
        
        
                contentView.addSubview(locationLabel1)
                contentView.addSubview(locationLabel2)
                contentView.addSubview(locationLabel3)
                contentView.addSubview(locationLabel4)
                contentView.addSubview(locationLabel5)
                contentView.addSubview(percentileRankingLabel)
                contentView.addSubview(overallRankingLabel)
                contentView.addSubview(statusLabel)
                contentView.addSubview(statusOverLabel)
                contentView.addSubview(percentileRankingOverLabel)
                contentView.addSubview(overallRankingOverLabel)
        
        
            findUserRanking(playedAreasDict)

            completion()
        
    }
        

    
    func findUserRanking(playedAreasDict: [String:Int]) {
        
        queryForUserRanking { (locationObjects) -> Void in
            
            for index in 0..<whereChartKeysObjectIDs.count {
                
                for item in locationObjects {
                    
                    if whereChartKeysObjectIDs[index] == item.objectId {
                        
                        let key = whereChartKeysObjectIDs[index]
                        let answerCount = playedAreasDict[key]
                        let allUsersAnswers = item.valueForKey(scoreRankingsKey) as! NSArray
                        
                        var count = 1
                        
                        for item in allUsersAnswers {
                            
                            if let item = item as? Int {
                                
                                if item > answerCount {
                                    
                                    ++count
                                    
                                }
                                
                            }
                            
                        }
                        
                        userRankingsOverall.insert(count, atIndex: index)

                        
                        let n = Double(allUsersAnswers.count)
                        
                        if n != 0 {
                            
                            let i = Double(count)
                            let percentile: Double = ((100 * i) / n)
                            round(percentile)
                            userRankingPercentile.insert(Int(percentile), atIndex: index)
                            
                        } else if n == 0 {
                            
                            userRankingPercentile.insert(1, atIndex: index)
                            
                        }

                        
                        
                    }
                    
                }
                
                
            }
            
            
            
        }
        
        
    }
    


    func setChartScale(totalAnswers: Int, view: UIView) -> Int {
        
        var scale = Int()
        let viewWidth = view.frame.width
        let viewWidthPercentage = view.frame.width/100
        let areaWidth = Int(viewWidth - (viewWidthPercentage * 20))
        
        switch(totalAnswers) {
            
        case 0...25:
            
            scale = areaWidth/25
            
        case 26...75:
            
            scale = areaWidth/50
            
        case 76...150:
            
            scale = areaWidth/150
            
        case 151...250:
            
            scale = areaWidth/250
            
        case 251...400:
            
            scale = areaWidth/400
            
        case 401...600:
            
            scale = areaWidth/500
            
        case 601...800:
            
            scale = areaWidth/100
            
        case 801...1000:
            
            scale = areaWidth/1000
            
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
    
    func queryForUserRanking(completion: (locationObjects: [PFObject]) -> Void) {
        
        let query = PFQuery(className: LocationClass)
        query.whereKey(objectId, containedIn: whereChartKeysObjectIDs)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    completion(locationObjects: objects)
                    
                }
                
            }

        }
        
    }

}


