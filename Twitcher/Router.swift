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
    case OAuth(String, String)
    case Games()
    case Streams(String)
    
    var method: Alamofire.Method {
        switch self {
        case .Games():
            return .GET
        case.Streams(_):
            return .GET
        case .OAuth(_,_):
            return .POST
        }
    }
    
    var path: String {
        switch self  {
        case .Games():
            return "/games/top/"
        case .Streams(_):
            return "/streams"
        case .OAuth(_,_):
            return "/oauth2/token"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue("application/vnd.twitchtv.v3+json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue(Router.clientId, forHTTPHeaderField: "client_id")
        switch self {
        case .Games():
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        case .Streams(let gameName):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["game":gameName]).0
        case .OAuth(let params):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["client_id":Router.clientId,"username":params.0, "password":params.1]).0
        default:
            return mutableURLRequest
        }
    }
}
