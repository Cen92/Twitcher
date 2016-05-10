//
//  GamesViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 05/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire

class StreamsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var game:Game?
    var streams = [Stream?]()
	
	let originalCellSize = CGSizeMake(546, 337)
	let focusCellSize = CGSizeMake(600, 429)

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.game?.name
        self.fetchStreams()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchStreams() {
        if let game = self.game {
            Alamofire.request(Router.Streams(game.name!)).responseJSON { (response) in
                if let result = response.result.value as? [String:AnyObject] {
                    let streams = Streams(response: response.response!, representation: result)
					if let streams = streams?.streams {
						for stream in streams {
							self.streams.append(stream)
						}
					}
                    self.collectionView.reloadData()
                }
            }
        }
    }

	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		self.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
		self.performSegueWithIdentifier("SegueToStreamViewController", sender: nil)
	}
	
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.streams.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StreamCollectionViewCell", forIndexPath: indexPath)
		return cell
    }
	
	func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
		if let cell  = cell as? StreamCollectionViewCell, model = self.streams[indexPath.row] {
			cell.setup(model)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "SegueToStreamViewController" {
			if let streamViewController = segue.destinationViewController as? StreamViewController {
				if let indexPath = self.collectionView.indexPathsForSelectedItems()?.first {
					streamViewController.stream = self.streams[indexPath.row]
				}
			}
		}
	}
	
	func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
		if let previousItem = context.previouslyFocusedView as? StreamCollectionViewCell {
			UIView.animateWithDuration(0.2, animations: { () -> Void in
				previousItem.streamImage.frame.size = self.originalCellSize
			})
		}
		if let nextItem = context.nextFocusedView as? StreamCollectionViewCell {
			UIView.animateWithDuration(0.2, animations: { () -> Void in
				nextItem.streamImage.frame.size = self.focusCellSize
			})
		}

	}
	
}
