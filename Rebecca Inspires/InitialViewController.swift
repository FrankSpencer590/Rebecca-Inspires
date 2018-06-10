//
//  InitialViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 10/06/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            
            
            print("Not first launch.")
            let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
            if loggedIn {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
                present(vc, animated: true, completion: nil)
            }
            
            
            
            
        }
            
        else {
            print("First launch, setting UserDefaults.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set(false, forKey: "loggedIn")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(vc, animated: true, completion: nil)
            
            
            
        }
    }
    

    

}
