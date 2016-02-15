//
//  Tweet.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/6/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var isFav : Bool?
    var isRet : Bool?
    var retCount: Int?
    var id : String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        createdAtString = formatter.stringFromDate(createdAt!)
        id = dictionary["id_str"] as? String
        isFav = dictionary["favorited"] as? Bool
        isRet = dictionary["retweeted"] as? Bool
        retCount = dictionary["retweet_count"] as? Int
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
    
        return tweets
    }
}
