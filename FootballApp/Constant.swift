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
    static let GETCOMPITITION = "2.0/competitions?"
    
    static let AUTHORIZATION = "Authorization=565ec012251f932ea4000001393b4115a8bf4bf551672b0543e35683"
    
    static let GETMATCHES  =  "2.0/matches?"
//    comp_id=%@&from_date=%@&to_date=%@&

    weak var delegate:ConstantProtocol?
    
    func getDatafromServer(url:NSURL)  {
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        urlRequest.timeoutInterval=40
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            print(error?.description)
            if let datas = data{
                self.delegate?.dataRecieveFromServer(datas)
            }
            
        }
        task.resume()
    }
   
    func to_date() ->String {
        
        let current = self.getCurrentDate()
        
        var day =   Int(current.componentsSeparatedByString(".").first!)
        
        var month =   Int(current.componentsSeparatedByString(".")[1])

        var year =   Int(current.componentsSeparatedByString(".").last!)

        
       day = day!+30
        
        if day>=31 {
            
            day=day!-31
            if day==0 {
                day=1
            }
        }
        if month==12 {
            year=year!+1
        }
        month=month!+1
        
        return String(format: "%d.%d.%d",day!,month!,year!)
        
    }

    func getCurrentDate() ->String {
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat="dd.MM.yyyy"
        let dateString = formatter.stringFromDate(date)
        return dateString
    
    }
    
    

}
