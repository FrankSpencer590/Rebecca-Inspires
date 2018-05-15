//
//  VideosViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 21/04/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

let url = NSURL(string: MyData.sharedInstance.selectedUrl)!

class VideosViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
        buy.layer.cornerRadius = 30.0
        buy.layer.masksToBounds = true
        playsample.layer.cornerRadius = 30.0
        playsample.layer.masksToBounds = true
        let background = UIColor(red: 189/255.0, green: 165/255.0, blue: 11/255.0, alpha: 1.0)
        
        view.backgroundColor = background
        //Start of courses from internet
        MyData.sharedInstance.videos.removeAll()
        if let url = URL(string: "https://s3.eu-west-2.amazonaws.com/rebeccas.videos/Rebecca's+Courses.txt") {
            do {
                let contents = try String(contentsOf: url)
                contents.enumerateLines { (line, stop) -> () in
                    MyData.sharedInstance.videos.append(line)
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    
    @IBAction func dismissVideosVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Play(_ sender: Any) {
        playVideo(url: url)
    }
    
    @IBAction func buypressed(_ sender: Any) {
        //Animation
        let theButton = sender as! UIButton
        
        let bounds = theButton.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (success:Bool) in
            if success {
                
                UIView.animate(withDuration: 0.5, animations: {
                    theButton.bounds = bounds
                })
                
            }
        }
        //Rest of Buy Button code:
    }
    
    
    
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var playsample: UIButton!
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return MyData.sharedInstance.videos[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return MyData.sharedInstance.videos.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        MyData.sharedInstance.selectedvideo = MyData.sharedInstance.videos[row]
        MyData.sharedInstance.selectedUrl = MyData.sharedInstance.videoUrls[row]
        playsample.isHidden = false
        buy.isHidden = false
        print("Selected:",MyData.sharedInstance.videos[row])
    }
    func playVideo(url: NSURL){
        let player = AVPlayer(url: url as URL)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        
        player.play()
    }
    
}
