//
//  Preview.swift
//  Twitcher
//
//  Created by Cen Breathnach on 05/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class Preview: NSObject {
    var small:String?
    var medium:String?
    var large:String?
    var template:String?
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.large = representation.valueForKeyPath("large") as? String
        self.medium  = representation.valueForKeyPath("medium") as? String
        self.small  = representation.valueForKeyPath("small") as? String
        self.template = representation.valueForKeyPath("template") as? String
    }
}
