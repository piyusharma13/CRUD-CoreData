//
//  ViewController.swift
//  CRUD
//
//  Created by Piyush Sharma on 19/10/18.
//  Copyright © 2018 Piyush Sharma. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //MARK: View Life-Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //createData()
        //retrieveData()
        //updateData()
        //deleteData()
    }


    //MARK: Initilizers
    
    func deleteData()
    {
        /*
         For delete record first we have to find object which we want to delete by fetchRequest. then follow below few steps for delete record
         
         1. Prepare the request with predicate for the entity (User in our example)
         2. Fetch record and which we want to delete
         3. And make context.delete(object) call
         */
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Creating context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "age = 1")
        
        do {
            let persons = try managedContext.fetch(fetchRequest)
            
            let fetchedPerson = persons.last as! NSManagedObject

            managedContext.delete(fetchedPerson)
            
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print("Unable to delete data due to \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Unable to fetch data due to \(error.userInfo)")
        }
        
    }
    
    func updateData()
    {
        /*
         For update record first we have to fetch/Retrieve data with predicate as same as above Retrieve data process. Then below few steps to follow
         
         Prepare the request with predicate for the entity (User in our example)
         Fetch record and Set New value with key
         And Last Save context same as create data.
         */
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Creating context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "age = 2")
        
        do {
            let persons = try managedContext.fetch(fetchRequest)
            
            let fetchedPerson = persons.last as! NSManagedObject
            fetchedPerson.setValue("Piyush", forKey: "name")
            
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print("Unable to update data due to \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Unable to fetch data due to \(error.userInfo)")
        }
    }
    
    func retrieveData()
    {
        /*
         The process of fetching the saved data is very easy as well. It has the following task
         
         1. Prepare the request of type NSFetchRequest for the entity (User in our example)
         2. if required use predicate for filter data
         3. Fetch the result from context in the form of array of [NSManagedObject]
         4. Iterate through an array to get value for the specific key
         */
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        //Creating context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
//        fetchRequest.fetchLimit = 100
//        fetchRequest.predicate = NSPredicate.init(format: "age = 2")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "age", ascending: false)]
        
        do {
            let persons = try managedContext.fetch(fetchRequest)
            
            for person in persons as! [NSManagedObject] {
                print(person.value(forKey:"name") as! String)
            }
        } catch  {
            print("Failure")
        }
    }
    

    func createData()
    {
        
        /*
         The process of adding the records to Core Data has following tasks
         
         1. Refer to persistentContainer from appdelegate
         2. Create the context from persistentContainer
         3. Create an entity with User
         4. Create new record with this User Entity
         5. Set values for the records for each key
         */
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Creating context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Creating Entity
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        //Populate data
        for a in 1...3
        {
            let person = NSManagedObject.init(entity: personEntity, insertInto: managedContext)
            person.setValue("Person\(a)", forKey: "name")
            person.setValue(a, forKey: "age")
            
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print("Unable to save data due to \(error.userInfo)")
            }
        }
    }
    
    
}

