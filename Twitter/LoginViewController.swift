//
//  LoginViewController.swift
//  Twitter
//
//  Created by Apple on 15/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    var rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: {(user , error) in
            if(error == nil){
                
                self.rootRef.child("user_profiles").child((user?.user.uid)!).child("handle").observe(.value, with: {(DataSnapshot) in
                    if(!DataSnapshot.exists()){
                        //user doesnot have handle
                        //send the user to handleView
                        
                        self.performSegue(withIdentifier: "HandleViewSegue", sender: nil)
                        
                    }
                    else {
                        self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
                    }
                })
                
            }
            else {
                self.errorMessage.text = error?.localizedDescription
            }
        })
        
        
    }
    
}
