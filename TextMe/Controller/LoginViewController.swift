//
//  LoginViewController.swift
//  TextMe
//
//  Created by Michail Mishev on 6/12/17.
//  Copyright © 2017 Michail Mishev. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func loginPressed(_ sender: Any) {
        
        // login the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Login Successful!")
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
        }
        
    }
    

}




