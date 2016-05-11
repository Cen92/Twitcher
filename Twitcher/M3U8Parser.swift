//
//  M3U8Parser.swift
//  Twitcher
//
//  Created by Cen Breathnach on 11/05/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit

class M3U8Parser: NSObject {	
	class func M3U8ToStreamInfo(input:String) -> [TwitchStreamInfo] {
		let components = input.componentsSeparatedByString("\n")
		var results = [TwitchStreamInfo]()
		for component in components {
			if component.hasPrefix("http://") {
				results.append(TwitchStreamInfo(url: NSURL(string: component)!))
			}
		}
		return results
	}
}
