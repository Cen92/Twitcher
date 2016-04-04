//
//  TestViewController.swift
//  Twitcher
//
//  Created by Cen Breathnach on 17/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import SwiftyJSON

class TestViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestOAuthToken()
//        self.addStream()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestOAuthToken(){
        Alamofire.request(Router.OAuth("centest92", "D3llsmells")).responseData { (response) -> Void in
            if let response = response.result.value {
                let json = JSON(data: response)
                print(json)
            }
        }
    }
    
    func addStream() {
        
        
        player = AVPlayer(URL: NSURL(string: "https://www.twitch.tv/izakooo")!)
        player?.play()
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
