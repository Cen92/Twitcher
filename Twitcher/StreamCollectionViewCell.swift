//
//  StreamCollectionViewCell.swift
//  Twitcher
//
//  Created by Cen Breathnach on 09/05/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire

class StreamCollectionViewCell: UICollectionViewCell {
 
	@IBOutlet weak var streamImage: UIImageView!
	@IBOutlet weak var streamerNameLabel: UILabel!
	@IBOutlet weak var viewersLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	
	var model:Stream?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.streamImage.image = nil
		self.streamerNameLabel.text = nil
		self.viewersLabel.text = nil
		self.nameLabel.text = nil
	}
	
	func setup(model:Stream) {
		self.model = model
		if let model = self.model {
			if let channel = model.channel {
				self.streamerNameLabel.text = channel.name
				self.viewersLabel.text =  "\(model.viewers)"
				let url = NSURL(string: (model.preview?.large)!)
				
				Alamofire.request(NSURLRequest(URL: url!)).responseData({ (response) in
					if let data = response.data {
						self.streamImage.image = UIImage(data: data)
						self.streamImage.contentMode = .ScaleAspectFit
						self.streamImage.userInteractionEnabled = true
						self.streamImage.adjustsImageWhenAncestorFocused = true
					}
				})
			}
			
		}
	}
}
