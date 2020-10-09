//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Chirag Kaudan on 10/1/20.
//  Copyright © 2020 fmoonlclassic. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passworldField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.presentingViewController?.modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
    }
    
  /*  override func viewWillDisappear(_ animated: Bool) {
        usernameField.text = nil
        passworldField.text = nil
    }
        //clear text fields
    //} */
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passworldField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        {
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
                
            } else {
                 print("Error: \(error!.localizedDescription)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //if let destinationVC = segue.destination as? FeedViewController {
          //  destinationVC.modalPresentationStyle = .fullScreen
        //}
    }
    
    @IBAction func onSignUp(_ sender: Any) {
   
    let user = PFUser()
        user.username = usernameField.text
        user.password = passworldField.text
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Error: \(error!.localizedDescription)")
        }
    
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
