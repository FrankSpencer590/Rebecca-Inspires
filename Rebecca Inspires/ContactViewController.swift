//
//  ContactViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 21/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    @IBAction func Twitter(_ sender: Any) {
        if let url = URL(string: "http://www.google.com") {
            UIApplication.shared.open(url, options: [:])
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
