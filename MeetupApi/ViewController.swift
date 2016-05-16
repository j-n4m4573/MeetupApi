//
//  ViewController.swift
//  MeetupApi
//
//  Created by Jamar Gibbs on 2/1/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var meetUpsReturn = NSDictionary()
    var meetUpArray = NSArray()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Meetups"
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.90, green:0.10, blue:0.22, alpha:0.1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Avenir-Book", size: 20)!]
        
        getData()
       }
    
    func getData(){
        let url = NSURL(string:"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            do {
                self.meetUpsReturn = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                self.meetUpArray = self.meetUpsReturn["results"] as! NSArray
                dispatch_async(dispatch_get_main_queue(),{ ()
                    -> Void in
                    self.tableView.reloadData()
                })
            }
            catch let error as NSError {
                print("There was an error with the JSON data 😟: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetUpArray.count
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        let meetup = meetUpArray[indexPath.row]
        cell.textLabel?.text = meetup["name"] as? String
        cell.textLabel?.textColor = UIColor.grayColor()
        cell.detailTextLabel?.text = meetup.objectForKey?("venue")?["address_1"] as? String
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! DetailViewController
        let path = tableView.indexPathForSelectedRow! as NSIndexPath
        destination.meetup = self.meetUpArray[path.row] as! NSDictionary
    }
}

   



