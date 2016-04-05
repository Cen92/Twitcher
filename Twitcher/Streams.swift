//
//  Streams.swift
//  Twitcher
//
//  Created by Cen Breathnach on 05/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class Streams: NSObject {
    var _total:Int?
    var streams = [Stream]()
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self._total   = representation.valueForKeyPath("_total") as? Int
        
        if let streamRepresentation = representation.valueForKeyPath("streams") as? [[String:AnyObject]] {
            for object in streamRepresentation {
                let stream = Stream(response: response, representation: object)
                streams.append(stream!)
            }
        }
    }
}
