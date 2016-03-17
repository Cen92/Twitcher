//
//  Router.swift
//  Twitcher
//
//  Created by Cen Breathnach on 16/03/2016.
//  Copyright © 2016 Cen Breathnach. All rights reserved.
//
import UIKit
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://api.twitch.tv/kraken"
    static let clientId = "ewk5nxq5c9jwk0fle8914ydpphif8sz"
    case Games()
    
    var method: Alamofire.Method {
        switch self {
        case .Games():
            return .GET
        }
    }
    
    var path: String {
        switch self  {
        case .Games():
            return "/games/top/"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue("application/vnd.twitchtv.v3+json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue(Router.clientId, forHTTPHeaderField: "Client-ID")
        switch self {
        case .Games():
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        default:
            return mutableURLRequest
        }
    }
}
