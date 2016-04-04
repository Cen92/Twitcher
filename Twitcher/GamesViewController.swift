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
        return UICollectionViewCell()
    }
}

