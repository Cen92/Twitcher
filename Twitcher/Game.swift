//
//  Game.swift
//  Twitcher
//
//  Created by Cen Breathnach on 17/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class Game: NSObject {
    var name:String?
    var id:Int?
    var giantbomb_id:Int?
    var box:Box?
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.name   = representation.valueForKeyPath("name") as? String
        self.id  = representation.valueForKeyPath("id") as? Int
        self.giantbomb_id  = representation.valueForKeyPath("giantbomb_id") as? Int
        
        if let boxRepresentation = representation.valueForKeyPath("box") as? [String:AnyObject] {
            self.box = Box.init(response: response, representation:boxRepresentation)
        }
    }
}
