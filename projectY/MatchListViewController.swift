//
//  MatchListViewController.swift
//
//
//  Created by Philip Ondrejack on 11/29/15.
//
//

import UIKit
import Parse
import Branch
import MessageUI

var user = PFUser.currentUser()
var userMatches = [PFObject]()

class MatchListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate {
    
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
        
        drawGetMatchButtons(self)
        
        checkForUser(self) { () -> () in
            
            queryForLiveMatches({ (matches) -> () in
                
                userMatches = matches!
                self.matchTableView.reloadData()
                self.matchTableView.setNeedsLayout()
                
            })
            
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        matchTableView.frame.size.width = self.view.frame.width
        matchTableView.frame.size.height = self.view.frame.height * 0.75
        matchTableView.frame.origin.y = self.view.frame.height * 0.10
        matchTableView.frame.origin.x = centerXAlignment(matchTableView, masterView: self.view)
        matchTableView.backgroundColor = backgroundColor
        
        print("these are the globals\(deepLinkChallengeUser), \(deepLinkChallengeUserDisplayName)")
        
        matchTableView.setNeedsDisplay()
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userMatches.count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return self.view.frame.height * 0.20
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MatchTableViewCell = self.matchTableView.dequeueReusableCellWithIdentifier("matchCell", forIndexPath: indexPath) as! MatchTableViewCell
        
        cell.matchDetails = userMatches[indexPath.row]
        
        return cell
        
    }
    
    
    var couldNotMatch = "false"
    
    func inviteToMatch(sender: AnyObject) {
        
        let messageComposeVC = MFMessageComposeViewController()
        
        func canSendText() -> Bool {
            
            print("blue")
            
            return MFMessageComposeViewController.canSendText()
        }
        
        if canSendText() {
        
            messageComposeVC.messageComposeDelegate = self
        
            prefillMessageBody(couldNotMatch, completion: { (url) -> Void in
                
                messageComposeVC.body = "Challenge delivered! \n \(url)"
                
                self.presentViewController(messageComposeVC, animated: true, completion: nil)
                
            })
            
        } else {
            
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            
            errorAlert.show()
        }
        
    }
    
    
    var count = 0
    
    func getNewMatch() {
        
        print("getting new match")
        
        queryForNewMatch(self) { (matchObject) -> Void in
            
            if matchObject == nil && self.count <= 2 {
                
                self.getNewMatch()
                
                ++self.count
                
            } else if matchObject != nil {
                
                // launch match
                
                self.count = 0
                
            } else if matchObject == nil && self.count > 2 {
                
                createNewMatch(user?.objectId, challengedUserID: "pending", challengedUserDisplayName: "pending", completion: { (matchID) -> Void in
                    
                    self.couldNotMatch = "true"
                    
                    print("invite a friend")
                    
                    //prompt user to invite friend while they wait
                    
                })
                
            }
        }
        
    }
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        print(result)
        
        switch result.rawValue {
            
        case MessageComposeResultSent.rawValue:
            print("cancelado")
            
            delay(1.5) { () -> () in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
        case MessageComposeResultCancelled.rawValue :
            
            print("canceled...")
            delay(1.5) { () -> () in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        case MessageComposeResultFailed.rawValue :
            print("fail...")
            
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Try again in a moment", delegate: self, cancelButtonTitle: "OK")
        
            errorAlert.show()
            
        default:
            print("default...")
            
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Try again in a moment", delegate: self, cancelButtonTitle: "OK")
            
            errorAlert.show()
            
        }
        
        
    }
    
        
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
