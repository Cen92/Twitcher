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
    var streams = [AnyObject]()

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
                    self.collectionView.reloadData()
                }
            }
        }
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.streams.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}