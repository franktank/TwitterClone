//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/7/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import DateTools

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var twitterTagLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var retweet = false
    var favorite = false
    
    var tweet: Tweet! {
        
        didSet {
        
            nameLabel.text = tweet.user!.name
            timeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
            postLabel.text = tweet.text
            twitterTagLabel.text = "@"+(tweet.user?.screenname)!
            profilePictureImage.setImageWithURL((tweet.user?.profileImageURL)!)
            if(tweet.isFav == true) {
                favoriteButton.tintColor = UIColor.yellowColor()
            } else if (tweet.isFav == false) {
                favoriteButton.tintColor = UIColor.grayColor()
            }
            if(tweet.isRet == true) {
                retweetButton.tintColor = UIColor.blueColor()
            } else if (tweet.isRet == false) {
                retweetButton.tintColor = UIColor.grayColor()
            }
        
        }
    
    }
    
    @IBAction func onClickFav(sender: AnyObject) {
        favorite = !favorite
        if(favorite == true ) {
            tweet.user?.favCount = tweet.user!.favCount! + 1
             favoriteButton.tintColor = UIColor.yellowColor()
            TwitterClient.sharedInstance.addFavorite(tweet.id!)
            
        } else  {
            tweet.user?.favCount = tweet.user!.favCount! - 1
             favoriteButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeFavorite(tweet.id!)
            
        }
    }
  
    @IBAction func onClickRet(sender: AnyObject) {
        retweet = !retweet
        if(retweet == true) {
            tweet.retCount = tweet.retCount! + 1
            retweetButton.tintColor = UIColor.blueColor()
            TwitterClient.sharedInstance.addRetweet(tweet.id!)
        } else {
            tweet.retCount = tweet.retCount! - 1
            retweetButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeRetweet(tweet.id!)
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
