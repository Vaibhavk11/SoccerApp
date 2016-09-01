//
//  ViewController.swift
//  FootballApp
//
//  Created by admin on 31/08/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import UIKit
class ViewController: UITableViewController,ConstantProtocol {
    
    var compitionModal = [CompititionModal]()
    var filteredCompition = [CompititionModal]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        http://api.football-api.com/2.0/competitions?Authorization=565ec012251f932ea4000001393b4115a8bf4bf551672b0543e35683
        
        self.setupUI()
        let constantManager = Constant()
        constantManager.delegate=self;
        let url = NSURL(string: String (format: "%@%@",Constant.MAINDOMAIN,Constant.GETCOMPITITION))
        constantManager.getDatafromServer(url!)
        
    }
    
    func setupUI()  {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCompition.count
        }
        return compitionModal.count
        
    }
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView .deselectRowAtIndexPath(indexPath, animated: true)
    let cell = tableView .cellForRowAtIndexPath(indexPath) as! CompititionTableViewCell
    if cell.checkBox.isOn() {
        cell.checkBox .setOn(false, animated: false)
        cell.checkBox.hidden=true
    }else{
        cell.checkBox .setOn(true, animated: true)
        cell.checkBox.hidden=false
    }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CompititionTableViewCell
        let compitition: CompititionModal
        
        if searchController.active && searchController.searchBar.text != "" {
            compitition = filteredCompition[indexPath.row]
        } else {
            compitition = compitionModal[indexPath.row]
        }
        
        cell.nameLabel!.text = compitition.name
        cell.regionLabel!.text = compitition.region
        cell.imageHolder?.image=UIImage(named: compitition.name+".jpeg")
        if (cell.imageHolder.image != nil) {
            print("YES")
        }else{
            cell.imageHolder?.image=UIImage(named:"UEFA Champions League.jpeg")
        }
        if cell.checkBox.isOn() {
           
            cell.checkBox .setOn(true, animated: true)
            cell.checkBox.hidden=false
        }else{
            cell.checkBox .setOn(false, animated: false)
            cell.checkBox.hidden=true
        }
        cell.imageHolder?.layer.cornerRadius=((cell.imageHolder?.frame.height)!/2)
        cell.imageHolder?.clipsToBounds=true
        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredCompition = compitionModal.filter({( compitition : CompititionModal) -> Bool in
            return  compitition.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    func dataRecieveFromServer(sender: NSData) {
        
        do{
            let datastring = try NSJSONSerialization.JSONObjectWithData(sender, options: NSJSONReadingOptions.AllowFragments)
            
            
            for dict in datastring as! [AnyObject] {
                
                let compitition = CompititionModal()
                compitition.id = dict .valueForKey("id") as! String
                compitition.name = dict .valueForKey("name") as! String
                compitition.region = dict .valueForKey("region") as! String
                compitionModal.append(compitition)
                print(dict)
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                });
            }
        }
            
        catch{
            print("Error")
            
        }
    }
    
    
}
extension ViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //    _ = searchController.searchBar
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

