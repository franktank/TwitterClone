//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/14/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var tweets: [Tweet]?
    var user: User?
    var tweet:Tweet!
    var currentUser = true
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(currentUser){
            TwitterClient.sharedInstance.userDetails() { (user, error) -> () in
                self.user = user
                self.nameLabel.text = "\(user.name!)"
                self.profileImageView.setImageWithURL(user.profileImageURL!)
                
                self.tagLabel.text = "\(user.tagline!)"
                self.followingCountLabel.text = "\(user.friendsCount!)"
                self.followersCountLabel.text = "\(user.followersCount!)"
                
                
                
                
            }
            
        } else {
            self.nameLabel.text = "\(tweet.user!.name!)"
            self.profileImageView.setImageWithURL(tweet.user!.profileImageURL!)
            
            self.tagLabel.text = "\(tweet.user!.tagline!)"
            self.followingCountLabel.text = "\(tweet.user!.friendsCount!)"
            self.followersCountLabel.text = "\(tweet.user!.followersCount!)"
            
            
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickSignOut(sender: AnyObject) {
        User.currentUser?.logout()
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
