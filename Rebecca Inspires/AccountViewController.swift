//
//  AccountViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 10/06/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var Nicknametextfield: UITextField!
    @IBOutlet weak var nicknamebutton: UIButton!
    
    
    @IBAction func nicknamepressed(_ sender: Any) {
        Nicknametextfield.isHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //nicknamebutton.setTitle(Nicknametextfield.text, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Nicknametextfield.delegate = self
        
        
        // Do any additional setup after loading the view.
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        print("RETURN DETECTED")
        nicknamebutton.setTitle(Nicknametextfield.text, for: .normal)
        Nicknametextfield.isHidden = true
        
        Nicknametextfield.resignFirstResponder()
        return true
    }
    

}

