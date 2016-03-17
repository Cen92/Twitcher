//
//  Box.swift
//  Twitcher
//
//  Created by Cen Breathnach on 17/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class Box: NSObject {
    var large:String?
    var medium:String?
    var small:String?
    var template:String?
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.large = representation.valueForKeyPath("large") as? String
        self.medium  = representation.valueForKeyPath("medium") as? String
        self.small  = representation.valueForKeyPath("small") as? String
        self.template = representation.valueForKeyPath("template") as? String
    }
}
