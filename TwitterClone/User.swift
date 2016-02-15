//
//  User.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/6/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
var _currentUser: User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageURL: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    var favCount: Int?
    var followersCount: Int?
    var friendsCount: Int?
    var profileBackgroundColor: String?
    var profileBackgroundURL: String?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        favCount = dictionary["favourites_count"] as? Int
        screenname = dictionary["screen_name"] as? String
        let imageURLString = dictionary["profile_image_url"] as? String
        if imageURLString != nil {
            profileImageURL = NSURL(string: imageURLString!)
        } else {
            profileImageURL = nil
        }
        tagline = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        profileBackgroundURL = dictionary["profile_background_image_url"] as? String
        profileBackgroundColor = dictionary["profile_background_color"] as? String
    }
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    
    }
    class var currentUser: User? {
        get{
        if _currentUser == nil {
            var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
            if data != nil {
                do{
                    var dictionary =  try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                } catch {
        
                }
            }
        }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            if _currentUser != nil {
                do{
                    var data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options:[])
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
