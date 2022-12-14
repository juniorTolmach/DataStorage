//
//  CoreDataManager.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 12.09.2022.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "TaskLiskCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    func fetchData(completion: (Result<[TaskCoreData],Error>) -> Void) {
        let fetchRequest = TaskCoreData.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func save(_ taskName: String, completion: (TaskCoreData) -> Void) {
        let task = TaskCoreData(context: viewContext)
        task.title = taskName
        completion(task)
        saveContext()
    }
    func edit(_ task: TaskCoreData, newName: String) {
        task.title = newName
        saveContext()
    }
    
    func delete(_ task: TaskCoreData) {
        viewContext.delete(task)
        saveContext()
    }
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

