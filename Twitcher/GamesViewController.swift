//
//  FirstViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 15/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GamesViewController: UIViewController {
    
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
        Alamofire.request(Router.Games()).responseData { (response) -> Void in
            if let data = response.result.value {
                let json = JSON(data: data)
                print(json)
            }
        }
    }
}

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

