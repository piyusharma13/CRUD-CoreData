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
        createData()
    }


    //MARK: Initilizers

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

