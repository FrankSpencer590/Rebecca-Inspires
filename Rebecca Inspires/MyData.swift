//
//  MyData.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 24/04/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit

class MyData: NSObject {
    var videos = [String]()
    var selectedvideo = "NONE"
    var videoUrls = [String]()
    var selectedUrl = "NONE"
    var loggedin = 3
    var logindetails = ["a@b.com":"apples123"]
    var usernames = ["sammybob"]
    var correctemail = false
    var correctpassword = false
    static let sharedInstance = MyData()
}
