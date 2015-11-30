//
//  MatchListViewController.swift
//
//
//  Created by Philip Ondrejack on 11/29/15.
//
//

import UIKit
import Parse

let user = PFUser.currentUser()

class MatchListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userMatches = [PFObject]()
    
    @IBOutlet weak var matchTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFonts(self.view)
        
        matchTableView.delegate = self
        matchTableView.dataSource = self
        matchTableView.editing = false
        matchTableView.sectionHeaderHeight = 0.0
        matchTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.backgroundColor = backgroundColor
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        matchTableView.frame.size.width = self.view.frame.width
        matchTableView.frame.size.height = self.view.frame.height * 0.80
        matchTableView.frame.origin.y = self.view.frame.height * 0.15
        matchTableView.frame.origin.x = centerXAlignment(matchTableView, self.view)
        matchTableView.backgroundColor = backgroundColor
        
        matchTableView.setNeedsDisplay()
        
        queryForLiveMatches { () -> () in
            
            self.matchTableView.reloadData()
            self.matchTableView.setNeedsLayout()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userMatches.count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return self.view.frame.height * 0.17
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MatchTableViewCell = self.matchTableView.dequeueReusableCellWithIdentifier("matchCell", forIndexPath: indexPath) as! MatchTableViewCell
        
        
        cell.matchDetails = userMatches[indexPath.row]

        if indexPath.row == 0 {
            
            cell.layer.shadowOpacity = 2.0
            cell.layer.shadowRadius = 2
            cell.layer.shadowOffset = CGSizeMake(0, 3)
            cell.layer.shadowColor = UIColor.blackColor().CGColor
            
        }
        
        
        return cell
        
    }
    
    
    func queryForLiveMatches(completion: () -> ()) {
        
        let query = PFQuery(className: "LiveMatches")
        query.findObjectsInBackgroundWithBlock { (matches, error) -> Void in
            
            if error == nil {
                
                if let matches = matches as? [PFObject] {
                    
                    self.userMatches = matches
                    
                    completion()
                    
                }
                
            }
            
        }

    }
    
    
    
}
