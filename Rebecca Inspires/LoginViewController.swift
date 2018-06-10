//
//  LoginViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 15/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var emailaddress: ShakingTextField!
    @IBOutlet weak var password: ShakingTextField!
    @IBOutlet weak var IncorrectLabel: UILabel!
    let transition = CircularTransition()
    override func viewDidLoad() {
        super .viewDidLoad()
        LoginButton.layer.cornerRadius = LoginButton.frame.size.width / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.width / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        LoginButton.layer.cornerRadius = LoginButton.frame.size.width / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.width / 2
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = LoginButton.center
        transition.circleColor = LoginButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = LoginButton.center
        transition.circleColor = LoginButton.backgroundColor!
        
        return transition
    }
    
    func login() {
        if ((MyData.sharedInstance.logindetails[emailaddress.text!]) != nil) {
            MyData.sharedInstance.correctemail = true
            let expectedpassword = (MyData.sharedInstance.logindetails[emailaddress.text!])
            if expectedpassword == password.text! {
                IncorrectLabel.isHidden = true
                UserDefaults.standard.set("true", forKey: "isLoggedin")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
                present(vc, animated: true, completion: nil)
                UserDefaults.standard.set(true, forKey: "loggedIn")
            }
            else{
                IncorrectLabel.isHidden = false
                password.shake()
            }
        }
        else{
            MyData.sharedInstance.correctemail = false
            IncorrectLabel.isHidden = false
            emailaddress.shake()
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        login()
    }
    
    private func textFieldShouldReturn(_ textField: ShakingTextField) -> Bool {
        print("return")
        login()
        textField.resignFirstResponder()
        return true
    }

}

