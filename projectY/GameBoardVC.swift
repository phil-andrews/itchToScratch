//
//  GameBoardVC.swift
//  projectY
//
//  Created by Philip Ondrejack on 12/6/15.
//  Copyright © 2015 Philip Ondrejack. All rights reserved.
//

import Foundation
import UIKit
import Parse


class GameBoardVC: UIViewController {

    var matchObject : PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColor
        
        //print(matchObject!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
