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
    
    static func saveName(compitionModal:CompititionModal) {
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
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
    
    
    
}
