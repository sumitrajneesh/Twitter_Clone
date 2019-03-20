//
//  SignUpViewController.swift
//  Twitter
//
//  Created by Apple on 15/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signUp: UIBarButtonItem!
    
    @IBOutlet weak var errorMessage: UILabel!
    var databaseRef = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.isEnabled = false

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapSignup(_ sender: Any) {
        
        signUp.isEnabled = false
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: {( user ,  error ) in
            if(error != nil){
                if(error!._code == 17999){
                    
                    self.errorMessage.text = "Invalide Email Address"
                    
                } else {
                    self.errorMessage.text = error?.localizedDescription
                }
            } else {
                self.errorMessage.text = " Registered Successfully"
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: {(user, error) in
                    
                    if(error == nil){
                        self.databaseRef.child("user_profiles").child(user!.user.uid).child("email").setValue(self.email.text!)
                        
                        self.performSegue(withIdentifier: "HandleViewSegue", sender: nil)
                    }
                    
                })
                
                
            }
        
        })
        
    }
    
    @IBAction func textDidChanged(_ sender: UITextField) {
        
        
        if(email.text!.characters.count > 0 && password.text!.characters.count > 0){
            
            signUp.isEnabled = true
            
            
        } else {
            signUp.isEnabled = false
            
        }
            
            
            
        }
    
}
