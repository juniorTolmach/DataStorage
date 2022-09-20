//
//  RealmManager.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 19.09.2022.
//

import RealmSwift
import Foundation

class RealmManager {
    
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func getDatabaseUrl() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    private init() {}
    
    // MARK: - Task List
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save (_ taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    
    // MARK: - Tasks
    func save(_ task: Task, to taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
        
    }
    
    func delete(_ task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func rename(_ task: Task, to name: String, withNote note: String) {
        write {
            task.name = name
            task.note = note
        }
    }
    
    func done(task: Task) {
        write {
            task.isComplete.toggle()
        }
    }
    
    private func write(comletion: () -> Void) {
        do {
            try realm.write {
                comletion()
            }
        } catch {
            print(error)
        }
    }
}
