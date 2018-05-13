//
//  ViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 21/04/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TwitterQuotes: UILabel!
    let bucketName = "randomlistofquotes"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CHANGE HERE")
        let background = UIColor(red: 90/255.0, green: 75/255.0, blue: 69/255.0, alpha: 1.0)
        view.backgroundColor = background
        
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
    @IBAction func TwitterButton(_ sender: Any) {
        if let url = URL(string: "https://twitter.com/Rebeccainspires/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func InstagramButton(_ sender: Any) {
        if let url = URL(string: "https://www.instagram.com/rebeccainspires/?hl=en") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func YoutubeButton(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/channel/UCDSlzoY9sLzquSkhZ0TFZYA") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func FacebookButton(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/RebeccaInspires") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

