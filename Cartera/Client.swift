//
//  Client.swift
//  Cartera
//
//  Created by Vincent Le on 2/26/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

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
    func createTransfersWithParams(id: String, params: NSDictionary) {
        
        let params = ["medium":"balance",
            "payee_id":"56c66be6a73e492741507e0e",
            "amount":100,
            "transaction_date":"2016-02-27",
            "status":"pending",
            "description":"first transaction"]
        do {
            let opt = try HTTP.POST(createRequestUrl("accounts/\(id)/transfers"), parameters: params)
            opt.start { response in
                print(response.description)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func createRequestUrl(request: String) -> String{
        print("\(baseUrl)\(request)?key=\(apiKey)")
        return "\(baseUrl)\(request)?key=\(apiKey)"
    }
}