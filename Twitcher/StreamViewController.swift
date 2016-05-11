//
//  StreamViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 10/05/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import AVKit
import Alamofire

class StreamViewController: AVPlayerViewController {
	var stream:Stream?
	var accessTokenDict: [String:AnyObject]?
	var streamURLs = [TwitchStreamInfo]()
	
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
				if let accessTokenDict = self.accessTokenDict {
					self.fetchStream(accessTokenDict, completion: { (results) in
						if let results = results {
							self.streamURLs = results
							self.playStream()
						}
					})
				}
			}
		}
	}
	
	func fetchAccessToken(completion:(success:Bool) -> Void) {
		if let stream = self.stream, channel = stream.channel, channelName = channel.name {
			Alamofire.request(Router.StreamToken(channelName)).responseJSON { (response) in
				if let result = response.result.value as? [String:AnyObject] {
					self.accessTokenDict = result
					completion(success: true)
				}
			}
		}
	}
	
	func fetchStream(accessToken:[String:AnyObject], completion:(results:[TwitchStreamInfo]?) -> Void){
		if let stream = self.stream, channel = stream.channel, channelName = channel.name {
			if let sig = accessToken["sig"] as? String, token = accessToken["token"] {
				Alamofire.request(Router.Stream(channelName, [
					"player":"twitchweb",
					"token":token,
					"sig":sig,
					"allow_audio_only":"true",
					"allow_source":"true",
					"type":"any",
					"p":Int(arc4random_uniform(999999))])).responseString(completionHandler: { (response:Response<String, NSError>) in
						switch response.result {
						case .Success(let value):
							let streamURLs = M3U8Parser.M3U8ToStreamInfo(value)
							completion(results: streamURLs)
						case .Failure(let error):
							completion(results: nil)
							print(error)
						}
					})
				
			}
		}
	}
	
	func playStream() {
		if let stream = self.streamURLs.first {
			let asset = AVURLAsset(URL:stream.url)
			let streamItem = AVPlayerItem(asset: asset)
			player = AVPlayer(playerItem: streamItem)
			player!.play()
		}
	}
	
}
