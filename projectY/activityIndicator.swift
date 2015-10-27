//
//  activityIndicator.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/23/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit



class SquaresActivityIndicator {
    
    var containerView = UIView()
    var smallestRect = UIView()
    var smallRect = UIView()
    var midRect = UIView()
    var largeRect = UIView()
    var largestRect = UIView()
    
    func layoutActivityIndicator(masterView: UIView, percentageSize: CGFloat, activityBorderWidth: CGFloat) -> UIView {
        
        let viewHeight = masterView.frame.height
        let viewWidth = masterView.frame.width
        let viewHeightPercentage = viewHeight/100
        let viewWidthPercentage = viewWidth/100
        
        
        func drawSquareRectOffView(view: UIView, masterView: UIView, heightPercentage: CGFloat,  widthPercentage: CGFloat) -> UIView {
            
            let masterHeight = masterView.frame.height
            let masterWidth = masterView.frame.height
            let onePercentOfWidth = masterWidth/100
            let onePercentOfHeight = masterHeight/100
            
            view.frame = CGRectMake(0.0, 0.0, onePercentOfWidth * widthPercentage, onePercentOfHeight * heightPercentage)
            
            return view
            
        }
        
        
        func createView(subView: UIView, mView: UIView, pSizeWidth: CGFloat, pSizeHeight: CGFloat, borderWidth: CGFloat, cornerRadiusPercentage: CGFloat) -> UIView {
            
            var sView = UIView()
            sView = drawSquareRectOffView(subView, mView, pSizeWidth, pSizeWidth)
            mView.addSubview(sView)
            sView.layer.borderWidth = borderWidth
            sView.layer.cornerRadius = borderWidth * cornerRadiusPercentage
            sView.alpha = 0.0
            
            println(sView.frame.size)
            
            return sView
            
        }
        
        containerView = createView(containerView, masterView, percentageSize, percentageSize, activityBorderWidth, 1.0)
        largestRect = createView(largestRect, containerView, 100, 100, (activityBorderWidth * 1.0), 1.0)
        largeRect = createView(largeRect, containerView, 80, 80, (activityBorderWidth * 0.8), 0.8)
        midRect = createView(midRect, containerView, 60, 60, (activityBorderWidth * 0.6), 0.6)
        smallRect = createView(smallRect, containerView, 40, 40, (activityBorderWidth * 0.4), 0.4)
        smallestRect = createView(smallestRect, containerView, 20, 20, (activityBorderWidth * 0.3), 0.3)
        
        smallestRect.frame.origin = alignViewCenterYX(smallestRect, containerView)
        smallRect.frame.origin = alignViewCenterYX(smallRect, containerView)
        midRect.frame.origin = alignViewCenterYX(midRect, containerView)
        largeRect.frame.origin = alignViewCenterYX(largeRect, containerView)
        largestRect.frame.origin = alignViewCenterYX(largestRect, containerView)
        containerView.frame.origin = alignViewCenterYX(containerView, masterView)
        
        
        smallestRect.layer.borderColor = highestColor.CGColor
        smallRect.layer.borderColor = highColor.CGColor
        midRect.layer.borderColor = midColor.CGColor
        largeRect.layer.borderColor = lowColor.CGColor
        largestRect.layer.borderColor = lowestColor.CGColor
        containerView.layer.borderColor = UIColor.clearColor().CGColor
        
        return containerView
        
    }

    
    func animate(view1: UIView, view2: UIView, view3: UIView, view4: UIView, view5: UIView) {
        
        let duration = 0.3
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            view1.alpha = 0.5
            
        }) { (Bool) -> Void in
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                view1.alpha = 1.0
                view2.alpha = 0.5
                
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(duration, animations: { () -> Void in
                    
                    view2.alpha = 1.0
                    view3.alpha = 0.5
                    
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(duration, animations: { () -> Void in
                        
                        view1.alpha = 0.5
                        view3.alpha = 1.0
                        view4.alpha = 0.5
                        
                        
                    }, completion: { (Bool) -> Void in
                        
                        
                        UIView.animateWithDuration(duration, animations: { () -> Void in
                            
                            view1.alpha = 0.0
                            view2.alpha = 0.5
                            view3.alpha = 0.5
                            view4.alpha = 1.0
                            view5.alpha = 0.5
                            
                        }, completion: { (Bool) -> Void in
                            
                            UIView.animateWithDuration(duration, animations: { () -> Void in
                                
                                view2.alpha = 0.0
                                view3.alpha = 0.0
                                view4.alpha = 0.5
                                view5.alpha = 1.0
                                
                            }, completion: { (Bool) -> Void in
                                
                                self.animate(view1, view2: view2, view3: view3, view4: view4, view5: view5)
                                
                                UIView.animateWithDuration(duration, animations: { () -> Void in
                                    
                                    view4.alpha = 0.0
                                    view5.alpha = 0.5
                                    
                                    
                                }, completion: { (Bool) -> Void in
                                    
                                    UIView.animateWithDuration(duration, animations: { () -> Void in
                                        
                                        view5.alpha = 0.0
                                        
                                    }, completion: { (Bool) -> Void in
                                        
                                        
                                        
                                    })
                                    
                                })
                            })
                            
                        })
                        
                    })
                    
                    
                })
                
                
            })
            
            
        }
        
        
        
    }
    
    

    
    func runIndicator(masterView: UIView, percentageSize: CGFloat, activityBorderWidth: CGFloat) -> UIView {
        
        self.layoutActivityIndicator(masterView, percentageSize: percentageSize, activityBorderWidth: activityBorderWidth)
        
        self.containerView.alpha = 1.0
        
        self.animate(self.smallestRect, view2: self.smallRect, view3: self.midRect, view4: self.largeRect, view5: self.largestRect)
            
        return containerView
        
    }
    
    
    func fullScreenOverlayIndicator(masterView: UIView, title: String) {
        
        let overlayView = UIView()
        overlayView.frame = masterView.bounds
        masterView.addSubview(overlayView)
        overlayView.tag = 123
        
        overlayView.alpha = 0.0
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = masterView.bounds
        overlayView.addSubview(blurEffectView)
        
        var indicator = runIndicator(overlayView, percentageSize: 18, activityBorderWidth: 5)
        indicator.frame.origin.y = centerYAlignment(indicator, overlayView) - (indicator.frame.height/2)
        indicator.frame.origin.x = centerXAlignment(indicator, overlayView)
        indicator.tag = 124
        overlayView.addSubview(indicator)
        
        
        let label = UILabel()
        label.text = title
        label.textColor = lightColoredFont
        label.font = fontMedium
        overlayView.addSubview(label)
        label.sizeToFit()
        label.frame.origin.x = centerXAlignment(label, overlayView)
        label.frame.origin.y = indicator.frame.maxY + 20
        
        overlayView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        overlayView.alpha = 1.0
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            overlayView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
        })
        
        
    }
    
    
    
    func stopIndicator(masterView: UIView) {
        
        let viewToRemove = masterView.viewWithTag(123)
        let indicatorView = viewToRemove?.viewWithTag(124)
        
        viewToRemove?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            viewToRemove?.alpha = 0.0
            
        }) { (Bool) -> Void in
            
            viewToRemove?.removeFromSuperview()
            
        }
        
    }
    
    
    func replaceButtonWithActivityIndicator(masterView: UIView, button: UIView, percentageSize: CGFloat, borderWidth: CGFloat) {
        
        button.alpha = 0.0
        
        let indicator = self.runIndicator(masterView, percentageSize: percentageSize, activityBorderWidth: borderWidth)
        indicator.hidden = true
        indicator.tag = 123
        let indicatorXOffset = button.frame.midX - (indicator.frame.width/2)
        let indicatorYOffset = button.frame.midY - (indicator.frame.height/2)
        indicator.frame.origin = CGPoint(x: indicatorXOffset, y: indicatorYOffset)
        indicator.hidden = false
        masterView.addSubview(indicator)
        
        
        
    }
    
    
}





















