//
//  DetailViewController.swift
//  MeetupApi
//
//  Created by Jamar Gibbs on 4/16/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rsvpLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    var meetup = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(meetup)
        self.title = self.meetup["name"] as? String
        
//        self.nameLabel.textColor = UIColor.grayColor()
//        self.rsvpLabel.textColor = UIColor.grayColor()
//        self.groupLabel.textColor = UIColor.grayColor()
//        
//        self.nameLabel.text = self.meetup["name"] as? String
//        self.rsvpLabel.text = "Accepted RSVP's: \(String(self.meetup["yes_rsvp_count"]!.integerValue))"
        
//        self.groupLabel.text = "Group Name: \(self.meetup.objectForKey("group")!["name"] as! String)"
        
        let htmlString:String! = "<head><style>body { background-color: white } p { color: grey; }</style></head> \(self.meetup["description"] as! String)"
        
        self.webView.loadHTMLString(htmlString, baseURL: nil)
    }

    
    @IBAction func openWebPage(sender: UIButton) {
    
        let safariVC = SFSafariViewController(URL:NSURL(string: self.meetup["event_url"] as! String)!)
            safariVC.delegate = self
            self.presentViewController(safariVC, animated: true, completion: nil)
    }
    
}






