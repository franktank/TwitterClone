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

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var twitterTagLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var tweet: Tweet! {
        
        didSet {
        
            nameLabel.text = tweet.user!.name
            timeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
            postLabel.text = tweet.text
            twitterTagLabel.text = "@"+(tweet.user?.screenname)!
            profilePictureImage.setImageWithURL((tweet.user?.profileImageURL)!)
            
            
        
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
