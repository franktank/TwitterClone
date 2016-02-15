//
//  TweetDetailsViewController.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/9/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTag: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    var retweet = true
    var favorite = true
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retweet = tweet!.isRet!
        favorite = tweet!.isFav!
        nameLabel.text = tweet!.user!.name
        date.text = tweet!.createdAtString
        tweetLabel.text = tweet!.text
        nameTag.text = "@" + (tweet!.user?.screenname)!
        profilePicImageView.setImageWithURL((tweet!.user?.profileImageURL)!)
        if(tweet!.user!.favCount != nil){favCountLabel.text = String(tweet!.user!.favCount!)}
        if(tweet?.retCount != nil){retweetCount.text = "\(tweet!.retCount!)"}
        
        if(tweet!.isFav == true) {
            favoriteButton.tintColor = UIColor.yellowColor()
        } else if (tweet!.isFav == false) {
            favoriteButton.tintColor = UIColor.grayColor()
        }
        if(tweet!.isRet == true) {
            retweetButton.tintColor = UIColor.blueColor()
        } else if (tweet!.isRet == false) {
            retweetButton.tintColor = UIColor.grayColor()
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onRetweet(sender: AnyObject) {
        retweet = !retweet
        if(retweet == true) {
            tweet!.retCount = tweet!.retCount! + 1
            retweetButton.tintColor = UIColor.blueColor()
            TwitterClient.sharedInstance.addRetweet(tweet!.id!)
        } else {
            tweet!.retCount = tweet!.retCount! - 1
            retweetButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeRetweet(tweet!.id!)
        }
    }
    @IBAction func onFavorite(sender: AnyObject) {
        favorite = !favorite
        if(favorite == true ) {
            tweet!.user?.favCount = tweet!.user!.favCount! + 1
            favoriteButton.tintColor = UIColor.yellowColor()
            TwitterClient.sharedInstance.addFavorite(tweet!.id!)
            
        } else  {
            tweet!.user?.favCount = tweet!.user!.favCount! - 1
            favoriteButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeFavorite(tweet!.id!)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("it prepared for segue")
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
