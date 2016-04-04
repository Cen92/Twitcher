//
//  Game.swift
//  Twitcher
//
//  Created by Cen Breathnach on 17/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import Foundation

class StreamGame: NSObject {
    var viewers:Int?
    var channels:Int?
    var game:Game?
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.viewers   = representation.valueForKeyPath("viewers") as? Int
        self.channels  = representation.valueForKeyPath("channels") as? Int

        if let gamerepresentation = representation.valueForKeyPath("game") as? [String:AnyObject] {
            self.game = Game(response: response, representation: gamerepresentation)
        }
    }
}
