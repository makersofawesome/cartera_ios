//
//  Client.swift
//  Cartera
//
//  Created by Vincent Le on 2/26/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSONg

class Client: NSObject {//NSEClient {
    
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
    func getAccounts() -> JSON{
        var data = NSData()
        do {
            let opt = try HTTP.GET(createRequestUrl("accounts"))
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                data = response.data
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        return JSON(data: data)
    }
    func getAccountById(id: String) -> JSON{
        var data = NSData()
        do {
            let opt = try HTTP.GET(createRequestUrl("accounts/\(id)"))
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                data = response.data
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        return JSON(data: data)
    }
    func getTransfersFromAccountId(id: String) -> JSON{
        var data = NSData()
        do {
            let opt = try HTTP.GET(createRequestUrl("accounts/\(id)/transfers"))
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                data = response.data
                print(JSON(data: data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        return JSON(data: data)
    }
    func getTransfersFromTransferId(id: String) -> JSON{
        var data = NSData()
        do {
            let opt = try HTTP.GET(createRequestUrl("transfers/\(id)"))
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                data = response.data
                print(JSON(data: data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        return JSON(data: data)
    }
    func createTransferWithParams(id: String, ) {
        
        let requestDictionary = [
            "medium": "balance",
            "payee_id": "56c66be6a73e492741507e0c",
            "amount": 1,
            "transaction_date": "2016-02-27",
            "status": "pending",
            "description": "string"
        ]
        
        
        let url: NSURL = NSURL(string: createRequestUrl("accounts/\(id)/transfers"))!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(requestDictionary, options: [])
        print(NSString(data: request.HTTPBody!, encoding:NSUTF8StringEncoding)!)
        
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            if response != nil{
                do {
                    let parsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    print(parsed)
                }
                catch let error as NSError {
                    print("A JSON parsing error occurred, here are the details:\n \(error)")
                }
            }
            else{
                print("response null from metrics");
            }
        })
    }
    
    func createRequestUrl(request: String) -> String{
        return "\(baseUrl)\(request)?key=\(apiKey)"
    }
}