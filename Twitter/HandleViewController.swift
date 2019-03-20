//
//  HandleViewController.swift
//  Twitter
//
//  Created by Apple on 15/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HandleViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    
    
    @IBOutlet weak var handle: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    
    
    @IBOutlet weak var startTweeting: UIBarButtonItem!
    
    var user: AnyObject?
    var rootRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = Auth.auth().currentUser
        
        
        
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapStartTweeting(_ sender: Any) {
        
        let handle = self.rootRef.child("handles").child(self.handle.text!).observe(.value, with: {(DataSnapshot) in
            if(!DataSnapshot.exists()){
                //update the handle in the users_profile and in the handles node
                self.rootRef.child("user_profiles").child(self.user!.uid).child("handle").setValue(self.handle.text!.localizedLowercase)
                
                //update the name of the user
                
                self.rootRef.child("user_profiles").child(self.user!.uid).child("name").setValue(self.fullName.text!)
                
                //update the handle in the handle node
                
                self.rootRef.child("handles").child(self.handle.text!.localizedLowercase).setValue(self.user?.uid)
                
                //send the user to home screen
                
                self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
                
            }
            else {
                self.errorMessage.text = "Handle already in use"
            }
        })
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
