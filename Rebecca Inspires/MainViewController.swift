//
//  ViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 21/04/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var OtherButton: UIButton!
    @IBOutlet weak var ContactButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var TwitterQuotes: UILabel!
    let bucketName = "randomlistofquotes"
    let transition = CircularTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        ContactButton.layer.cornerRadius = ContactButton.frame.size.width / 2
        OtherButton.layer.cornerRadius = OtherButton.frame.size.width / 2
        
        //Pulling from Website
        if let url = URL(string: "https://s3.eu-west-2.amazonaws.com/randomlistofquotes/Rebecca's+Quotes.txt") {
            do {
                let contentsQUOTES = try String(contentsOf: url)
                var quotes = [String]()
                contentsQUOTES.enumerateLines { (line, stop) -> () in
                    quotes.append(line)
                }
                let quoteamount = UInt32(quotes.count)
                let quotenumber = Int(arc4random_uniform(quoteamount))
                let randomquote = quotes[quotenumber]
                TwitterQuotes.text = randomquote
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        if let url = URL(string: "https://s3.eu-west-2.amazonaws.com/rebeccas.videos/VideoUrls.txt") {
            do {
                let contentsURL = try String(contentsOf: url)
                contentsURL.enumerateLines { (line, stop) -> () in
                    MyData.sharedInstance.videoUrls.append(line)
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }//End of viewDidLoad
    //Social Media Buttons
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! VideosViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

