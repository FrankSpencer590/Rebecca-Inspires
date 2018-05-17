//
//  LoginViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 15/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var emailaddress: ShakingTextField!
    @IBOutlet weak var password: ShakingTextField!
    @IBOutlet weak var IncorrectLabel: UILabel!
    let transition = CircularTransition()
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
    
    
    
    @IBAction func Login(_ sender: Any) {
        if ((MyData.sharedInstance.logindetails[emailaddress.text!]) != nil) {
            MyData.sharedInstance.correctemail = true
            let expectedpassword = (MyData.sharedInstance.logindetails[emailaddress.text!])
            if expectedpassword == password.text! {
                MyData.sharedInstance.correctpassword == true
                IncorrectLabel.isHidden = true
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
                present(vc, animated: true, completion: nil)
            }
            else{
                MyData.sharedInstance.correctpassword = false
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoginButton.layer.cornerRadius = LoginButton.frame.size.width / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.width / 2
        
        emailaddress.delegate = self
        password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
