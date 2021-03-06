//
//  TwitterClient.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/2/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "9D61M6aUOU05TqThELYEV4MkF"
let twitterConsumerSecret = "k9OsuJONj9PWtdTfKIHJgMCuoU0BucvdsOM4s3jFZGTDCmvOf9"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
                GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            for tweet in tweets {
                print("text: \(tweet.text), created: \(tweet.createdAt)")
            }
    
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("It did not work")
                completion(tweets: nil, error: error)
                
        
        })
    }
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                        }
    }
    
    func openURL(url: NSURL) {
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress:nil, success:{ (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                print("It worked!")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user:user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting user")
                    self.loginCompletion?(user:nil, error:error)
            })
            
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user:nil, error: error)
        }
    }
    
    func addFavorite(id: String) {
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(id)", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Favorited!")
            }) { (operation:NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to favorite")
        }
    }
    
    func removeFavorite(id: String){
        TwitterClient.sharedInstance.POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Unfavorited!")
            }) { (operation:NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to unfavorite")
        }
    }
    
    func addRetweet(id: String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                print("Failed to retweet")
        }
    }
    
    func removeRetweet(id: String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/unretweet/\(id).json", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully unretweeted")
            }) { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                print("Failed to unretweet")
        }
    }
    
    func composeTweet(message: String){
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(message)", parameters:nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Composed successfully")
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to compose")
                
        }
    }
    
    func userDetails(completion: (user:User, error:NSError?) -> ()) {
        TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress:nil, success:{ (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            print("It worked!")
            var user = User(dictionary: response as! NSDictionary)
            User.currentUser = user
            print("user: \(user.name)")
            completion(user:user, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting user")
                self.loginCompletion?(user:nil, error:error)
        })
    }
}