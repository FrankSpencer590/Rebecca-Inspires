//
//  SignupViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 17/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {
    @IBOutlet weak var emailreg: UILabel!
    @IBOutlet weak var passmatch: UILabel!
    @IBOutlet weak var usernametaken: UILabel!
    @IBOutlet weak var MissingField: UILabel!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var Surname: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Emailaddress: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var DoneButton: UIButton!
    
    
    @IBAction func DoneClicked(_ sender: Any) {
        emailreg.isHidden = true
        passmatch.isHidden = true
        usernametaken.isHidden = true
        MissingField.isHidden = true
        if (FirstName.text!) == ""{
            MissingField.isHidden = false
        }
        else {
            if (Surname.text!) == ""{
                MissingField.isHidden = false
            }
            else {
                if (Username.text!) == ""{
                    MissingField.isHidden = false
                }
                else {
                    if (Emailaddress.text!) == ""{
                        MissingField.isHidden = false
                    }
                    else {
                        if (Password.text!) == ""{
                            MissingField.isHidden = false
                        }
                        else {
                            if (ConfirmPassword.text!) == ""{
                                MissingField.isHidden = false
                            }
                            else {
                                if MyData.sharedInstance.usernames.contains(Username.text!) {
                                    usernametaken.isHidden = false
                                }
                                else{
                                    if ((MyData.sharedInstance.logindetails[Emailaddress.text!]) != nil) {
                                        emailreg.isHidden = false
                                    }
                                    else{
                                        if (Password.text!) == (ConfirmPassword.text!) {
                                            //Perfect Signup
                                            DoneButton.isHidden = true

                                            
                                            MyData.sharedInstance.logindetails[Emailaddress.text!] = Password.text!
                                            MyData.sharedInstance.names[FirstName.text!] = Surname.text!
                                            MyData.sharedInstance.usernames.append(Username.text!)
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                            present(vc, animated: true, completion: nil)
                                            print("Sign Up Complete")
                                            
                                            let context = (UIApplication.shared.delegate as! AppDelegate).persistantCotainer.viewContext
                                            let entity = NSEntityDescription.entity(forEntityName: "UserLogin", in: context)
                                            let NewEntity = NSManagedObject(entity: entity!, insertInto: context)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        else{
                                            passmatch.isHidden = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
