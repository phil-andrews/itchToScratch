//
//  PaddedLabel.swift
//  
//
//  Created by Philip Ondrejack on 11/16/15.
//
//

import UIKit

class PaddedLabel15: UILabel {
    
    var topInset:       CGFloat = 0
    var rightInset:     CGFloat = 15.0
    var bottomInset:    CGFloat = 0
    var leftInset:      CGFloat = 15.0
    
    
    override func drawTextInRect(rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }

    
}


class PaddedLabel25: UILabel {
    
    var topInset:       CGFloat = 0
    var rightInset:     CGFloat = 25.0
    var bottomInset:    CGFloat = 0
    var leftInset:      CGFloat = 25.0
    
    
    override func drawTextInRect(rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
    
}