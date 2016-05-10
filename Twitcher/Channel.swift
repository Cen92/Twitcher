//
//  Channel.swift
//  Twitcher
//
//  Created by Cen Breathnach on 05/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class Channel: NSObject {
    
    var mature:Bool?
    var status:String?
    var broadcaster_language:String?
    var display_name:String?
    var game:String?
    var delay:AnyObject?
    var language:String?
    var _id:Int?
    var name:String?
    var created_at:String?
    var updated_at:String?
    var logo:String?
    var banner:String?
    var video_banner:String?
    var background:String?
    var profile_banner:String?
    var profile_banner_background_color:String?
    var partner:Bool?
    var url:String?
    var views:Int?
    var followers:Int?
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.mature = representation.valueForKeyPath("mature") as? Bool
        self.status = representation.valueForKeyPath("status") as? String
        self.broadcaster_language = representation.valueForKeyPath("broadcaster_language") as? String
        self.display_name = representation.valueForKeyPath("display_name") as? String
        self.game = representation.valueForKeyPath("game") as? String
        self.language = representation.valueForKeyPath("language") as? String
        self._id = representation.valueForKeyPath("_id") as? Int
        self.name = representation.valueForKeyPath("name") as? String
        self.created_at = representation.valueForKeyPath("created_at") as? String
        self.updated_at = representation.valueForKeyPath("updated_at") as? String
        self.logo = representation.valueForKeyPath("logo") as? String
        self.banner = representation.valueForKeyPath("banner") as? String
        self.video_banner = representation.valueForKeyPath("video_banner") as? String
        self.background = representation.valueForKeyPath("background") as? String
        self.profile_banner = representation.valueForKeyPath("profile_banner") as? String
        self.profile_banner_background_color = representation.valueForKeyPath("profile_banner_background_color") as? String
        self.partner = representation.valueForKeyPath("partner") as? Bool
        self.url = representation.valueForKeyPath("url") as? String
        self.views = representation.valueForKeyPath("views") as? Int
        self.followers = representation.valueForKeyPath("followers") as? Int
    }
}
