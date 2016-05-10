//
//  StreamGameCollectionViewCell.swift
//  Twitcher
//
//  Created by Cen Breathnach on 04/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire

class StreamGameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var viewerCountLabel: UILabel!
    
    var model:StreamGame?
    
    func setupWithContent(streamGame:StreamGame) {
        self.model = streamGame
        if let model = self.model {
            self.gameNameLabel.text = model.game?.name
            self.viewerCountLabel.text = "\(model.viewers!) viewers"
            self.backgroundImage.userInteractionEnabled = true
            self.backgroundImage.adjustsImageWhenAncestorFocused = true
            let url = NSURL(string: (model.game?.box?.large)!)
            
            Alamofire.request(NSURLRequest(URL: url!)).responseData({ (response) in
                if let data = response.data {
                  self.backgroundImage.image = UIImage(data: data)
					self.backgroundImage.contentMode = .ScaleAspectFit
                }
            })
        }
    }
}
