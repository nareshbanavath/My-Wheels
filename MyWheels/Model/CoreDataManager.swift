//
//  CoreDataManager.swift
//  MyWheels
//
//  Created by naresh banavath on 26/02/21.
//

import Foundation
import CoreData

enum coreDataEntityNames : String
{
  case rcDetails = "RCDetailsTable"
  case insuranceDetails = "InsuranceTable"
  case pollutionDetails = "PollutionTable"
  case servicingDetails = "ServicingTable"
  case bateryDetails = "BatteryTable"
  case vehicleDetails = "VehicleDetails"
}
class CoreDataManager
{
  static let shared = CoreDataManager()
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentCloudKitContainer = {
    let container = NSPersistentCloudKitContainer(name: "MyWheels")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true

    return container
  }()
  // MARK: - Core Data Saving support
  lazy private var saveManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
  func saveContext () {
    
    let context = persistentContainer.viewContext
    context.automaticallyMergesChangesFromParent = true
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
    
    
  }
  func loadVehiclesData() -> [VehicleDetails]?
  {
      let context = persistentContainer.viewContext
      context.automaticallyMergesChangesFromParent = true
      let request : NSFetchRequest = VehicleDetails.fetchRequest()
      do {
          let vehicleData = try context.fetch(request)
          return vehicleData
      }
      catch{
          print("error fetching data\(error)")
        return nil
      }
  }
  func getManagedObjects<T : NSManagedObject>(fetchRequest : NSFetchRequest<T>) -> [T]?
  {
    do {
      let fetchResult = try persistentContainer.viewContext.fetch(fetchRequest)
//      if fetchResult.isEmpty
//      {
//        return nil
//      }
      return fetchResult
    }catch let err {
      print(err)
      return nil
    }

  }
  func getManagedObjectsForVehicle<T : NSManagedObject>(vehicleEntity : VehicleDetails?,entityName : coreDataEntityNames) ->[T]?
  {
    let fetchRequest = NSFetchRequest<T>(entityName: entityName.rawValue)
    guard let vehicleNo = vehicleEntity?.vehicleNo else {return nil}
    //vehicle relation name 
    let predicate = NSPredicate(format: "vehicle.vehicleNo == %@", vehicleNo)
    fetchRequest.predicate = predicate
    guard let resultArray = self.getManagedObjects(fetchRequest: fetchRequest) else {return nil}
    return resultArray
  }
    func writeCoreDataObjectToCSV(objects: [NSManagedObject], named: String) -> URL? {
        /* We assume that all objects are of the same type */
        guard objects.count > 0 else {
            return nil
        }
        let firstObject = objects[0]
       /////////////// let arr = Array(firstObject.entity.attributesByName.keys)
        let attribs = Array(firstObject.entity.attributesByName.keys)
      let csvHeaderString = (attribs.reduce("",{($0 as String) + "," + $1 }) as NSString).substring(from: 1) + "\n"

        let csvArray = objects.map({object in
          (attribs.map({((object.value(forKey: $0) ?? "NIL") as AnyObject).description}).reduce("",{$0 + "," + $1}) as NSString).substring(from: 1) + "\n"
        })
      let csvString = csvArray.reduce("", +)
        let fileManager = FileManager.default
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let path = documentDir.appendingPathComponent("VehicleData").appendingPathExtension("csv")
        let finalString = csvHeaderString+csvString
        if !fileManager.fileExists(atPath: path.path)
        {
            fileManager.createFile(atPath: path.path, contents: nil, attributes: nil)
        }
        do {
            try finalString.write(to: path, atomically: true, encoding: .utf8)
        }catch let err
        {
            print(err.localizedDescription)
        }
        return path
    }


  
}
