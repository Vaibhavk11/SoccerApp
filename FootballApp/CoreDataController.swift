//
//  CoreDataController.swift
//  FootballApp
//
//  Created by admin on 05/09/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: NSObject {
    
    var people = [NSManagedObject]()
    
    static func saveData(dict:NSDictionary)  {
        
    }
    
    static  func getData(dict:String)->[NSManagedObject]  {
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: dict)
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [NSManagedObject()]
    }
    static  func deleteData(dict:String) {
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: dict)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
    }
    
    static func saveName(compitionModal:CompititionModal) {
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Compititon")
        fetchRequest.predicate=NSPredicate(format: "id contains[c] "+compitionModal.id)
        
        //        [request setResultType:NSDictionaryResultType];
        //        [request setReturnsDistinctResults:YES];
        //        [request setPropertiesToFetch:@[@"<#Attribute name#>"]];
        //
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let moResult = results as! [NSManagedObject]
            
            if let tryResulet = moResult.first?.valueForKey("id"){
                if tryResulet as! String==compitionModal.id{
                    
                    return
                }else{
                    
                    let entity =  NSEntityDescription.entityForName("Compititon",
                                                                    inManagedObjectContext:managedContext)
                    
                    let person = NSManagedObject(entity: entity!,
                                                 insertIntoManagedObjectContext: managedContext)
                    
                    
                    person.setValue(compitionModal.id, forKey: "id")
                    person.setValue(compitionModal.name, forKey: "name")
                    person.setValue(compitionModal.region, forKey: "region")
                    
                    do {
                        try managedContext.save()
                        
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    
                    
                }
            }else{
                
                let entity =  NSEntityDescription.entityForName("Compititon",
                                                                inManagedObjectContext:managedContext)
                
                let person = NSManagedObject(entity: entity!,
                                             insertIntoManagedObjectContext: managedContext)
                
                
                person.setValue(compitionModal.id, forKey: "id")
                person.setValue(compitionModal.name, forKey: "name")
                person.setValue(compitionModal.region, forKey: "region")
                
                do {
                    try managedContext.save()
                    
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
