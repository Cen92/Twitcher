//
//  GamesViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 05/04/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import Alamofire

class GamesViewController: UIViewController {
    
    var game:Game?

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
            Alamofire.request(<#T##URLRequest: URLRequestConvertible##URLRequestConvertible#>)
        }
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
