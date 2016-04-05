//
//  Stream.swift
//  Twitcher
//
//  Created by Cen Breathnach on 05/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class Stream: NSObject {
    
    var game:String?
    var viewers:Int?
    var average_fps:Float?
    var delay:Int?
    var video_height:Int?
    var is_playlist:Bool?
    var created_at:String?
    var _id:Int?
    var channel:Channel?
    var preview:Preview?
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.game = representation.valueForKeyPath("game") as? String
        self.viewers = representation.valueForKeyPath("viewers") as? Int
        self.average_fps = representation.valueForKeyPath("average_fps") as? Float
        self.delay = representation.valueForKeyPath("delay") as? Int
        self.video_height = representation.valueForKeyPath("video_height") as? Int
        self.is_playlist = representation.valueForKeyPath("is_playlist") as? Bool
        self.created_at = representation.valueForKeyPath("created_at") as? String
        self._id = representation.valueForKeyPath("_id") as? Int
        
        if let channelRepresentation = representation.valueForKeyPath("channel") as? [String:AnyObject] {
            self.channel = Channel(response: response, representation: channelRepresentation)
        }

        if let previewRepresentation = representation.valueForKeyPath("preview") as? [String:AnyObject] {
            self.preview = Preview(response: response, representation: previewRepresentation)
        }
    }
}
