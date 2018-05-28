//
//  MainNavigationController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 28/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let isLoggedIn = false
        
        if isLoggedIn {
            //Logged In
        } else {
            let logincontroller = LoginViewController()
            present(logincontroller, animated: true) {
                //code here later
            }
        }
        
        
    }

}
