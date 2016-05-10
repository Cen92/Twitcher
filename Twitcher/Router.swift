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
    static let baseURLString = "https://api.twitch.tv/"
	static let usherURLString = "http://usher.twitch.tv/"
    static let clientId = "ewk5nxq5c9jwk0fle8914ydpphif8sz"
	
    case OAuth(String, String)
    case Games()
    case Streams(String)
	case Stream(String, [String:AnyObject])
	case StreamToken(String)
    
    var method: Alamofire.Method {
        switch self {
        case .Games():
            return .GET
        case.Streams(_):
            return .GET
		case .StreamToken(_):
			return .GET
		case .Stream(_, _):
			return .GET
        case .OAuth(_,_):
            return .POST
        }
    }
    
    var path: String {
        switch self  {
        case .Games():
            return "kraken/games/top/"
        case .Streams(_):
            return "kraken/streams"
		case .StreamToken(let string):
			return "/api/channels/\(string)/access_token"
		case .Stream(let channelName, _):
			return "api/channel/hls/\(channelName).m3u8"
        case .OAuth(_,_):
            return "kraken/oauth2/token"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
		var baseURL:String
		switch self {
		case .Stream(_, _):
			baseURL = Router.usherURLString
		default:
			baseURL = Router.baseURLString
		}
        let URL = NSURL(string: baseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue("application/vnd.twitchtv.v3+json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue(Router.clientId, forHTTPHeaderField: "client_id")
        switch self {
        case .Games():
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        case .Streams(let gameName):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["game":gameName]).0
		case .StreamToken(_):
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
		case .Stream(_, let parameters):
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        case .OAuth(let params):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["client_id":Router.clientId,"username":params.0, "password":params.1]).0
        }
    }
}
