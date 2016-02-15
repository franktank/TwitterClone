//
//  ComposeViewController.swift
//  TwitterClone
//
//  Created by Franky Liang on 2/14/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickSend(sender: AnyObject) {
        if(msgTextField.text != nil){
        let message = msgTextField.text
            
           TwitterClient.sharedInstance.composeTweet(message!)
        }
        
        
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
