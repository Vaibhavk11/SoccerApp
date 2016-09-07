//
//  ViewController.swift
//  FootballApp
//
//  Created by admin on 31/08/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController,ConstantProtocol {
    
    var compitionModal = [CompititionModal]()
    var filteredCompition = [CompititionModal]()
    var cellSelected = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        http://api.football-api.com/2.0/competitions?Authorization=565ec012251f932ea4000001393b4115a8bf4bf551672b0543e35683
        
        self.setupUI()
        
        let constantManager = Constant()
        constantManager.delegate=self;
        let url = NSURL(string: String (format: "%@%@",Constant.MAINDOMAIN,Constant.GETCOMPITITION))
        constantManager.getDatafromServer(url!)
        
        self.tableUpdate()
        
        //if you have more UIViews, use an insertSubview API to place it where needed
        
        //        self.view.backgroundColor=UIColor.init(patternImage: UIImage.init(named: "football-backgrounds-4.jpg")!)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
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
        
        if cellSelected.contains(String(format: "%d",indexPath.row)){
            cellSelected.removeAtIndex(cellSelected.indexOf(String(format: "%d",indexPath.row))!)
        }else{
            cellSelected.append(String(format: "%d",indexPath.row))
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
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
        }else{
            cell.imageHolder?.image=UIImage(named:"UEFA Champions League.jpeg")
        }
        cell.imageHolder?.layer.cornerRadius=((cell.imageHolder?.frame.height)!/2)
        cell.imageHolder?.clipsToBounds=true
        
        if cellSelected.contains(String(format: "%d",indexPath.row)){
            cell.checkBox.hidden=false
            cell.checkBox.setOn(true)
        }else{
            cell.checkBox.hidden=true
            cell.checkBox.setOn(false)
        }
        return cell
        
    }
    
    func setupUI()  {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundView = UIImageView(image: UIImage(named: "football-backgrounds-4.jpg"))
        //        navigationController?.hidesBarsOnSwipe = true
        tableView.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        tableView.backgroundView!.addSubview(blurEffectView)
    }
    
    func tableUpdate()  {
        compitionModal.removeAll()
        let geting = CoreDataController.getData("Compititon")
        
        for comp in geting as [NSManagedObject] {
            let compitition = CompititionModal()
            compitition.id=comp.valueForKey("id") as! String
            compitition.name=comp.valueForKey("name") as! String
            compitition.region=comp.valueForKey("region") as! String
            compitionModal.append(compitition)
        }
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
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
                compitition.id = dict.valueForKey("id") as! String
                compitition.name = dict.valueForKey("name") as! String
                compitition.region = dict.valueForKey("region") as! String
                CoreDataController.saveName(compitition)
                print(dict)
            }
            
            self.tableUpdate()
            
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

