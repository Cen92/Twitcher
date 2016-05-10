//
//  FirstViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 15/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire

class GamesViewController: UIViewController {
    
    var streamGames = [StreamGame]()
    let originalCellSize = CGSizeMake(272, 380)
    let focusCellSize = CGSizeMake(282, 390)
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchGames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GamesViewController {
    private func fetchGames() {
        Alamofire.request(Router.Games()).responseJSON { (response) in
            if let result = response.result.value as? [String:AnyObject] {
                if let top = result["top"] as? [AnyObject] {
                    for object in top {
                        if let streamGame = StreamGame(response: response.response!, representation: object){
                            self.streamGames.append(streamGame)
                        }
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.streamGames.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("StreamGameCollectionViewCell", forIndexPath: indexPath) as? StreamGameCollectionViewCell
        let model = streamGames[indexPath.row]
        cell!.setupWithContent(model)
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = self.streamGames[indexPath.row]
        let viewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("StreamsViewController") as? StreamsViewController
        viewController?.game = model.game
        
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let previousItem = context.previouslyFocusedView as? StreamGameCollectionViewCell {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                previousItem.backgroundImage.frame.size = self.originalCellSize
            })
        }
        if let nextItem = context.nextFocusedView as? StreamGameCollectionViewCell {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                nextItem.backgroundImage.frame.size = self.focusCellSize
            })
        }
    }
}

