//
//  postLoginPictureGet.swift
//  projectY
//
//  Created by Philip Ondrejack on 10/27/15.
//  Copyright (c) 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI
import Bolts


class PostLoginPictureGetController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagePicker.delegate = self
        
        
        
        
    }
    
    
    
    func checkForUser() {
        
        if PFUser.currentUser() == nil {
            
            var loginStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            var loginViewController: LoginViewController = storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
            
        } else if PFUser.currentUser() != nil {
            
            
            
            // show/change picture
            
            
        }
        
    }
    
    
    
    func drawInterface() {
        
        let containerView = UIView()
        let proPicImageView = UIImageView()
        
        containerView.frame = self.view.bounds
        
        drawPercentageRectOffView(proPicImageView, containerView, 30, 30)
        
        containerView.addSubview(proPicImageView)
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

