//
//  LoginViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 15/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var emailaddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        if ((MyData.sharedInstance.logindetails[emailaddress.text!]) != nil) {
            MyData.sharedInstance.correctemail = true
            print(MyData.sharedInstance.logindetails[emailaddress.text!])
        }
        else{
            MyData.sharedInstance.correctemail = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoginButton.layer.cornerRadius = 30.0
        LoginButton.layer.masksToBounds = true
        SignUpButton.layer.cornerRadius = 30.0
        SignUpButton.layer.masksToBounds = true
        
        emailaddress.delegate = self
        password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
