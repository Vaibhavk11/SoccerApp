//
//  MatchesViewController.swift
//  FootballApp
//
//  Created by admin on 07/09/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController,ConstantProtocol,UITableViewDelegate,UITableViewDataSource {
    
    let ud = NSUserDefaults.standardUserDefaults()
    var matches = NSMutableArray()
    var matches1 = NSMutableArray()
    var sets = NSMutableSet()
    let  tempDict = NSMutableDictionary()


    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let constantManager = Constant()
        constantManager.delegate=self;
        print(NSUserDefaults.standardUserDefaults().objectForKey("userSelect"))
        if let selected = NSUserDefaults.standardUserDefaults().objectForKey("userSelect") {
              print(selected)
              print(constantManager.getCurrentDate())
            print(constantManager.to_date())
        
        let url = NSURL(string: String (format: "%@%@comp_id=%@&from_date=%@&to_date=%@&%@",Constant.MAINDOMAIN,Constant.GETMATCHES,selected as! String,constantManager.getCurrentDate(),constantManager.to_date() ,Constant.AUTHORIZATION))
        print("Url  " ,url!)
        constantManager.getDatafromServer(url!)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return tempDict.allKeys.count
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arr = tempDict.allKeys
       
        return (tempDict.objectForKey(arr[section]) as! [AnyObject]).count

    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MatchesTableViewCell
        
        let arr = tempDict.allKeys
        cell.homeTeam!.text=((tempDict.objectForKey(arr[indexPath.section])as! [AnyObject])[indexPath.row] as! MatcheModel).localteam_name
        cell.awayTeam!.text=((tempDict.objectForKey(arr[indexPath.section])as! [AnyObject])[indexPath.row] as! MatcheModel).visitorteam_name
        cell.matchTime!.text=((tempDict.objectForKey(arr[indexPath.section])as! [AnyObject])[indexPath.row] as! MatcheModel).time
        
        return cell
        
    }
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tempDict.allKeys[section] as? String
    }
    
    func dataRecieveFromServer(sender: NSData) {
        do{
            let datastring = try NSJSONSerialization.JSONObjectWithData(sender, options: NSJSONReadingOptions.AllowFragments)
            
            matches.removeAllObjects()
            var internalArray = [AnyObject]()
            
            for dict in datastring as! [NSDictionary]  {
                let matchModel = MatcheModel()
                matchModel.comp_id = dict.valueForKey("comp_id") as! String
                matchModel.formatted_date = dict.valueForKey("formatted_date") as! String
                matchModel.matchId = dict.valueForKey("id") as! String
                matchModel.localteam_id = dict.valueForKey("localteam_id") as! String
                matchModel.visitorteam_id = dict.valueForKey("visitorteam_id") as! String
                matchModel.time = dict.valueForKey("time") as! String
                matchModel.status = dict.valueForKey("status") as! String
                matchModel.week = dict.valueForKey("week") as! String
                matchModel.localteam_name = dict.valueForKey("localteam_name") as! String
                matchModel.visitorteam_name = dict.valueForKey("visitorteam_name") as! String
              
                
                internalArray.append(matchModel)
                print("before === %@",matchModel.formatted_date)
                
                if (tempDict.objectForKey(matchModel.formatted_date) != nil) {
                    
                    var tempint = tempDict.objectForKey(matchModel.formatted_date) as! [AnyObject]
                    tempint.appendContentsOf(internalArray)
//                    tempint.appendConten tsOf()
                   let srt = NSSet(array: tempint)
                    
                    tempDict.setObject(srt.allObjects , forKey: matchModel.formatted_date)
                    internalArray.removeAll()
                    print("If  === %@",matchModel.formatted_date)
                }else{
                    print("Else === %@",matchModel.formatted_date)
                    tempDict.setObject(internalArray, forKey: matchModel.formatted_date)
                }
                
            }
            print(tempDict)
            
         
            dispatch_async(dispatch_get_main_queue(),{
                self.table.reloadData()
            })
            
        }
        catch{
            print("Error")
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
