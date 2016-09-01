//
//  Constant.swift
//  SekurItSwift
//
//  Created by admin on 25/08/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import Foundation
protocol ConstantProtocol :class{
    func dataRecieveFromServer(sender: NSData)
}
struct constatntStruct {
    
}
class Constant: NSObject {
    
    static let MAINDOMAIN = "http://api.football-api.com/"
    static let GETCOMPITITION = "2.0/competitions?Authorization=565ec012251f932ea4000001393b4115a8bf4bf551672b0543e35683"
    weak var delegate:ConstantProtocol?
    
    func getDatafromServer(url:NSURL)  {
             
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        urlRequest.timeoutInterval=40
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            self.delegate?.dataRecieveFromServer(data!)
        }
        task.resume()
    }
}
