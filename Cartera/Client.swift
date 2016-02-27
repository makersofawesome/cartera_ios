//
//  Client.swift
//  Cartera
//
//  Created by Vincent Le on 2/26/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit

class Client: NSObject {
    
    var baseUrl: String!
    var apiKey: String!
    init (apiKey: String, url: String) {
        self.baseUrl = url
        self.apiKey = apiKey
    }
    class var sharedClient: Client {
        struct Static {
            static let client = Client(apiKey: "8d09ae83b61d21f830102c97e91d751b", url: "http://api.reimaginebanking.com/")
        }
        return Static.client
    }
    //http://api.reimaginebanking.com/accounts?key=8d09ae83b61d21f830102c97e91d751b
    func request() {
        //        let task = NSURLSession.sharedSession().dataTaskWithURL(baseUrl){
        //            (data, response, error) in
        //            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        //        }
        //        task.resume()
    }
    
    func createRequestUrl(request: String) -> NSURL{
        let url_path = "\(baseUrl)\(request)?key=\(apiKey)"
        return NSURL(string: url_path)!
    }
}