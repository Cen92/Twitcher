//
//  StreamViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 10/05/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire

class StreamViewController: UIViewController {
	var stream:Stream?
	var accessToken: [String:AnyObject]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupStream()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func setupStream() {
		fetchAccessToken { (success) in
			if success {
				if let accessToken = self.accessToken {
					self.fetchStream()
				}
			}
		}
		
	}
	
	func fetchAccessToken(completion:(success:Bool) -> Void) {
		if let stream = self.stream, channel = stream.channel, channelName = channel.name {
			Alamofire.request(Router.StreamToken(channelName)).responseJSON { (response) in
				if let result = response.result.value as? [String:AnyObject] {
					self.accessToken = result
				}
			}
		}
	}
	
	func fetchStream() {
	
	}
}
