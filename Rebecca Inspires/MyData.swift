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
    static let sharedInstance = MyData()
}
