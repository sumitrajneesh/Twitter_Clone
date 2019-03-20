//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Apple on 19/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewTweetViewController: UIViewController ,UITextFieldDelegate,UITextViewDelegate{
    
    
    @IBOutlet weak var newTweetTextView: UITextView!
    
    //Create a reference to the database
    
    var databaseRef = Database.database().reference()
    
    var loggedInUser: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loggedInUser = Auth.auth().currentUser
        
        newTweetTextView.textContainerInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 30)
        
        newTweetTextView.text = "what is happening?"
        newTweetTextView.textColor = UIColor.lightGray
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(newTweetTextView.textColor == UIColor.lightGray){
            newTweetTextView.text = ""
            newTweetTextView.textColor = UIColor.black
            
        }
    }
    

    @IBAction func didTapCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func didTapTweet(_ sender: Any) {
        
        if(newTweetTextView.text.characters.count>0){
            let key = self.databaseRef.child("tweets").childByAutoId().key
            
            let childUpdates = ["/tweets/\(self.loggedInUser!.uid)\( key)/text":newTweetTextView.text,"/tweets/\( self.loggedInUser!.uid)\( key)/timestamp":"\(NSDate().timeIntervalSince1970)"] as [String : Any]
            
            
            self.databaseRef.updateChildValues(childUpdates)
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
}
